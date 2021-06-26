//
//  ViewController.swift
//  Project2
//
//  Created by Jamie Brannan on 18/06/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

class ViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  // MARK: - Properties
  var countries = [String]()
  var score = 0
  var highScore: Int = 0
  var correctAnswer = 0
  var round = 0
  var isNewHighScore: Bool = false
  let defaults = UserDefaults.standard
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
 
    highScore == defaults.integer(forKey: "highScore")

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(checkScore))
    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

    setUpFlagButtons()
    askQuestion()
  }

  // MARK: - Game Mechanics
  func askQuestion(action: UIAlertAction! = nil) {
    countries.shuffle()
    /**
     Correct answer must be randomly one of the three chosen to display
     Set it here, then have the title be the name of it uppercased.
     */
    correctAnswer = Int.random(in: 0...2)
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    title = countries[correctAnswer].uppercased() + ". \(score) pts."
    round += 1
  }
  
  func roundAlert(title: String, countrySelected: Int) {
    let countrySelectedName = countries[countrySelected]
    let ac = UIAlertController(title: title, message: "That was the flag of \(countrySelectedName.capitalizingFirstLetter()). Your round \(round) score is \(score)", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
    present(ac, animated: true)
  }

  func finalScoreAlert() {
    let finalScoreAlert = UIAlertController(title: "✌️Congrats", message: "You've reached round \(round) of 10. Your final score is \(score)", preferredStyle: .alert)
    finalScoreAlert.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
    present(finalScoreAlert, animated: true)
    resetGame()
  }
  
  func equalScoreAlert() {
    let finalScoreAlert = UIAlertController(title: "Wow 😳", message: "You've matched the high score at \(score)!", preferredStyle: .alert)
    finalScoreAlert.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
    present(finalScoreAlert, animated: true)
    resetGame()
  }

  
  func newHighScoreAlert() {
    let finalScoreAlert = UIAlertController(title: "🥳🥂", message: "You've beaten the high score with \(score) points!", preferredStyle: .alert)
    finalScoreAlert.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
    present(finalScoreAlert, animated: true)
    resetGame()
  }

  func setUpFlagButtons(){
    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1
    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor
  }
  
  func resetGame() {
    round = 0
    score = 0
    highScore = defaults.integer(forKey: "highScore")
  }

  func saveHighScore() {
    defaults.set(score, forKey: "highScore")
  }
  // MARK: - Actions
  @IBAction func buttonTapped(_ sender: UIButton) {
    var resultTitle: String
    if sender.tag == correctAnswer {
      resultTitle = "Correct"
      score += 1
    } else {
      resultTitle = "Wrong"
      score -= 1
    }
    if round == 10 {
      if highScore < score {
        saveHighScore()
        newHighScoreAlert()
      } else if highScore == score {
        equalScoreAlert()
      } else {
        finalScoreAlert()
      }
    } else {
      roundAlert(title: resultTitle, countrySelected: sender.tag)
    }
  }

  @objc func checkScore() {
    print("score check")
    let scoreCheckAlert = UIAlertController(title: "Current Score Tally", message: "You currently have \(score) points and \(10-round) rounds remaining", preferredStyle: .alert)
    scoreCheckAlert.addAction(UIAlertAction(title: "Return", style: .default, handler: .none))
    present(scoreCheckAlert, animated: true)
  }
}


