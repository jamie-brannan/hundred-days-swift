//
//  ViewController.swift
//  Project8
//
//  Created by Jamie Brannan on 01/01/2021.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Properties
  
  var cluesLabel: UILabel!
  var answersLabel: UILabel!
  var currentAnswer: UITextField!
  var scoreLabel: UILabel!
  var letterButtons = [UIButton]()
  let submit = UIButton(type: .system)
  let clear = UIButton(type: .system)
  
  // MARK: Views
  let buttonsContainer = UIView()
  
  var activatedButtons = [UIButton]()
  var solutions = [String]()
  
  var level = 1
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  // MARK: - Lifestyle
  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    
    setUpLabels()
    setUpButtons()
    setUpButtonsContainer()
    
    view.addSubview(scoreLabel)
    view.addSubview(cluesLabel)
    view.addSubview(answersLabel)
    view.addSubview(currentAnswer)
    view.addSubview(clear)
    view.addSubview(submit)
    view.addSubview(buttonsContainer)
    
    NSLayoutConstraint.activate([
      scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
      
      // pin the top of the clues label to the bottom of the score label
      cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      // pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
      cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
      // make the clues label 60% of the width of our layout margins, minus 100
      cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
      
      // also pin the top of the answers label to the bottom of the score label
      answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      // make the answers label stick to the trailing edge of our layout margins, minus 100
      answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
      // make the answers label take up 40% of the available space, minus 100
      answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
      // make the answers label match the height of the clues label
      answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
      
      currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
      
      submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
      submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
      submit.heightAnchor.constraint(equalToConstant: 44),
      
      clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
      clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
      clear.heightAnchor.constraint(equalToConstant: 44),
      
      buttonsContainer.widthAnchor.constraint(equalToConstant: 750),
      buttonsContainer.heightAnchor.constraint(equalToConstant: 320),
      buttonsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonsContainer.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
      buttonsContainer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
    ])
    
    //    cluesLabel.backgroundColor = .red
    //    answersLabel.backgroundColor = .blue
    //    buttonsContainer.backgroundColor = .green
    
    // set some values for the width and height of each button
    let width = 150
    let height = 80
    
    // create 20 buttons as a 4x5 grid
    for row in 0..<4 {
      for col in 0..<5 {
        // create a new button and give it a big font size
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        
        // give the button some temporary text so we can see it on-screen
        letterButton.setTitle("WWW", for: .normal)
        
        // calculate the frame of this button using its column and row
        let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
        letterButton.frame = frame
        
        // add it to the buttons view
        buttonsContainer.addSubview(letterButton)
        
        // and also to our letterButtons array
        letterButtons.append(letterButton)
        letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
      }
    }
    
    submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadLevel()
  }
  
  @objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else { return }
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
    sender.isHidden = true
  }
  
  @objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }
    
    if let solutionPosition = solutions.firstIndex(of: answerText) {
      activatedButtons.removeAll()
      
      var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
      splitAnswers?[solutionPosition] = answerText
      answersLabel.text = splitAnswers?.joined(separator: "\n")
      
      currentAnswer.text = ""
      score += 1
      
      if score % 7 == 0 {
        let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
        present(ac, animated: true)
      }
    }
  }
  
  @objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""
    
    for btn in activatedButtons {
      btn.isHidden = false
    }
    
    activatedButtons.removeAll()
  }
  
  // MARK: - Data handling
  
  func loadLevel() {
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()
    
    /// find and load ressource in the bundle
    if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
      if let levelContents = try? String(contentsOf: levelFileURL) {
        /// find lines of the file seperated by carriage returns
        var lines = levelContents.components(separatedBy: "\n")
        lines.shuffle()
        
        for (index, line) in lines.enumerated() {
          /// split parts into a fake dictionary?
          let parts = line.components(separatedBy: ": ")
          let answer = parts[0]
          let clue = parts[1]
          
          clueString += "\(index + 1). \(clue)\n"
          /// solution for round will be clean
          let solutionWord = answer.replacingOccurrences(of: "|", with: "")
          solutionString += "\(solutionWord.count) letters\n"
          solutions.append(solutionWord)
          
          let bits = answer.components(separatedBy: "|")
          letterBits += bits
        }
      }
    }
    
    cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
    answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
    
    letterBits.shuffle()
    
    if letterBits.count == letterButtons.count {
      for i in 0 ..< letterButtons.count {
        letterButtons[i].setTitle(letterBits[i], for: .normal)
      }
    }
  }
  
  // MARK: - Setup UI
  
  // MARK: Labels
  
  func setUpLabels() {
    setupScoreLabel()
    setupCluesLabel()
    setupAnswersLabel()
    setupCurrentAnswer()
  }
  
  func setupScoreLabel() {
    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.text = "Score: 0"
  }
  
  func setupCluesLabel() {
    cluesLabel = UILabel()
    cluesLabel.translatesAutoresizingMaskIntoConstraints = false
    cluesLabel.font = UIFont.systemFont(ofSize: 24)
    cluesLabel.text = "CLUES"
    cluesLabel.numberOfLines = 0
    cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
  }
  
  func setupAnswersLabel() {
    answersLabel = UILabel()
    answersLabel.translatesAutoresizingMaskIntoConstraints = false
    answersLabel.font = UIFont.systemFont(ofSize: 24)
    answersLabel.text = "ANSWERS"
    answersLabel.numberOfLines = 0
    answersLabel.textAlignment = .right
    answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
  }
  
  func setupCurrentAnswer() {
    currentAnswer = UITextField()
    currentAnswer.translatesAutoresizingMaskIntoConstraints = false
    currentAnswer.placeholder = "Tap letters to guess"
    currentAnswer.textAlignment = .center
    currentAnswer.font = UIFont.systemFont(ofSize: 44)
    currentAnswer.isUserInteractionEnabled = false
  }
  
  // MARK: Button
  
  func setUpButtonsContainer () {
    buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
    buttonsContainer.layer.borderWidth = 1
    buttonsContainer.layer.borderColor = UIColor.lightGray.cgColor
    buttonsContainer.layer.cornerRadius = 25
  }
  
  func setUpButtons() {
    setUpClearButton()
    setUpSubmitButton()
  }
  
  func setUpSubmitButton() {
    submit.translatesAutoresizingMaskIntoConstraints = false
    submit.setTitle("SUBMIT", for: .normal)
  }
  
  func setUpClearButton() {
    clear.translatesAutoresizingMaskIntoConstraints = false
    clear.setTitle("CLEAR", for: .normal)
  }
  
  // MARK: - Game action
  func levelUp(action: UIAlertAction) {
    level += 1
    solutions.removeAll(keepingCapacity: true)
    
    loadLevel()
    
    for btn in letterButtons {
      btn.isHidden = false
    }
  }
}

