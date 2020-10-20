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
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
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
  
  // MARK: - Used word management
  /// as many rows as the number of words used
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
  }
  
  /// label a cell per used word
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
  }
  
  // MARK: - Prompt
  @objc func promptForAnswer() {
    let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
    ac.addTextField()
    
    let submitAction = UIAlertAction(title: "Submit", style: .default) {
      [weak self, weak ac] _ in
      guard let answer = ac?.textFields?[0].text else { return }
      self?.submit(answer)
    }
    
    ac.addAction(submitAction)
    present(ac, animated: true)
  }
  
  func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()
    
    /// Check criteria – all just `true` for now
    if isPossible(word: lowerAnswer) {
      if isOriginal(word: lowerAnswer) {
        if isReal(word: lowerAnswer) {
          /// add this word to the array
          usedWords.insert(answer, at: 0)
          /// have it's index path be the first one in the table.
          let indexPath = IndexPath(row: 0, section: 0)
          /// animate adding row
          tableView.insertRows(at: [indexPath], with: .automatic)
        }
      }
    }
  }
  
  // MARK: - Checks
  func isPossible(word: String) -> Bool {
    return true
  }
  
  func isOriginal(word: String) -> Bool {
    return true
  }
  
  func isReal(word: String) -> Bool {
    return true
  }
}

