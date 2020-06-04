# Day 13, Week 11
:calendar: – Thursday June 04, 2020

*At home* :house:

:rocket: **Consolidation : Day 1**

## :one:  [Variables and constants](https://www.hackingwithswift.com/read/0/2/variables-and-constants) 

>Every useful program needs to store data at some point, and in Swift there are two ways to do it: variables and constants. A variable is a data store that can have its value changed whenever you want, and a constant is a data store that you set once and can never change. So, variables have values that can vary, and constants have values that are constant – easy, right?
>
>Having both these options might seem pointless, after all you could just create a variable then never change it – why does it need to be made a constant? Well, it turns out that many programmers are – shock! – less than perfect at programming, and we make mistakes.
>
>One of the advantages of separating constants and variables is that Xcode will tell us if we've made a mistake. 

Reduce attention needed, trust IDE

>If we say, "make this date a constant, because I know it will never change" then 10 lines later try to change it, Xcode will refuse to build our app.
>
>Constants are also important because they let Xcode make decisions about the way it builds your app. *If it knows a value will never change, it is able to **apply optimizations** to make your code run faster.*

:bullettrain_side: speeeeed

>In Swift, you make a variable using the `var` keyword, like this:

```swift
var name = "Tim McGraw"
```

>Because this is a variable, you can change it whenever you want, but you shouldn't use the var keyword each time – that's only used when you're declaring new variables. Try writing this:

```swift
var name = "Tim McGraw"
name = "Romeo"
```

>:white_check_mark: So, the first line creates the name variable and gives it an initial value, then the second line *updates the name variable* so that its value is now "Romeo". You'll see both values printed in the results area of the playground.
>
>Now, what if we had made that a constant rather than a variable? Well, constants use the `let` keyword rather than `var`, so you can change your first line of code to say `let name` rather than var name like this:

```swift
import UIKit
let name = "Tim McGraw"
name = "Romeo"
```

> :x: But now there's a problem: Xcode is showing a red warning symbol next to line three, and it should have drawn a squiggly underline underneath your code. If you click the red warning symbol, Xcode will tell you the problem: "Cannot assign to 'let' value 'name'" – which is Xcode-speak for "you're trying to change a constant and you can't do that."
>
>So, constants are a great way to make a promise to Swift and to yourself that a value won't change, because if you do try to change it Xcode will refuse to run. Swift developers have a strong preference to use constants wherever possible because it makes your code easier to understand. In fact, in the very latest versions of Swift, Xcode will actually tell you if you make something a variable then never change it!
>
>Important note: variable and constant names must be unique in your code. You'll get an error if you try to use the same variable name twice, like this:

```swift
var name = "Tim McGraw"
var name = "Romeo"
```

>If the playground finds an error in your code, it will either flag up a warning in a red box, or will just refuse to run. You'll know if the latter has happened because the text in the results pane has gone gray rather than its usual black.

## :two:  [Types of data](https://www.hackingwithswift.com/read/0/3/types-of-data) 

>There are lots of kinds of data, and Swift handles them all individually. You already saw one of the most important types when you assigned some text to a variable, but in Swift this is called a `String` – literally a string of characters.

### `String`

>`Strings` can be long (e.g. a million letters or more), short (e.g. 10 letters) or even empty (no letters), it doesn't matter: they are all strings in Swift's eyes, and all work the same. 
>
>Swift knows that `name` should hold a string because you assign a string to it when you create it: "Tim McGraw". 
>
> :x:  If you were to rewrite your code to this it would stop working:

```swift
var name
name = "Tim McGraw"
```

>This time Xcode will give you an error message that won't make much sense just yet: "Type annotation missing in pattern". What it means is, **"I can't figure out what data type `name` is because you aren't giving me enough information."**

Understanding how your ide words = understanding language syntax

>At this point you have two options: 
>1) either create your variable and give it an initial value on one line of code, 
>2) or use what's called a **type annotation**, which is where you tell Swift what data type the variable will hold later on, even though you aren't giving it a value right now.

**type annotation** : *(swift)* where you tell Swift what data type the variable will hold later on, even though you aren't giving it a value right now

>You've already seen how the first option looks, so let's look at the second: type annotations. 
>We know that `name` is going to be a string, so we can tell Swift that by writing a colon then `String`, like this:

```swift
var name: String
name = "Tim McGraw"
```

>**Note**: some people like to put a space before and after the colon, making `var name : String`, but they are wrong and *you should try to avoid mentioning their wrongness in polite company*.

:joy:

>The lesson here is that Swift always wants to know what type of data every variable or constant will hold. Always. 
>
>You can't escape it, and that's a good thing because it provides something called **type safety** – if you say "this will hold a string" then later try and put a rabbit in there, Swift will refuse.

**Type safety** goes into security of not just building but also intrution right ?

### `Int`

>We can try this out now by introducing another important data type, called `Int`, which is short for "integer." Integers are round numbers like 3, 30, 300, or -16777216. For example:

```swift
var name: String
name = "Tim McGraw"

var age: Int
age = 25
```

>That declares one variable to be a string and one to be an integer. 
>
>Note *how both String and Int have capital letters at the start, whereas name and age do not* – this is the standard coding convention in Swift. 
>
>A **coding convention** is something that doesn't matter to Swift (you can write your names how you like!) but does matter to other developers. In this case, data types start with a capital letter, whereas variables and constants do not.

**coding convention** : *(programming)* something that doesn't matter to the programming language but does to the developper communties standards

>Now that we have variables of two different types, you can see type safety in action. Try writing this:

```swift
name = 25
age = "Tim McGraw"
```

>In that code, you're trying to put an integer into a string variable, and a string into an integer variable – and, thankfully, Xcode will throw up errors. You might think this is pedantic, but it's actually quite helpful: *you make a promise that a variable will hold one particular type of data,* and **Xcode will enforce that throughout your work**.

**implied typing** is what this is called right? Are there other languages that can do this?

Is the enforcement the same as type safe via *type annotaiton*?

>Before you go on, please delete those two lines of code causing the error, otherwise nothing in your playground will work going forward!

### `Float` and `Double`

>Let's look at two more data types, called `Float` and `Double`. This is Swift's way of storing numbers with a fractional component, such as 3.1, 3.141, 3.1415926, and -16777216.5. 
>
>There are two data types for this because *you get to choose how much accuracy you want*, but most of the time it doesn't matter so **the official Apple recommendation** is always to use `Double` because it has *the highest accuracy*.

Does this "accuracy" end up effecting performance these days if it's too broadly applied? How much can be gaine to switching to something else?

>Try putting this into your playground:

```swift
var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -86.783333
```

>You can see both numbers appear on the right, but look carefully because there's a *tiny discrepancy*. 
>
>We said that `longitude` should be equal to -86.783333, but in the results pane you'll see -86.78333 – it's missing one last 3 on the end. 
>
>Now, you might well say, *"what does 0.000003 matter among friends?"* but this is ably demonstrating what I was saying about **accuracy**.
>
>Because these playgrounds update as you type, we can try things out so you can see exactly how Float and Double differ. Try changing the code to be this:

```swift
var longitude: Float
longitude = -86.783333
longitude = -186.783333
longitude = -1286.783333
longitude = -12386.783333
longitude = -123486.783333
longitude = -1234586.783333
```

>That's adding increasing numbers before the decimal point, while keeping the same amount of numbers after. 
>
>But if you look in the results pane you'll notice that as you add more numbers before the point, Swift is removing numbers after. 
>
>*This is because it has **limited space in which to store** your number,* so it's storing the most important part first – being off by 1,000,000 is a big thing, whereas being off by 0.000003 is less so.

What is it *limited **by*** then?

>Now try changing the `Float` to be a `Double` and you'll see Swift prints the correct number out every time:

```swift
var longitude: Double
```

>This is because, again, `Double` has twice the accuracy of `Float` so it doesn't need to cut your number to fit. Doubles still have limits, though – if you were to try a massive number like 123456789.123456789 you would see it gets cut down to 123456789.1234568.

### `Boolean`

>Swift has a built-in data type that can store whether a value is true or false, called a Bool, short for Boolean. Bools don't have space for "maybe" or "perhaps", only absolutes: true or false. For example:

```swift
var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat: Bool
missABeat = false
```

>**Tip**: You’ll notice these variables are written in a very particular way: we don’t write MissABeat, missabeat, or other such variations, but instead make the initial letter lowercase then capitalize the first letter of the second and subsequent words. This is called **“camel case”** because it looks a bit like the humps of a camel, and it’s used to make it easier to read words in variable names.

:camel: :metal:

### Using type annotations wisely

>As you've learned, there are two ways to tell Swift what type of data a variable holds: assign a value when you create the variable, or use a type annotation. 
>
>If you have a choice, the first is **always preferable because it's clearer**. 
>
>For example:

```swift
var name = "Tim McGraw"
```

>…is preferred to:

```swift
var name: String
name = "Tim McGraw"
```

Meh, depends, sometimes that variable is going to be reused other places, esp when we start doing networking.

>This applies to all data types. For example:

```swift
var age = 25
var longitude = -86.783333
var nothingInBrain = true
```

>This technique is called **type inference**, because Swift can infer what data type should be used for a variable by looking at the type of data you want to put in there. 

**type inference** : *(swift)* Swift can *infer* what data type we should use for a variable by looking at the type of data you want to put in there.

>When it comes to numbers like -86.783333, Swift will always infer a Double rather than a Float.
>
>For the sake of completeness, I should add that it's possible to specify a data type and provide a value at the same time, like this:

```swift
var name: String = "Tim McGraw"
```

:rainbow: :sparkles: