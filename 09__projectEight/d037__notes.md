# *Day 37 • Thursday January 07, 2021*

>How did you get on with yesterday’s user interface coding? After you completed the topics, there was one thing I asked you to keep in mind: whether you prefer making user interfaces in storyboards or programmatically, it’s important you know how to do both. *Now that you’ve done both, how do you feel about it?*
>
>This isn’t just a theoretical question – if you’re anything like me, it’s a question you’ll get asked a lot, so it’s important to think carefully about your answer.
>
>As for me, my answer is pretty simple: **I do whatever makes sense in each individual scenario**. Sometimes that means using code, sometimes it means using Interface Builder, and sometimes it means using both – and that’s OK. The main thing is that you remember the words of **John Woods**: _“always code as if the person who ends up maintaining your code will be a violent psychopath who knows where you live.”_
>
>Whether that’s making your UI in storyboards or in code is academic, really – what matters is that it **was the best choice you could make for that problem, given the constraints you were working in.**
>
>You’ll be glad to see yesterday’s hard work pay off today, because we’ll be completing our game in under an hour of work. We laid all the foundations yesterday, so today we’ll be : 
>* looking at loading levels 
>* and responding to button taps – no more Auto Layout for the time being!
>
>**Today you have three topics to work through, and you’ll learn about adding targets to a button, separating and joining strings, hiding views, and more.**

- [*Day 37 • Thursday January 07, 2021*](#day-37--thursday-january-07-2021)
  - [:one:  Loading a level and adding button targets](#one--loading-a-level-and-adding-button-targets)
    - [Adding targets](#adding-targets)
    - [Loading Level data](#loading-level-data)
  - [:two:  It's play time `firstIndex(Of:)` and `jointed()`](#two--its-play-time-firstindexof-and-jointed)
  - [:three:  Property Observers `didset`](#three--property-observers-didset)

## :one:  [Loading a level and adding button targets](https://www.hackingwithswift.com/read/8/3/loading-a-level-and-adding-button-targets) 

>After our mammoth effort of building the user interface in code, it’s time to continue with something much easier: **loading a level** and **showing letter parts on our buttons**.

Data handling

>This game asks players to **spell seven words** out of various letter groups, and each word comes with a clue for them to guess. 
>
>**It's important that the total number of letter groups adds up to 20**, as that's how many buttons you have. I created the first level for you, and it looks like this:

```swift
HA|UNT|ED: Ghosts in residence
LE|PRO|SY: A Biblical skin disease
TW|ITT|ER: Short online chirping
OLI|VER: Has a Dickensian twist
ELI|ZAB|ETH: Head of state, British style
SA|FA|RI: The zoological web
POR|TL|AND: Hipster heartland
```

>As you can see, I've used the pipe symbol to split up my letter groups, meaning that one button will have "HA", another "UNT", and another "ED". There's then a colon and a space, followed by a simple clue. 
>* This level is in the files for this project you should download from GitHub at https://github.com/twostraws/HackingWithSwift. 
>
>You should copy `level1.txt` into your Xcode project as you have done before.

:white_check_mark: Added

### Adding targets

>Our first task will be to **load the level and configure all the buttons to show a letter group**. 
>
>We're going to need **two new arrays** to handle this: one to store the buttons that are currently being used to spell an answer, and one for all the possible solutions. We also need two integers: one to hold the player's score, which will start at 0 but obviously change during play, and one to hold the current level.
>
>So, declare these properties just below the views we defined previously:

```swift
var activatedButtons = [UIButton]()
var solutions = [String]()

var score = 0
var level = 1
```

:white_check_mark: Declared.

>We also need to create three methods that will be called from our buttons: one when submit is tapped, one when clear is tapped, and one when any of the letter buttons are tapped. These don’t need any code for now, but we do need to make sure they are called when our buttons are tapped.
>
>First, add these three empty methods below `viewDidLoad()`:

```swift
@objc func letterTapped(_ sender: UIButton) {
}

@objc func submitTapped(_ sender: UIButton) {
}

@objc func clearTapped(_ sender: UIButton) {
}
```

>All three of those have the `@objc` attribute because they are going to be called by the buttons – by Objective-C code – when they are tapped.
>
>When we used `UIBarButtonItem` previously, we were able to specify the _target and selector_ of that button right in the initializer. This is done a little differently with buttons: they have a dedicated `addTarget()` method that connects the buttons to some code.
>
>So, in `loadView()` add this where we create the submit button:

```swift
submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
```

>The target, action, and selector parts you know already, but the `.touchUpInside` part is new – that’s UIKit’s way of saying that the user pressed down on the button and lifted their touch while it was still inside. 
>* So, altogether that line means _“when the user presses the submit button, call `submitTapped()` on the current view controller.”_
>
>Now add this where the clear button is created:

```swift
clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
```

>That will call the `clearTapped()` method when the button is triggered.
>
>Finally, we want all the letter buttons to call `letterTapped()` when they are tapped – they share the same method, much like our flag buttons in project 2.
>
>So, add this line inside our nested loop, just below the call to `letterButtons.append()`:

```swift
letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
```

>Of course, adding all those targets won’t actually do anything, because the three methods they are calling are all empty.

:white_check_mark: Targets added

### Loading Level data

>We’ll fill them in later, but first let’s focus on loading level data into the game. We're going to isolate level loading into a single method, called `loadLevel()`. This needs to do two things:
>
>1. Load and parse our level text file in the format I showed you earlier.
>2. Randomly assign letter groups to buttons.
>
>>In **project 5** you already learned how to create a `String` using `contentsOf` to load files from disk, and we'll be using that to load our level. In that same project you learned how to use `components(separatedBy:)` to split up a string into an array, and we'll use that too.
>
>We'll also need to use Swift’s **array shuffling code** that we've used before. But there are some new things to learn, honest!
>
>First, we'll be using the `enumerated()` method to loop over an array. We haven't used this before, but it's helpful because it passes you each object from an array as part of your loop, as well as that object's position in the array.
>
>There's also a new string method to learn, called `replacingOccurrences()`. 
>* This lets you specify two parameters, and replaces all instances of the first parameter with the second parameter. 
>* We'll be using this to convert "HA|UNT|ED" into HAUNTED so we have a list of all our solutions.
>
>Before I show you the code, watch out for how I use the method's three variables: `clueString` will store all the level's clues, `solutionString` will store how many letters each answer is (in the same position as the clues), and `letterBits` is an array to store all letter groups: HA, UNT, ED, and so on.
>
>Now add the `loadLevel()` method:

```swift
func loadLevel() {
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()

    if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
        if let levelContents = try? String(contentsOf: levelFileURL) {
            var lines = levelContents.components(separatedBy: "\n")
            lines.shuffle()

            for (index, line) in lines.enumerated() {
                let parts = line.components(separatedBy: ": ")
                let answer = parts[0]
                let clue = parts[1]

                clueString += "\(index + 1). \(clue)\n"

                let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                solutionString += "\(solutionWord.count) letters\n"
                solutions.append(solutionWord)

                let bits = answer.components(separatedBy: "|")
                letterBits += bits
            }
        }
    }

    // Now configure the buttons and labels
}
```

>If you read all that and it made sense first time, great! You can skip over the next few paragraphs and jump to the bold text "All done!". If you read it and only some made sense, these next few paragraphs are for you.
>
>First, the method uses `url(forResource:)` and `contentsOf` to find and load the level string from our app bundle. String interpolation is used to combine "level" with our current level number, making "level1.txt". The text is then split into an array by breaking on the `\n` character (that's line break, remember), then shuffled so that the game is a little different each time.
>
>Our loop uses the `enumerated()` method to go through each `item` in the lines array. This is different to how we normally loop through an array, but `enumerated()` is helpful here because it tells us where each item was in the array so we can use that information in our clue string. In the code above, `enumerated()` will place the item into the `line` variable and its position into the `index` variable.
>
>We already split the text up into lines based on finding `\n`, but now we split each line up based on finding `:`, because each line has a colon and a space separating its letter groups from its clue. We put the first part of the split line into `answer` and the second part into `clue`, for easier referencing later.
>
>Next comes our new string method call, `replacingOccurrences(of:)`. We're asking it to replace all instances of `|` with an empty string, so HA|UNT|ED will become HAUNTED. We then use `count` to get the length of our string then use that in combination with string interpolation to add to our solutions string.
>
>Finally, we make yet another call to `components(separatedBy:)` to turn the string "HA|UNT|ED" into an array of three elements, then add all three to our `letterBits` array.
>
>All done!
>
>Time for some more code: our current `loadLevel()` method ends with a comment saying `// Now configure the buttons and labels`, and we're going to fill that in with the final part of the method. This needs to set the `cluesLabel` and `answersLabel` text, shuffle up our buttons, then assign letter groups to buttons.
>
>Before I show you the actual code, there's a new string method to introduce: `trimmingCharacters(in:)` removes any letters you specify from the start and end of a string. It's most frequently used with the parameter `.whitespacesAndNewlines`, which trims spaces, tabs and line breaks, and we need exactly that here because our clue string and solutions string will both end up with an extra line break.
>
>Put this code where the comment was:

```swift
cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

letterBits.shuffle()

if letterBits.count == letterButtons.count {
    for i in 0 ..< letterButtons.count {
        letterButtons[i].setTitle(letterBits[i], for: .normal)
    }
}
```

>That loop will count from 0 up to but not including the number of buttons, which is useful because we have as many items in our `letterBits` array as our `letterButtons` array. Looping from 0 to 19 (inclusive) means we can use the `i` variable to set a button to a letter group.
>
>Before you run your program, make sure you add a call to `loadLevel()` in your `viewDidLoad()` method. Once that's done, you should be able to see all the buttons and clues configured correctly. Now all that's left is to let the player, well, play.

## :two:  [It's play time `firstIndex(Of:)` and `jointed()`](https://www.hackingwithswift.com/read/8/4/its-play-time-firstindexof-and-joined) 

>We need to add three more methods to our view controller in order to bring this game to life: one to handle letter buttons being tapped, another to handle the current word being cleared, and a third to handle the current word being submitted. The first two are easiest, so let's get those done so we can get onto the serious stuff.
>
>First, we already used the `addTarget()` method in `viewDidLoad()` to make all our letter buttons call the method `letterTapped()`, but right now it’s empty. Please fill it in like this:

```swift
@objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else { return }
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
    sender.isHidden = true
}
```

>That does four things:
>
> 1. It adds a safety check to read the title from the tapped button, or exit if it didn’t have one for some reason.
> 2. Appends that button title to the player’s current answer.
> 3. Appends the button to the activatedButtons array
> 4. Hides the button that was tapped.
>
>The `activatedButtons` array is being used to hold all buttons that the player has tapped before submitting their answer. This is important because we're hiding each button as it is tapped, so if the user taps "Clear" we need to know which buttons are currently in use so we can re-show them. You already created an empty method for clear being tapped, so fill it in like this:

```swift
@objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""

    for btn in activatedButtons {
        btn.isHidden = false
    }

    activatedButtons.removeAll()
}
```

>As you can see, this method removes the text from the current answer text field, unhides all the activated buttons, then removes all the items from the activatedButtons array.
>
>That just leaves one very important method to fill in, and you already created its stub: the submitTapped() method for when the player taps the submit button.
>
>This method will use firstIndex(of:) to search through the solutions array for an item and, if it finds it, tells us its position. Remember, the return value of firstIndex(of:) is optional so that in situations where nothing is found you won't get a value back – we need to unwrap its return value carefully.
>
>If the user gets an answer correct, we're going to change the answers label so that rather than saying "7 LETTERS" it says "HAUNTED", so they know which ones they have solved already.
>
>The way we're going to do this is hopefully easy enough to understand: firstIndex(of:) will tell us which solution matched their word, then we can use that position to find the matching clue text. All we need to do is split the answer label text up by \n, replace the line at the solution position with the solution itself, then re-join the answers label back together.
>
>You've already learned how to use components(separatedBy:) to split text into an array, and now it's time to meet its counterpart: joined(separator:). This makes an array into a single string, with each array element separated by the string specified in its parameter.
>
>Once that's done, we clear the current answer text field and add one to the score. If the score is evenly divisible by 7, we know they have found all seven words so we're going to show a UIAlertController that will prompt the user to go to the next level.
>
>If you remember, Swift has a division remainder operator, %, that tells us what number remains when you divide one number evenly by another – that’s perfect here.
>
>That's all the parts explained, so here's the complete submitTapped() method:

```swift
@objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }

    if let solutionPosition = solutions.firstIndex(of: answerText) {
        activatedButtons.removeAll()

        var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
        splitAnswers?[solutionPosition] = answerText
        answersLabel.text = splitAnswers?.joined(separator: "\n")

        currentAnswer.text = ""
        score += 1

        if score % 7 == 0 {
            let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
            present(ac, animated: true)
        }
    }
}
```

>We haven’t written a `levelUp()` method yet, but it’s not so hard. It needs to:
>
> 1. Add 1 to level.
> 2. Remove all items from the `solutions` array.
> 3. Call `loadLevel()` so that a new level file is loaded and shown.
> 4. Make sure all our letter buttons are visible.
>
>Add this `levelUp()` method now:

```swift
func levelUp(action: UIAlertAction) {
    level += 1
    solutions.removeAll(keepingCapacity: true)

    loadLevel()

    for btn in letterButtons {
        btn.isHidden = false
    }
}
```

>As you can see, that code clears out the existing `solutions` array before refilling it inside `loadLevel()`. Then of course you'd need to create level2.txt, level3.txt and so on.
>
>To get you started, I've made an example level2.txt for you inside my example files for this project – try adding that to the project and see what you think. Any further levels are for you to do – just make sure there's a total of 20 letter groups each time!


## :three:  [Property Observers `didset`](https://www.hackingwithswift.com/read/8/5/property-observers-didset) 

>There's one last thing to cover before this project is done, and it's both small and easy: property observers. You learned about these when we looked at the fundamentals of Swift, but now it’s time to put them into action.
>
>Right now we have a property called `score` that is set to 0 when the game is created and increments by one whenever an answer is found. But we don't do anything with that score, so our score label is never updated.
>
>One solution to this problem is to use something like `scoreLabel.text = "Score: \(score)"` whenever the score value is changed, and that's perfectly fine to begin with. But what happens if you're changing the score from several places? You need to keep all the code synchronized, which is unpleasant.
>
>Swift’s solution is property observers, which let you execute code whenever a property has changed. To make them work, we use either `didSet` to execute code when a property has just been set, or `willSet` to execute code before a property has been set.
>
>In our case, we want to add a property observer to our `score` property so that we update the score label whenever the score value was changed. So, change your `score` property to this:

```swift
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```

>Using this method, any time `score` is changed by anyone, our score label will be updated. That's it, the project is done!

