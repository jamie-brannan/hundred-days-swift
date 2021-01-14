//
//  ViewController.swift
//  HundredHangman
//
//  Created by Jamie Brannan on 14/01/2021.
//

import UIKit

class ViewController: UIViewController {

  // MARK: - Props

  // MARK: UI Elements
  var letterButtonsContainer = UIView()
  var targetWordLabel: UILabel!
  var letterButtons = [UIButton]()
  
  // MARK: Data Storage
  var usedLetters: [String] = []
  var availableGuessLetters: [String] = []


  // MARK: - Lifecycle

  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    setupTargetWord()
    loadGame()
    view.addSubview(targetWordLabel)
    NSLayoutConstraint.activate([
      targetWordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      targetWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  // MARK: - Setup

  func loadGame() {
    loadWord()
  }

  func setupTargetWord() {
    targetWordLabel = UILabel()
    targetWordLabel.translatesAutoresizingMaskIntoConstraints = false
    targetWordLabel.text = "Testestest"
  }

  // MARK: - Game mechanics
  
  func loadWord() {
    var targetDisplayString = ""
//    var solution = ""

    if let levelFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      /// get words that are separated by a carriage return
      if let levelContents = try? String(contentsOf: levelFileURL){
        var lines = levelContents.components(separatedBy: "\n")
        lines.shuffle()
        
        for (index, line) in lines.enumerated() {
          targetDisplayString += "\(index + 1). \(line) \n"
        }
      }
    }
    targetWordLabel.text = targetDisplayString
  }
}

