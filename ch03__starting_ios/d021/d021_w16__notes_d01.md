# Day 21, Week 16
:calendar: – Wednesday July 08, 2020

- [Day 21, Week 16](#day-21-week-16)
  - [Challenge](#challenge)
    - [Resulting `ViewController.swift`](#resulting-viewcontrollerswift)
## Challenge

>1) Try showing the player’s score in the navigation bar, alongside the flag to guess.

```swift
title = countries[correctAnswer].uppercased() + ". \(score) pts."
```

>2) Keep track of how many questions have been asked, and show one final alert controller after they have answered 10. This should show their final score.

* added an `Int` type `round` counter
* added and if statement when it's 10
    * Maybe could've been a `when` statement but..?
* made `roundAlert()` and `finalScoreAlert()`

>3) When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.

* added aprams to `roundAlert()`

### Resulting `ViewController.swift`

```swift
//
//  ViewController.swift
//  Project2
//
//  Created by Jamie Brannan on 18/06/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

class ViewController: UIViewController {
  
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  var countries = [String]()
  var score = 0
  var correctAnswer = 0
  var round = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1

    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor
    
    askQuestion()
  }
  
  /// Callup flags based on their names `UIImage(named: <array item>)`
  /// closure as a parameter `nil` that way we don't need to call it
  func askQuestion(action: UIAlertAction! = nil) {
    countries.shuffle()

    /**
     Correct answer must be randomly one of the three chosen to display
     Set it here, then have the title be the name of it uppercased.
     */
    correctAnswer = Int.random(in: 0...2)

    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)

    title = countries[correctAnswer].uppercased() + ". \(score) pts."

    round += 1
  }
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    /// title of the alert card
    var resultTitle: String
    
    /// Score keeper
    if sender.tag == correctAnswer {
      resultTitle = "Correct"
      score += 1
      roundAlert(title: resultTitle, countrySelected: sender.tag)
    } else {
      resultTitle = "Wrong"
      score -= 1
      roundAlert(title: resultTitle, countrySelected: sender.tag)
    }

    if round == 10 {
      finalScoreAlert()
    } else {
      return
    }
  }

  func roundAlert(title: String, countrySelected: Int) {
    let countrySelectedName = countries[countrySelected]

    /// create an alert controler
    let ac = UIAlertController(title: title, message: "That was the flag of \(countrySelectedName.capitalizingFirstLetter()). Your round \(round) score is \(score)", preferredStyle: .alert)

    /// action bottoms on the bottom of the alert controller
    ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

    /// present the alert controller we just created with animations
    present(ac, animated: true)
  }

  func finalScoreAlert() {
    let finalScoreAlert = UIAlertController(title: "Congrats", message: "You've reached round \(round) of 10. Your final score is \(score)", preferredStyle: .alert)
    finalScoreAlert.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
    present(finalScoreAlert, animated: true)
    round = 0
    score = 0
  }
}
```