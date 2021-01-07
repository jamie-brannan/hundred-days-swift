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
    setupScoreLabel()
    view.addSubview(scoreLabel)
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
  func setupScoreLabel() {
    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.text = "Score: 0"
  }
}

