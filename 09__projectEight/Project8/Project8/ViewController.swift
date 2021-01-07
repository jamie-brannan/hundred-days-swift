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

  
  // MARK: - Lifestyle
  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    setUpLabels()
    setUpButtons()
    view.addSubview(scoreLabel)
    view.addSubview(cluesLabel)
    view.addSubview(answersLabel)
    view.addSubview(currentAnswer)
    view.addSubview(clear)
    view.addSubview(submit)
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
    ])
    cluesLabel.backgroundColor = .red
    answersLabel.backgroundColor = .blue
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  // MARK: - Setup
  
  // Labels

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
  }
  
  func setupAnswersLabel() {
    answersLabel = UILabel()
    answersLabel.translatesAutoresizingMaskIntoConstraints = false
    answersLabel.font = UIFont.systemFont(ofSize: 24)
    answersLabel.text = "ANSWERS"
    answersLabel.numberOfLines = 0
    answersLabel.textAlignment = .right
  }
  
  func setupCurrentAnswer() {
    currentAnswer = UITextField()
    currentAnswer.translatesAutoresizingMaskIntoConstraints = false
    currentAnswer.placeholder = "Tap letters to guess"
    currentAnswer.textAlignment = .center
    currentAnswer.font = UIFont.systemFont(ofSize: 44)
    currentAnswer.isUserInteractionEnabled = false
  }
  
  // Button
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
}

