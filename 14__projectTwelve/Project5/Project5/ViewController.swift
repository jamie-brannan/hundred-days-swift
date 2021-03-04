//
//  ViewController.swift
//  Project5
//
//  Created by Jamie Brannan on 17/10/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  // Mark: - Properties
  var allWords = [String]()
  var usedWords = [String]()
  let defaults = UserDefaults.standard
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    loadAllWordArray()
    // TODO: if the user default for the title is empty, start an all new game
    startNewGame()
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(startNewGame))
  }
  
  // MARK: - Setting up
  func loadAllWordArray() {
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let startWords = try? String(contentsOf: startWordsURL) {
        allWords = startWords.components(separatedBy: "\n")
      }
    }
    if allWords.isEmpty {
      allWords = ["silkworm"]
    }
  }
  
  @objc func startNewGame() {
    title = allWords.randomElement()
    usedWords.removeAll(keepingCapacity: true)
    // TODO: - save new title and delete old usedWords defaults
    tableView.reloadData()
  }
  
  // MARK: - Callbacks
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
  }
  
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
      self?.submit(answer: answer)
    }
    
    ac.addAction(submitAction)
    present(ac, animated: true)
  }
  
  func submit(answer: String) {
    let lowerAnswer = answer.lowercased()
    
    if isPossible(word: lowerAnswer) {
      if isOriginal(word: lowerAnswer) {
        if isReal(word: lowerAnswer) {
          if isLessThanThreeLetters(lowerAnswer) {
            if isStartWord(lowerAnswer) {
              usedWords.insert(lowerAnswer, at: 0)
              // TODO: - save usedWords
              let indexPath = IndexPath(row: 0, section: 0)
              tableView.insertRows(at: [indexPath], with: .automatic)
              
              return
            } else {
              showErrorMessage(title: "Identical word", message: "Can't use the same word")
            }
          } else {
            showErrorMessage(title: "Less than three letters", message: "Need more than three letters")
          }
        } else {
          showErrorMessage(title: "Word not recognised", message: "You can't just make them up, you know!")
        }
      } else {
        showErrorMessage(title: "Word used already", message: "Be more original!")
      }
    } else {
      guard let title = title?.lowercased() else { return }
      showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title)")
    }
  }
  
  // MARK: - Checks
  func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else { return false }
    for letter in word {
      if let position = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: position)
      } else {
        return false
      }
    }
    return true
  }
  
  /// This checks if the word is not already in our table
  func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word) && !usedWords.contains(word.capitalized)
  }
  
  func isReal(word: String) -> Bool {
    /// create a spell checker instance
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
  }
  
  func showErrorMessage(title: String, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  private func isLessThanThreeLetters(_ word: String) -> Bool {
    return word.count > 3
  }
  
  private func isStartWord(_ word: String) -> Bool {
    return word != title
  }
}

