//
//  ViewController.swift
//  HundredHangman
//
//  Created by Jamie Brannan on 14/01/2021.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - PROPS

  // MARK: UI Elements

  var buttonsContainer = UIView()
  var targetWordLabel: UILabel!
  var letterButtons = [UIButton]()

  // MARK: Data Storage

  /// Game words
  var words = [String]()
  /// Target word of the round
  var targetWord = ""
  var correctLetters: [String] = []
  var guessCounter = 0
  var score = 0
  
  // MARK: - LIFECYCLE

  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    setUpUi()
    loadGameWord()
    view.addSubview(buttonsContainer)
    view.addSubview(targetWordLabel)
    implementConstraints()
    title = "Hangman Challenge"
    navigationItem.prompt = "100 Days of Swift"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetGame))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(presentScore))
  }

  // MARK: - SETUP

  // MARK: UI
  func setUpUi() {
    setUpTargetWord()
    setUpButtonsContainer()
    setUpAlphabetButtons()
  }

  func setUpTargetWord() {
    targetWordLabel = UILabel()
    targetWordLabel.translatesAutoresizingMaskIntoConstraints = false
    targetWordLabel.text = "Testestest"
    targetWordLabel.font = UIFont.systemFont(ofSize: 40)
  }
 
  func setUpButtonsContainer() {
    buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
    buttonsContainer.layer.borderWidth = 1
    buttonsContainer.layer.borderColor = UIColor.lightGray.cgColor
    buttonsContainer.layer.cornerRadius = 25
  }

  func implementConstraints() {
    NSLayoutConstraint.activate([
      targetWordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      targetWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonsContainer.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),
      buttonsContainer.heightAnchor.constraint(equalToConstant: 248),
      buttonsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonsContainer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
    ])
  }

  func setUpAlphabetButtons() {
    /// set some values for the width and height of each button
    let letterButtonWidth = 108
    let letterButtonHeight = 60

    for row in 0..<4 {
      for col in 0..<8{
        /// create a new button and give it a big font size
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        letterButton.adjustsImageWhenDisabled = true
        letterButton.setTitleColor(UIColor.blue, for: .normal)
        letterButton.setTitleColor(UIColor.gray, for: .disabled)
        getAlphabetButtons()
        
        /// calculate the frame of this button using its column and row
        let frame = CGRect(x: col * letterButtonWidth, y: row * letterButtonHeight, width: letterButtonWidth, height: letterButtonHeight)
        letterButton.frame = frame

        /// add it to the buttons view
        buttonsContainer.addSubview(letterButton)

        /// and also to our letterButtons array
        letterButtons.append(letterButton)
        letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
      }
    }
  }

  // MARK: Load data

  func getAlphabetButtons() {
    if let alphabetFileURL = Bundle.main.url(forResource: "alphabet", withExtension: "txt") {
      if let letterButtonContents = try? String(contentsOf: alphabetFileURL) {
        let alphabet = letterButtonContents.components(separatedBy: "\n")
        if alphabet.count == letterButtons.count {
          for i in 0 ..< alphabet.count {
            letterButtons[i].setTitle(alphabet[i], for: .normal)
          }
        }
      }
    }
  }

  func loadGameWord() {
    if let wordsFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {

      /// get words that are separated by a carriage return
      if let gameContents = try? String(contentsOf: wordsFileURL){
        var words = gameContents.components(separatedBy: "\n")
        words.shuffle()
        targetWord = words[0]
        print("\(targetWord)")
      }
    }
    targetWordLabel.text = String(repeating: "_ ", count: targetWord.count).trimmingCharacters(in: .whitespaces)
  }

  @objc func loadNewGame(action: UIAlertAction) {
    loadGameWord()
    correctLetters = []
    guessCounter = 0
    letterButtons = [UIButton]()
    setUpAlphabetButtons()
  }

  @objc func resetGame() {
    loadGameWord()
    correctLetters = []
    guessCounter = 0
    score = 0
    letterButtons = [UIButton]()
    setUpAlphabetButtons()
  }
  // MARK: - GAME MECHANICS

  func obscureTargetWordForLabel() {
    var updatedLabel = ""
    var wordComplete = true

    for letter in targetWord {
      let strLetter = String(letter)
      if correctLetters.contains(strLetter) {
        updatedLabel += strLetter
      } else {
        updatedLabel += "_ "
        wordComplete = false
      }
    }
    targetWordLabel.text = updatedLabel

    if wordComplete {
      score += 1
      presentWinMessage()
    }
  }

// MARK: Button presses

  @objc func letterTapped(_ sender: UIButton) {
    guard let sentLetter = sender.titleLabel?.text else { return }
    sender.isEnabled = false

    if targetWord.contains(sentLetter) {
      correctLetters.append(sentLetter)
      recordCorrectGuess()
    } else {
      recordIncorrectGuess()
    }
  }

  func recordCorrectGuess() {
    obscureTargetWordForLabel()
    print("CORRECT")
  }

  func recordIncorrectGuess() {
    if guessCounter < 6 {
      guessCounter += 1
    } else {
      presentLossMessage()
    }
    print("INCORRECT")
  }

  // MARK: Messages
  func presentWinMessage() {
    let ac = UIAlertController(title: "Congrats!", message: "You guessed right. \n You found the word : \(targetWord) \n You have \(score) points.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Let's go again!", style: .default, handler: loadNewGame))
    ac.addAction(UIAlertAction(title: "Cancel", style: .default))
    present(ac, animated: true)
  }

  func presentLossMessage() {
    let ac = UIAlertController(title: "Sorry", message: "Great effort, but you fell short. \n The answer is : \(targetWord)", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: loadNewGame))
    ac.addAction(UIAlertAction(title: "I'm done", style: .default))
    present(ac, animated: true)
  }

  @objc func presentScore() {
    let ac = UIAlertController(title: "Keep going!", message: "You have \(score) points.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .default))
    present(ac, animated: true)
  }
}
