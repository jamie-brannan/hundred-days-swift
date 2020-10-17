//
//  ViewController.swift
//  Project5
//
//  Created by Jamie Brannan on 17/10/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  var allWords = [String]()
  var usedWords = [String]()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    loadAllWordArray()
    startGame()
  }
  
  // MARK: - Setting up the game
  func loadAllWordArray() {
    /// find the file named `start` with the file extension `.txt`
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      /// if that works then the words will be contents
      if let startWords = try? String(contentsOf: startWordsURL) {
        /// each component is seperated by a return space
        allWords = startWords.components(separatedBy: "\n")
      }
    }
    /// default add in the case the file isn't around or has no words in it.
    if allWords.isEmpty {
      allWords = ["silkworm"]
    }
  }

  func startGame() {
      title = allWords.randomElement()
      usedWords.removeAll(keepingCapacity: true)
      tableView.reloadData()
  }
}

