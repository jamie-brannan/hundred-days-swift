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
  var words = [String]()
  var targetWord = ""
  var usedLetters: [String] = []
  var availableGuessLetters: [String] = []
  
  
  // MARK: - LIFE
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    setUpUi()
    loadGame()
    view.addSubview(buttonsContainer)
    view.addSubview(targetWordLabel)
    NSLayoutConstraint.activate([
      targetWordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      targetWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      buttonsContainer.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),
      buttonsContainer.heightAnchor.constraint(equalToConstant: 282),
      buttonsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonsContainer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
      //      buttonsContainer.bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    ])
    
    /// set some values for the width and height of each button
    let letterButtonWidth = 124
    let letterButtonHeight = 54
    
    for row in 0..<6 {
      for col in 0..<6 {
        /// create a new button and give it a big font size
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        
        /// give the button some temporary text so we can see it on-screen
        //        letterButton.setTitle("WWW", for: .normal)
        getAlphabetContents()
        
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  // MARK: - SETUP

  // MARK: UI
  func setUpUi() {
    setUpTargetWord()
    setUpButtonsContainer()
  }

  func setUpTargetWord() {
    targetWordLabel = UILabel()
    targetWordLabel.translatesAutoresizingMaskIntoConstraints = false
    targetWordLabel.text = "Testestest"
    targetWordLabel.font = UIFont.systemFont(ofSize: 40)
//    targetWordLabel.backgroundColor = .gray
  }
  
  func setUpButtonsContainer() {
    buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
    buttonsContainer.layer.borderWidth = 1
    buttonsContainer.layer.borderColor = UIColor.lightGray.cgColor
    buttonsContainer.layer.cornerRadius = 25
//    buttonsContainer.backgroundColor = .lightGray
  }

  // MARK: Data
  func getAlphabetContents() {
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
  
  func loadGame() {
    loadGameWords()
  }
  
  // MARK: - GAME MECHANICS
  
  func loadGameWords() {
    if let wordsFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      /// get words that are separated by a carriage return
      if let gameContents = try? String(contentsOf: wordsFileURL){
        var words = gameContents.components(separatedBy: "\n")
        words.shuffle()
        targetWord = words[0]
      }
    }
    if words.isEmpty {
      words.append("silkworm")
      targetWord = words[0]
    }
    targetWordLabel.text = String(repeating: "_ ", count: targetWord.count).trimmingCharacters(in: .whitespaces)
  }

// MARK: Button presses

  @objc func letterTapped(_ sender: UIButton) {
    // compare the title text of button pressed with the answer
    guard let letter = sender.titleLabel?.text else { return }
    
    if targetWord.contains(letter) {
      recordCorrectGuess()
    } else {
      recordIncorrectGuess()
    }
  }
  
  func recordCorrectGuess() {
    /// add to used word
    /// find and replace letters for label
    /// if the word is complete, then trigger a congrats
    /// update the label
    print("CORRECT")
  }
  
  func recordIncorrectGuess() {
    /// count the number of errors
    /// change image
    /// if more than seven errors, then alert the loss
    print("INCORRECT")
  }
  
  // restart the game
}
