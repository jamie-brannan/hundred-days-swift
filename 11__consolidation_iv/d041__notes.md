*Day 41  • Wednesday January 13, 2021*

>There is some pseudo-science that claims the second or third Monday in January is **“blue Monday”** – the most depressing day of the year. The reasons given include weather conditions in the northern hemisphere being bleak, the amount of time since the Christmas holiday, the number of people giving up on New Year’s resolutions, and more.
>
>It is, of course, nonsense, but it does have one grain of truth: _it’s easy to get discouraged when you’re part-way through something, because the initial novelty has worn off and there’s still a lot more work ahead of you._
>
>That’s where you are today. You’re less than half the way through the 100 Days of Swift, but you’re already being asked to tackle complicated topics in multiple consecutive days – the difficulty level is ramping up, the pace probably feels a little quicker, and the amount of code you’re being asked to write is also going up.

Not giving up :muscle:

>I know some of the days you’ve faced have been harder than others, and I also know you’re probably feeling tired – you’re giving up a lot of time to make this happen. But I want to encourage you to keep pushing on: you’re almost at the half-way point now, and the apps you’re now able to build are genuinely useful – you’ve come a long way!
>
>Helpfully, today is another consolidation day, which is partly a chance for us to **go over some topics again** to make sure you really understand them, partly a chance for me to dive into specific topics such as **`enumerated()`** and **GCD’s background/foreground bounce**, and partly a chance for you to try making your own app from scratch.
>
>As always, the challenge you’ll face is absolutely within your current skill level, and it gives you a chance to see how far you’ve come for yourself. **Ricky Mondello** – one of the team who builds Safari at Apple – once said, _“one of my favorite things about software engineering, or any kind of growth really, is coming back to something that you previously thought was too hard and knowing that you can do it.”_
>
>Today you have three topics to work through, one of which of is your challenge.
>
>Note: Don’t worry if you don’t complete challenges in the day they were assigned – in future days you’ll find you have some time to spare here and there, so challenges are something you can return back to in the future.

## :one: [What you learned](https://www.hackingwithswift.com/guide/4/1/what-you-learned) 

>Projects 7, 8, and 9 were the first in the series I consider to be “hard”: you had to parse JSON data, you had to create a complex layout for 7 Swifty Words, and you took your first steps towards creating **multithreaded code** – code that has iOS _do more than one thing at a time_.
>
>None of those things were easy, but I hope you felt the results were worth the effort. And, as always, don’t worry if you’re not 100% on them just – we’ll be using `Codable` and GCD more in future projects, so you’ll have ample chance to practice.
>
>* You’ve now met `UITabBarController`, which is another core iOS component – you see it in the App Store, Music, iBooks, Health, Activity, and more.
>
>* Each item on the tab bar is represented by a `UITabBarItem` that has a title and icon. If you want to use one of Apple’s icons, it means using Apple’s titles too.
>
>* We used `Data` to load a URL, with its `contentsOf` method. That then got fed to `JSONDecoder` so that we could read it in code.
>
>* We used `WKWebView` again, this time to show the petition content in the app. This time, though, we wanted to load our own HTML rather than a web site, so we used the `loadHTMLString()` method.
>
>* Rather than connect lots of actions in Interface Builder, you saw how you could write user interfaces in code. This was particularly helpful for the letter buttons of 7 Swifty Words, because we could use a nested loop.

:arrow_up: :white_check_mark: Recognize from day job

>* In project 8 we used **property observers**, using `didSet`. This meant that whenever the `score` property changed, we automatically updated the `scoreLabel` to reflect the new score.

Relatively new for me!

>* You learned how to execute code on the main thread and on background threads using `DispatchQueue`, and also met the `performSelector(inBackground:)` method, which is the easiest way to run one whole method on a background thread.

Had issues with this because the model code did not exaclty go along with current Swift and Xcode verion

>* Finally, you learned several new methods, not least `enumerated()` for looping through arrays, `joined()` for bringing an array into a single value, and `replacingOccurrences()` to change text inside a string.

We talked about in Mobile guild how native functions that can replace regex can be good to use

## :two:  [Key points](https://www.hackingwithswift.com/guide/4/2/key-points) 

>There are three Swift features that are so important – and so commonly used – that they are worth revising to make sure you’re comfortable with them.
>
>The first piece of code I’d like to look at is this one:

```swift
for (index, line) in lines.enumerated() {
    let parts = line.components(separatedBy: ": ")
```

>This might seem like a new way of writing a loop, but really it’s just a variation of the basic `for` loop. 
>* A regular `for` loop _returns one value_ at a time from an array for you to work with, 
>* but this time we’re calling the **`enumerated()`** method on the array, which causes it to **return two things for each item** in the array: 
>   * the item’s **position in the array**, 
>   * as well as **the item itsel**f.

Cool!

:pushpin: [**Apple Developer**](https://developer.apple.com/documentation/foundation/indexpath/1780332-enumerated) : *`enumerated()`*

>It’s common to see `enumerated()` in a loop, because its behavior of delivering both the item and its position is so useful. For example, we could use it to print out the results of a race like this:

```swift
let results = ["Paul", "Sophie", "Lottie", "Andrew", "John"]

for (place, result) in results.enumerated() {
    print("\(place + 1). \(result)")
}
```

>Note that I used `\(place + 1)` to print out each person’s place in the results, because array positions all count from 0.
>
>The second piece of code we’re going to review is this:

```swift
var score: Int = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```

>This is a **property observer**, and _it means that whenever the `score` integer changes the label will be updated to match._ 

:book: **property observer** : *(n)* when it changes it'll be updated to match

>There are other ways you could ensure the two remain in sync: we could have written a `setScore()` method, for example, or we could just have updated the `scoreLabel` text by hand whenever the `score` property changed.
>
>The former isn’t a bad idea, but you do need to police yourself to ensure you never set `score` directly - and that’s harder than you think! 
>
>The second is a bad idea, however: duplicating code can be problematic, because if you need to change something later you need to remember to update it everywhere it’s been duplicated.
>
>The final piece of code I’d like to look at again is this:

```swift
DispatchQueue.global().async { [weak self] in
    // do background work

    DispatchQueue.main.async {
        // do main thread work
    }
}
```
>That code uses **Grand Central Dispatch** to perform some work in the background, then perform some more work on the main thread. This is extremely common, and you’ll see this same code appear in many projects as your skills advance.
>
>**The first part of the code tells GCD to do the following work on a background thread**. This is useful for any work that will take more than a few milliseconds to execute, so that’s anything to do with the internet, for example, but also any time you want to do complex operations such as querying a database or loading files.
>
>**The second part of the code runs after your background work has completed, and pushes the remaining work back to the main thread.** This is where you present the user with the results of your work: the database results that matched their search, the remote file you fetched, and so on.
>
>**It is extremely important that you only ever update your user interface from the main thread** – trying to do it from a background thread will cause your app to crash in the best case, or – much worse – cause weird inconsistencies in your app.

## :three:  [Challenge](https://www.hackingwithswift.com/guide/4/3/challenge) 

>This is the first challenge that involves you creating a game. You’ll still be using UIKit, though, so it’s a good chance to practice your app skills too.
>
>The challenge is this: **make a hangman game using UIKit**.

:heart_eyes_cat:

>As a reminder, this means **choosing a random word from a list of possibilities**, but presenting it to the user as a series of underscores. So, if your word was “RHYTHM” the user would see “??????”.
>
>The user can then **guess letters one at a time**: if they guess a letter that it’s in the word, e.g. H, it gets revealed to make “?H??H?”; _if they guess an incorrect letter, they inch closer to death_. If they seven incorrect answers they lose, but if they manage to spell the full word before that they win.

Will need to have:
- word asset list
- filter for letters only (exclude punctuation like spaces or hypens?)
- property observers
- array of usedLetters
- array of unusedLetters
- array of guessLetters
- alphabetGuess uibuttons
- button container view
- hint view
- failled guess alert

:star: Bonus to make it accessible? :)

:red_circle: `Does the constraint or its anchors reference items in different view hierarchies?  That's illegal.`

>That’s the game: can you make it? Don’t underestimate this one: it’s called a challenge for a reason – it’s supposed to stretch you!
>
>The main complexity you’ll come across is that _Swift has a special data type for individual letters_, called **`Character`**. It’s easy to create strings from characters and vice versa, but you do need to know how it’s done.
>
>First, _the individual letters of a string are accessible simply by treating the string like an array_ – it’s a bit like an array of `Character` objects that you can loop over, or read its `count` property, just like regular arrays.

**`Character`** : *(type)* A single extended grapheme cluster that approximates a user-perceived character.

:pushpin: [**Apple Developer**](https://developer.apple.com/documentation/swift/character) : *`Character`*

I'm not sure how I'm supposed to use these tho.

:pushpin: [**Apple documentation**](https://developer.apple.com/documentation/foundation/nsstring/1413779-folding) : *`folding(options:locale:)`*
* _Creates a string suitable for comparison by removing the specified character distinctions from a string._

>When you write `for letter in word`, the `letter` constant will be of type `Character`, so if your `usedLetters` array contains strings you will need to convert that letter into a string, like this:

```swift
let strLetter = String(letter)
```

>Note: unlike regular arrays, you can’t read letters in strings just by using their integer positions – they store each letter in a complicated way that prohibits this behavior.

Yup I remember this form earlier chapters.

>Once you have the string form of each letter, you can use `contains()` to check whether it’s inside your `usedLetters` array.

:point_up: Hint for future submit function of letter

>That’s enough for you to get going on this challenge by yourself. As per usual there are _some hints below_, but it’s always a good idea to try it yourself before reading them.
>
>* You already know how to load a list of words from disk and choose one, because that’s exactly what we did in tutorial 5.
>
>* You know how to prompt the user for text input, again because it was in tutorial 5. Obviously this time you should only accept single letters rather than whole words – use `someString.count` for that.
>
>* You can display the user’s current word and score using the `title` property of your view controller.
>
>* You should create a `usedLetters` array as well as a `wrongAnswers` integer.
>
>* When the player wins or loses, use `UIAlertController` to show an alert with a message.
>
>Still stuck? Here’s some example code you might find useful:

```swift
let word = "RHYTHM"
var usedLetters = ["R", "T"]
var promptWord = ""

for letter in word.characters {
    let strLetter = String(letter)

    if usedLetters.contains(strLetter) {
        promptWord += strLetter
    } else {
        promptWord += "?"
    }
}

print(promptWord)
```

