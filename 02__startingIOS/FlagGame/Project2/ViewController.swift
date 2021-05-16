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
  
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  var countries = [String]()
  var score = 0
  var correctAnswer = 0
  var round = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(checkScore))
    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1

    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor
    
    askQuestion()
  }
  
  /// Callup flags based on their names `UIImage(named: <array item>)`
  /// closure as a parameter `nil` that way we don't need to call it
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
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    /// title of the alert card
    UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: [], animations: {
      sender.transform = CGAffineTransform(scaleX: 2, y: 2)
      sender.transform = .identity
    }) { finished in
      var resultTitle: String
      if sender.tag == self.correctAnswer {
        resultTitle = "Correct"
        self.score += 1
        self.roundAlert(title: resultTitle, countrySelected: sender.tag)
      } else {
        resultTitle = "Wrong"
        self.score -= 1
        self.roundAlert(title: resultTitle, countrySelected: sender.tag)
      }

      if self.round == 10 {
        self.finalScoreAlert()
      } else {
        return
      }
    }
  }

  func roundAlert(title: String, countrySelected: Int) {
    let countrySelectedName = countries[countrySelected]

    /// create an alert controler
    let ac = UIAlertController(title: title, message: "That was the flag of \(countrySelectedName.capitalizingFirstLetter()). Your round \(round) score is \(score)", preferredStyle: .alert)

    /// action bottoms on the bottom of the alert controller
    ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

    /// present the alert controller we just created with animations
    present(ac, animated: true)
  }

  func finalScoreAlert() {
    let finalScoreAlert = UIAlertController(title: "Congrats", message: "You've reached round \(round) of 10. Your final score is \(score)", preferredStyle: .alert)
    finalScoreAlert.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
    present(finalScoreAlert, animated: true)
    round = 0
    score = 0
  }

  @objc func checkScore() {
    print("score check")
    let scoreCheckAlert = UIAlertController(title: "Current Score Tally", message: "You currently have \(score) points.", preferredStyle: .alert)
    scoreCheckAlert.addAction(UIAlertAction(title: "Return", style: .default, handler: .none))
    present(scoreCheckAlert, animated: true)
  }
}


