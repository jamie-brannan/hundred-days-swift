# Day 22(3), Week 18
:calendar: – Thursday August 13, 2020

## **Challenge 2**, sharing the app link

:white_check_mark: Code is good!
* needed to verify by running on a real phone however!

## **Challenge 3**, Go back to project 2 and add a bar button item that shows their score when tapped.

- [x] bar button with "Score" label

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(checkScore))
```

- [ ] UIAlert that will display current score with close button

:pushpin: [**HackingSwift**](https://www.hackingwithswift.com/example-code/uikit/how-to-add-a-bar-button-to-a-navigation-bar) : *How to add a bar button to a navigation bar*

```swift
@objc func checkScore() {
    print("score check")
    let scoreCheckAlert = UIAlertController(title: "Current Score Tally", message: "You currently have \(score) points.", preferredStyle: .alert)
    scoreCheckAlert.addAction(UIAlertAction(title: "Return", style: .default, handler: .none))
    present(scoreCheckAlert, animated: true)
  }
```