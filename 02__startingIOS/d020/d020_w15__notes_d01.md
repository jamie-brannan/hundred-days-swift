# Day 20, Week 15
:calendar: – Thursday June 25, 2020 

*At home* :house:

>You’re already 1/5th of the way through the 100 Days of Swift, and you’re still coming back – that’s amazing, and I hope you feel proud that your consistency and persistency are paying off.

:tada:

>Years ago Steve Jobs said, "I believe life is an intelligent thing: that things aren't random.” I don’t know whether he’s right or wrong, but I do know that things really ought to be random if we’re playing a game, otherwise it wouldn’t be much fun!
>
>So, today we’ll be completing project two by :
>* showing random flags,
>* letting the user make their guess,
>* and showing a score alert.
>
>This could have involved using closures for the first time, but here we’re going to take _a little shortcut_ so you can start to get a feel for how closures, functions, and methods are really different flavors of the same thing.
>
>**Today you have just two topics to work through, and you’ll meet array shuffling, random number generation, `@IBAction`, and `UIAlertController`.**
>
>* Guess which flag: random numbers
>* From outlets to actions: creating an IBAction
>
>Hopefully those two shouldn’t prove too much work for you, so you should have a little time to experiment with your code before tomorrow’s challenges.

## :one: [Guess which flag: random numbers](https://www.hackingwithswift.com/read/2/4/guess-which-flag-random-numbers) 

>Our current code chooses the first three items in the countries array, and places them into the three buttons on our view controller. This is fine to begin with, but really we need to choose random countries each time. There are two ways of doing this:
>
>1) Pick three random numbers, and use those to read the flags from the array.
>2) Shuffle up the order of the array, then pick the first three items.
>
>Both approaches are valid, but the former takes a little more work because **we need to _ensure_ that all three numbers are different** – this game would be even less fun if all three flags were the same!

Breakdown needs checklist, process diagram

>The **second** approach is _easier_ to do, because Swift has built-in methods for shuffling arrays: 
>* `shuffle()` for in-place shuffling,
>* and `shuffled()` to return a new, shuffled array.
>
>At the start of the `askQuestion()` method, just before you call the first `setImage()` method, add this line of code:

```swift
countries.shuffle()
```

>That will automatically randomize the order of the countries in the array, meaning that `countries[0]`, `countries[1]` and `countries[2]` will refer to different flags each time the `askQuestion()` method is called. To try it out, press Cmd+R to run your program a few times to see different flags each time.
>
>The next step is to track which answer should be the correct one, and to do that we're going to create a new property for our view controller called `correctAnswer`. Put this near the top, just above `var score = 0`:

```swift
var correctAnswer = 0
```

>This gives us a new integer property that will store whether it's flag 0, 1 or 2 that holds the correct answer.
>
>To choose which should be the right answer requires using Swift’s random system again, because we need to choose a random number for the correct answer. All Swift’s numeric types, such as `Int`, `Double`, and `CGFloat`, have a `random(in:)` method that generates a random number in a range. So, to generate a random number between 0 and 2 inclusive you need to put this line just below the three `setImage()` calls in `askQuestion()` :

```swift
correctAnswer = Int.random(in: 0...2)
```

>Now that we have the correct answer, we just need to put its text into the navigation bar. This can be done by using the title property of our view controller, but we need to add one more thing: we don't want to write "france" or "uk" in the navigation bar, because it looks ugly. We could capitalize the first letter, and that would work great for France, Germany, and so on, but it would look poor for “Us” and “Uk”, which should be “US” and “UK”.
>
>The solution here is simple: uppercase the entire string. This is done using the uppercased() method of any string, so all we need to do is read the string out from the countries array at the position of correctAnswer, then uppercase it. Add this to the end of the askQuestion() method, just after correctAnswer is set:

```swift
title = countries[correctAnswer].uppercased()
```

>With that done, you can run the game and it's now almost playable: you'll get three different flags each time, and the flag the player needs to tap on will have its name shown at the top.

(:camera: screen shot on website)

>Of course, there's one piece missing: the user can tap on the flag buttons, but they don't actually do anything. Let's fix that…