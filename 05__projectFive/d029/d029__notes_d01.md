# *Day 29 • Thursday October 22, 2020*

>I hope that today you inched a little closer to understanding closures, and that you’re starting to see that they are really just a very special kind of function. Sure they have weird syntax, and yes the capturing thing makes them behave in all sorts of interesting ways, but ultimately they are just anonymous functions that you pass around as if they were data.
>
>If you’re still not sure about closures, it’s OK: we’ll be using them again and again, and sooner or later they’ll click. You’d do well to remember the words of Patrick McKenzie: “every great developer you know got there by solving problems they were unqualified to solve until they actually did it.”

Definitelys still didn't get everything yet.

>Anyway, you have another project under your belt, and I hope you feel happy with everything you learned. Of course, now it’s time to solidify your knowledge with a test and some fresh challenges – you need to go beyond just following along with me, otherwise you’ll have a hard time remembering anything in the long term.
>
>Today you should work through the wrap up chapter for project 5, complete its review, then work through all three of its challenges. As you’ll see, there is also a bonus challenge today – you need to be a bug detective!

## :one:  [Wrap up](https://www.hackingwithswift.com/read/5/7/wrap-up) 

>You've made it this far, so your Swift learning really is starting to come together, and I hope this project has shown you that you can make some pretty advanced things with your knowledge.
>
>In this project, you learned a little bit more about `UITableView`: how to reload their data and how to insert rows. You also learned how to add text fields to `UIAlertController` so that you can accept user input. But you also learned some serious core stuff: more about Swift strings, closures, `NSRange`, and more. These are things you're going to use in dozens of projects over your Swift coding career, and things we'll be returning to again and again in this series.

### Project 5, Word Scramble [review](https://www.hackingwithswift.com/review/hws/project-5-word-scramble)

:boom: Quiz insights

* Using `isEmpty` is faster than `count == 0`
  * `isEmpty` can return true as soon as it knows at least one item exists, where `count == 0` has to count all the letters in a string.
* Index paths store a section and row integer.
  * The `IndexPath` type is the combination of a section and row, making it useful for table views.
* `UITextChecker` comes from UIKit.
  * When you see "UI" at the start of a type name, it's a good sign it's from UIKit.
* Calling `reloadData()` will make a table load all its sections and rows from scratch.
  * `reloadData()` will cause all our table view methods to be called again, including `numberOfRowsInSection` and `cellForRowAt`.
* You can create constants without giving them an initial value.
  * You can write `let name: String` and provide a value later on – Swift will make sure the value is set only once.
* Objective-C and Swift store strings differently
  * Swift stores strings as grapheme clusters, so we need to careful when working with Objective-C APIs.
* A closure's capture list comes before its parameters.
  * The correct order is capture list then parameters, e.g. `[weak self] param1, param2 in`.
* Calling `randomElement()` will always return an random item from an array.
  * :red_circle: `randomElement()` returns an optional element because the array might be empty.
* An `NSRange` stores the location and length of something.
  * `NSRange` is commonly used with Objective-C APIs such as UIKit.
* You can configure the text field in an alert controller if you want to
  * When adding a text field you can provide a configuration handler to adjust the way it looks and works.
* Strings are case-sensitive in Swift
  * CAT, cat, and Cat are all different strings to Swift.
* Inserting a single row into a table view is more efficient than calling `reloadData()`.
  * It also looks better, because we can animate the change.
* The `firstIndex(of:)` method returns nil if the element you're looking for doesn't exist.
  * If `firstIndex(of:)` can't find what you're looking for, it will return nil.

11 out of 12 :tada:

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:
>
>
> 1) _Disallow answers that are shorter than three letters_ **or** _are just our start_ word. 
>> For the three-letter check, the easiest thing to do is put a check into `isReal()` that _returns false if the word length is under three letters_. For the second part, just _compare the start word against their input word_ and return false if they are the same.

There's a lot of ways to do this but there's some that are better than others.

:pushpin: [**Dillon MCE**](https://dillon-mce.com/100-Days-029/) : *100 Days of Swift, Day 29*

Wrote a super clean seperate View Controller for handling mechanics.

```swift
//
//  GameController.swift
//  Project5
//
//  Created by Dillon McElhinney on 6/11/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//
import UIKit

class GameController {
    
    private var allWords: [String] = []
    private var usedWords: [String] = []
    var startWord: String = ""
    
    init() {
        // Pull the list of words out of the file
        if let startWordsURL = Bundle.main.url(forResource: "start",
                                               withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsURL) {
            allWords = startWords.components(separatedBy: "\n")
        }
        
        // Provide a default in case something goes wrong.
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
    }
    
    // MARK: - Tableview Data Source Helpers
    func numberOfRows(in section: Int = 0) -> Int {
        return usedWords.count
    }
    
    func word(for indexPath: IndexPath) -> String {
        return usedWords[indexPath.row]
    }
    
    // MARK: - Public API
    func startGame() {
        startWord = allWords.randomElement() ?? "silkworm"
        usedWords.removeAll()
    }
    
    @discardableResult func checkAnswer(_ answer: String) -> AnswerError? {
        let lowerAnswer = answer.lowercased()
        
        guard isPossible(lowerAnswer) else {
            return .impossible(comparedTo: startWord)
        }
        
        guard isOriginal(lowerAnswer) else {
            return .unoriginal
        }
        
        guard isReal(lowerAnswer) else {
            return .unreal
        }
        
        guard isLongEnough(lowerAnswer) else {
            return .tooShort
        }

        guard isNotTheSame(lowerAnswer) else {
            return .sameAsOriginal
        }
        
        usedWords.insert(lowerAnswer, at: 0)
        
        return nil
    }
    
    private func isPossible(_ word: String) -> Bool {
        var tempWord = startWord.lowercased()
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }

    private func isOriginal(_ word: String) -> Bool {
        return !usedWords.contains(word)
    }

    private func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0,
                            length: word.utf16.count)
        let misspelledRange =
            checker.rangeOfMisspelledWord(in: word,
                                          range: range,
                                          startingAt: 0,
                                          wrap: false,
                                          language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    private func isLongEnough(_ word: String) -> Bool {
        return word.count > 3
    }

    private func isNotTheSame(_ word: String) -> Bool {
        return word != startWord
    }
}

enum AnswerError: Equatable {
    case unoriginal
    case impossible (comparedTo: String)
    case unreal
    case tooShort
    case sameAsOriginal
    
    func title() -> String {
        switch (self) {
        case .impossible:
            return "Word not possible"
        case .unoriginal:
            return "Word used already"
        case .unreal:
            return "Word not recognized"
        case .tooShort:
            return "Word too short"
        case .sameAsOriginal:
            return "Word isn't different"
        }
    }
    
    func message() -> String {
        switch (self) {
        case .impossible(let word):
            return "You can't spell that word from '\(word)'"
        case .unoriginal:
            return "Be more original!"
        case .unreal:
            return "You can't just make them up, you know!"
        case .tooShort:
            return "Words need to be at least four letters long!"
        case .sameAsOriginal:
            return "It doesn't count if it is the same word!"
        }
    }
}
```

> 2) **Refactor all the `else` statements** we just added so that they call a new method called `showErrorMessage()`. 
> >This should accept an error message and a title, and do all the `UIAlertController` work from there.

Easy peasy, just moved some stuff around and removed extraneous code.

> 3) **Add a left bar button item** that calls `startGame()`, so users can restart with a new word whenever they want to.

`navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(startGame))`

>**Bonus**: Once you’ve done those three, there’s a really subtle bug in our game and I’d like you to try finding and fixing it.
>
>4) To trigger the bug, look for a **three-letter word in your starting word, and enter it with an uppercase letter**. Once it appears in the table, _try entering it again all lowercase_ – you’ll see it gets entered. Can you figure out what causes this and how to fix it?

So case sensitivity?
* this only happens when the guess is entered in ALL CAPS first
* Does not happen when lowercase is entered first

Therefore an originality case error is not covered.

```swift
  func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word) && !usedWords.contains(word.capitalized)
  }
```

however, all caps are still registered different...?

**The check is only done over letters that are lowercased.**, so you can have more than three letters to pass, but when you compare for originality it'll only look over the letters that are lowercased.

It's gotta be about `contains()`

### Hints

>It is vital to your learning that you try the challenges above yourself, and not just for a handful of minutes before you give up.
>
>Every time you try something wrong, you learn that it’s wrong and you’ll remember that it’s wrong. By the time you find the correct solution, you’ll remember it much more thoroughly, while also remembering a lot of the wrong turns you took.
>
>This is what I mean by “there is no learning without struggle”: if something comes easily to you, it can go just as easily. But when you have to really mentally fight for something, it will stick much longer.
>
>But if you’ve already worked hard at the challenges above and are still struggling to implement them, I’m going to write some hints below that should guide you to the correct answer.
>
>If you ignore me and read these hints without having spent at least 30 minutes trying the challenges above, the only person you’re cheating is yourself.
>
>Still here? OK. If you’re stuck on the bug finding bonus challenge, take a look at this line of code:

```swift
usedWords.insert(answer, at: 0)
```

>Is that what it should be?


