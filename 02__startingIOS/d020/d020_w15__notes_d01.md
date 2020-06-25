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

:question: Are there seeds that can be changed in randoms in Swift ?

>Now that we have the correct answer, we just need to put its text into the navigation bar. This can be done by using the title property of our view controller, but we need to add one more thing: we don't want to write "france" or "uk" in the navigation bar, because it looks ugly. We could capitalize the first letter, and that would work great for France, Germany, and so on, but it would look poor for “Us” and “Uk”, which should be “US” and “UK”.
>
>The solution here is simple: uppercase the entire string. This is done using the uppercased() method of any string, so all we need to do is read the string out from the countries array at the position of correctAnswer, then uppercase it. Add this to the end of the askQuestion() method, just after correctAnswer is set:

```swift
title = countries[correctAnswer].uppercased()
```

:white_check_mark: 

>With that done, you can run the game and it's now almost playable: you'll get three different flags each time, and the flag the player needs to tap on will have its name shown at the top.

(:camera: screen shot on website)

>Of course, there's one piece missing: the user can tap on the flag buttons, but they don't actually do anything. Let's fix that…


## :two:  [From outlets to actions creating an `IBAction`](https://www.hackingwithswift.com/read/2/5/from-outlets-to-actions-creating-an-ibaction) 

### Making `IBAction` outlet

>I said we'd return to Interface Builder, and now the time has come: we're going to connect the "tap" action of our `UIButtons` to some code. So, select `Main.storyboard`, then change to the assistant editor so you can see the code alongside the layout.
>
>Warning: please read the following text very carefully. In my haste I screw this up all the time, and I don't want it to confuse you!
>
>Select the first button, then **Ctrl+drag** from it down to the space in your code immediately after the end of the `askQuestion()` method. 
>
>If you're doing it correctly, you should see a `tooltip` saying, "Insert Outlet, Action, or Outlet Collection." When you let go, you'll see the same popup you normally see when creating outlets, but here's the catch: _don't choose outlet_.

(:camera: screen shot on website)

>That's right: where it says "Connection: Outlet" at the top of the popup, I want you to change that to be **“Action”**. If you choose Outlet here (which I do all too often because I'm in a rush), you'll cause problems for yourself!
>
>When you choose `Action` rather than `Outlet`, the popup changes a little. 
>
>You'll still get asked for a name, but now you'll see an `Event` field, and the `Type` field has changed from `UIButton` to `Any`. 
>* Please change `Type` back to `UIButton`,
>* then enter **buttonTapped** for the name, 
>* and click Connect.
>
>Here's what Xcode will write for you:

```swift
@IBAction func buttonTapped(_ sender: UIButton) {
}
```
:white_check_mark:

>…and again, notice the gray circle with a ring around it on the left, signifying this has a connection in Interface Builder.

#### ...to multiple buttons 

>Before we look at what this is doing, I want you to **make two more connections.** 
>This time it's a bit different, because we're connecting the other two flag buttons to the same `buttonTapped()` method.
>
>To do that, select each of the remaining two buttons, then Ctrl-drag onto the `buttonTapped()` method that was just created. The whole method will turn blue signifying that it's going to be connected, so you can just let go to make it happen. If the method flashes after you let go, it means the connection was made.
>
>So, what do we have? Well, we have a single method called `buttonTapped()`, which is connected to all >three `UIButtons`. 
>
>The event used for the attachment is called `TouchUpInside`, which is the iOS way of saying, "_the user touched this button, then released their finger while they were still over it_" – i.e., the button was tapped.

:white_check_mark: Touch inside on contact and lift off = _tap_

>Again, Xcode has inserted an attribute to the start of this line so it knows that this is relevant to Interface Builder, and this time it's `@IBAction`. `@IBAction` is similar to `@IBOutlet`, but goes the other way: `@IBOutlet` is a way of connecting code to storyboard layouts, and `@IBAction` is a way of making storyboard layouts trigger code.
>
>This method takes one parameter, called **sender**. It's of type `UIButton` because we know that's what will be calling the method. 
>
>And this is important: all three buttons are _**calling** the same method,_ so it's important we know which button was tapped so we can judge whether the answer was correct.

`@IBAction` is a method, it always has a param, a **sender**.

The **sender**'s type is the object from the Interface Builder that is doing the action.

#### ...distinguish between buttons

>**But how do we know whether the correct button was tapped?** 
>
>Right now, all the buttons look the same, but behind the scenes all views have a special identifying number that we can set, called its **Tag**. 
>
>This can be any number you want, so we're going to give our buttons the numbers 0, 1 and 2. 
>* This isn't a coincidence: _our code is already set to put flags 0, 1 and 2 into those buttons_, **so** if we give them the same tags we know exactly what flag was tapped.
>
>Select the second flag (not the first one!), then look in the **attributes inspector (Alt+Cmd+4)** for the input box marked Tag.
>* You might need to scroll down, because UIButtons have lots of properties to work with! 
>* Once you find it (it's about two-thirds of the way down, just above the color and alpha properties), make sure it's set to 1.

(:camera: screen shot on website)

>* Now choose the third flag and set its tag to be 2. 
>We don't need to change the tag of the first flag >because 0 is the default.
>
>We're done with Interface Builder for now, so go back to the standard editor and select `ViewController.swift` – it's time to finish up by filling in the contents of the `buttonTapped()` method.

### Defining the `buttonTapped()`

>This method needs to do three things:
>
>1) Check whether the answer was correct.
>2) Adjust the player's score up or down.
>3) Show a message telling them what their new score is.

#### Check if answer was correct and adjust score

>The first task is quite simple, because each button has a tag matching its position in the array, and we stored the position of the correct answer in the correctAnswer variable. So, the answer is **correct if** `sender.tag` _is equal to_ `correctAnswer`.

`if else` statements

>The second task is also simple, because you've already met the `+= `operator that adds to a value. We'll be using that and its counterpart, `-=,` to add or subtract score as needed. The third task is more complicated, so we're going to come to it in a minute.

basic counter

>Put this code into the buttonTapped() method:

```swift
var title: String

if sender.tag == correctAnswer {
    title = "Correct"
    score += 1
} else {
    title = "Wrong"
    score -= 1
}
```

#### Alert message

>Now for the tough bit: we're going to use a new data type called `UIAlertController()`. This is used to show an alert with options to the user. To make this work you're going to need to use a closure – something you’ve learned about in theory, but at last finally get to use in practice.
>
>If you remember, **closures** is a special kind of _code block_ that can be _used like a variable_ – Swift _literally takes a copy of the block of code_ so that it can be called later. 
* Swift also _copies anything referenced inside_ the code, so you need to be careful how you use them. We're going to be using closures extensively later, but for now we’ll take two shortcuts.
>
>Enter this just before the end of the `buttonTapped()` method:

```swift
let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
present(ac, animated: true)
```

>That code will produce an error for a moment, but that’s OK.
>
>The title variable was set in our if statement to be either "correct" or "wrong", and you've already learned about string interpolation, so the first new thing there is the `.alert` parameter being used for preferredStyle. `UIAlertController()` gives us two kinds of style: `.alert`, which pops up a message box over the center of the screen, and `.actionSheet`, which slides options up from the bottom. 
>
>They are similar, but Apple recommends you use `.alert `when telling users about a situation change, and `.actionSheet` when asking them to choose from a set of options.
>
>The second line uses the `UIAlertAction` data type to add a button to the alert that says "Continue", and gives it the style “default". There are three possible styles: 
>* .default,
>* .cancel,
>* and .destructive. 
>
>What these look like depends on iOS, but it's important you use them appropriately because they provide subtle user interface hints to users.
>
>The sting in the tail is at the end of that line: `handler: askQuestion`. 
>
>**The handler parameter is looking for a closure,** which is some code that it can execute when the button is tapped. 

>You can write custom code in there if you want, but _in our case we want the game to continue when the button is tapped_, so we pass in `askQuestion` so that iOS will call our `askQuestion()` method.

This closure is how we get it to ask an new question

>:warning: **Warning**: We must use `askQuestion` and not `askQuestion()`. If you use the former, it means "here's the name of the method to run," but if you use the latter it means "run the `askQuestion()` method now, and it will tell you the name of the method to run."
>
>There are many good reasons to use closures, but in the example here just passing in `askQuestion` is a neat shortcut – although it does break something that we'll need to fix in a moment.
>
>The final line calls `present()`, which takes two parameters: a view controller to present and whether to animate the presentation. 
>
>It has an _optional_ third parameter that is another closure that should be executed when the presentation animation has finished, but we don’t need it here. We send our `UIAlertController` for the first parameter, and true for the second because animation is always nice.
>
>Before the code completes, there's a problem, and Xcode is probably telling you what it is: _“Cannot convert value of type ‘() -> ()’ to expected argument type ‘((UIAlertAction) -> Void)?’.”_
>
>This is a good example of Swift's terrible error messages, and it's something I'm afraid you'll have to get used to. 

:joy:

>What it means to say _is that using a method for this closure is fine_, **but Swift wants the method to accept a `UIAlertAction` parameter** saying which `UIAlertAction` was tapped.
>
>To make this problem go away, we need to change the way the askQuestion() method is defined. So, scroll up and change `askQuestion()` from this:

```swift
func askQuestion() {
```

>…to this:

```swift
func askQuestion(action: UIAlertAction!) {
```

>That will fix the `UIAlertAction` error. However, it will introduce another problem: when the app first runs, we call `askQuestion()` inside `viewDidLoad()`, and we don't pass it a parameter. There are two ways to fix this:
>
>When using `askQuestion()` in `viewDidLoad()`, we could send it the parameter `nil` **to mean "there is no UIAlertAction for this."**
>
>We could redefine `askQuestion()` so that the action has _a default parameter_ of `nil`, meaning that if it isn't specified it automatically becomes nil.
>
>_There's no right or wrong answer here_, so I'll show you both and you can choose. If you want to go with the first option, change the `askQuestion()` call in `viewDidLoad()` to this:

```swift
askQuestion(action: nil)
```

>And if you want to go with the second option, change the askQuestion() method definition to this:

```swift
func askQuestion(action: UIAlertAction! = nil) {
```

Go for the shortest to type out

>Now, go ahead and run your program in the simulator, because it's done!

(:camera: screen shot on website)