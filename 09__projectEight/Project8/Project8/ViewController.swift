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
  
  // MARK: - Lifestyle
  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    setupLabels()
    view.addSubview(scoreLabel)
    view.addSubview(cluesLabel)
    view.addSubview(answersLabel)
    NSLayoutConstraint.activate([
        scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
        scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

        // more constraints to be added here!
    ])
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  // MARK: - Setup
  func setupLabels() {
    setupScoreLabel()
    setupCluesLabel()
    setupAnswersLabel()
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
}

