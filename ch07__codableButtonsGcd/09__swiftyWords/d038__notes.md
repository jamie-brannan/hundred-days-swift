*Day 38 • Saturday January 09, 2021*

>There are many well-known quotes from Shakespeare, but there’s one I think is particularly apt today: “the fool doth think he is wise, but the wise man knows himself to be a fool.” I don’t know where you’d rank yourself in terms of Auto Layout knowledge, but I hope you’re at least aware that it’s a really big, complex space to work in!
>
>In my talk at NSSpain 2018 I said “Auto Layout makes hard things easy, and easy things hard” – you’ll find you can do relatively advanced layouts like today’s in about an hour, but occasionally you’ll find yourself wanting one specific layout constraint that is really hard to get right.
>
>Fortunately for all of us, this part of your Auto Layout learning is complete, so it’s time for us to review what you’ve learned.
>
>Today you should work through the wrap up chapter for project 8, complete its review, then work through all three of its challenges.

- [:one:  Wrap up](#one--wrap-up)
  - [Review what you learned](#review-what-you-learned)
  - [Challenge](#challenge)
- [:two:  Project 8 : 7 Swifty Words](#two--project-8--7-swifty-words)
  - [:boom: Quiz insights](#boom-quiz-insights)

>Once you’re done, tell other people: you’ve built another great app for iOS, and you’ve learned how to build a complete user interface entirely in code.
>
>You should be proud of what you’ve accomplished – keep it up!

## :one:  [Wrap up](https://www.hackingwithswift.com/read/8/6/wrap-up) 

>Yes, it took quite a lot of user interface code to get this project going, but I hope it has shown you that you can make some great games using just the UIKit tools you already know. Building user interfaces programmatically is obviously much less visual than using storyboards, but the flip side is that _everything is under your control – there are no connections happening behind the scenes._
>
>Of course, at the same time as making another game, you've made several steps forward in your iOS development journey, this time learning about `addTarget()`, `enumerated()`, `joined()`, `replacingOccurrences()`, and more.
>

### Review what you learned

>Anyone can sit through a tutorial, but it takes actual work to remember what was taught. It’s my job to make sure you take as much from these tutorials as possible, so I’ve prepared a short review to help you check your learning.

### Challenge
>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should **try extending this app** to make sure you fully understand what’s going on:
>
>Use the techniques you learned in project 2 to _draw a thin gray line around_ **the buttons view**, to make it stand out from the rest of the UI.

Add an outline to the UIButton

```swift
    buttonsContainer.layer.borderWidth = 1
    buttonsContainer.layer.borderColor = UIColor.lightGray.cgColor
    buttonsContainer.layer.cornerRadius = 25
```

It was really tricky to get the syntax right. `CGColor` versus `UIColor` is really frustrating, and I can never really remember why these are separate?

:question: *Why are UIColor and CGColor different?*
* Why do I need to access my UI via layer?


>If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to _extend the_ `submitTapped()` method so that **if** `firstIndex(of:)` **failed** to find the guess you show the alert.

New alert to show when a condition fails.

Externalized display messages

```swift
  func displayWinMessage() {
    let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
    present(ac, animated: true)
  }
  
  func displayFailMessage() {
    let ac = UIAlertController(title: "Ouch!", message: "Not quite. Want to try again?", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "I'll try!", style: .default, handler: levelUp))
    present(ac, animated: true)
  }
```

Could probably just have a generic one with the title and message.

```swift
  displayScoreUpdate(withTitle title: String, withMessage message: String, withActionTitle actionTitle: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: levelUp))
    present(ac, animated: true)
  }
```


>Try making the game also **deduct points** *if the player makes an incorrect guess*.
>* Think about how you can move to the next level – we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.

This would be could to have deduction happen with the new alert.

Understand the level progression before manipulating

```swift
score -= 1
```

In an else of the `if let`

So now to deal with leveling up, a new rule could be based off of things unreleated to the `score` 
* ~~that the clues label does not contain "letters" string.~~
* added a correct answer counter aside from score.

## :two:  [Project 8 : 7 Swifty Words](https://www.hackingwithswift.com/review/hws/project-8-7-swifty-words) 

### :boom: Quiz insights

* `UILabel` is responsible for showing static text.
  * Although you can achieve the same effect with `UITextField` labels are simpler.
* The `shuffle()` method shuffles an array in place rather than returning a new array
  * If you want the shuffled array return, use `shuffled()` instead.
* A property observer is code that gets run when their property changes or is about to change.
  * We can use either `willSet` to run code before the change, or `didSet` for after.
* The safe area layout guide is the space available to our view, excluding rounded corners and notches.
  * All important content should lie inside the safe area, or you risk it being obscured.
* We can remove whitespace from a string using the `trimmingCharacters(in:)` method.
  * This is able to trim lots of things, but the most common is whitespaces and newlines.
* We can use methods for the handler of a `UIAlertAction`.
  * As long as the method accepts a `UIAlertAction` and returns nothing, you can use it.
* _"Touch up inside"_, It refers to the user touching down on a specific view and releasing their touch while over the same view.
* Activating multiple constraints at once is faster than modifying `isActive` for each one
  * Apple explicitly recommends using activate() for this purpose.
* _constraints_, The multiplier is read first, then the constant.
* We can split strings into an array the `components(separatedBy:)` method.
* Using `UIFont.systemFont(ofSize:)` ensures our app uses the default system font for iOS.
  * This means even if iOS changes in the future, our app will adopt whatever is the new default.
* To run a method when a button is tapped we need to call `addTarget()` on the button.
* We provide a target and selector, so make sure and declare the method using `@objc`.
* The placeholder text for a UITextField is shown in gray when the text field is empty.
  * Placeholder text is the ideal place to remind users what should be typed in there, such as "Email address".
* We can use += to append one array to another
  * This operator is overloaded to handle array joining.













