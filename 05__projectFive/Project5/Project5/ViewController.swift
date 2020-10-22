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
    /// challenge 3
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(startGame))
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
  
  @objc func startGame() {
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
              usedWords.insert(answer, at: 0)
              
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
    /// unwrap the titulary word and lower case it, or else just exit if it's not there
    guard var tempWord = title?.lowercased() else { return false }
    
    /// for each letter in the guessed word, loop it's first letter  compared to the titulary word and remove it if there's a match
    for letter in word {
      
      if let position = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: position)
      } else {
        /// if you're not able to match any of the letters that it contains, then end it
        return false
      }
    }
    
    return true
  }
  
  /// This checks if the word is not already in our table
  func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word)
  }
  
  func isReal(word: String) -> Bool {
    /// create a spell checker instance
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
  }
  
  /// challenge 2
  func showErrorMessage(title: String, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  /// challenge 1
  private func isLessThanThreeLetters(_ word: String) -> Bool {
    return word.count > 3
  }
  
  private func isStartWord(_ word: String) -> Bool {
    return word != title
  }
}

