# Day 12, Week 11
:calendar: – Tuesday May 26, 2020

*At home* :house:

- [Day 12, Week 11](#day-12-week-11)
  - [:one:  Handling missing data](#one--handling-missing-data)
    - [:boom: Quiz insights](#boom-quiz-insights)
  - [:two:  Unwrapping optionals](#two--unwrapping-optionals)
    - [Coded all together](#coded-all-together)
    - [:boom: Quiz insights](#boom-quiz-insights-1)
  - [:three:  Unwrapping with guard](#three--unwrapping-with-guard)

Today's subject is **Optionals** ! :)

>Null references – literally when a variable has no value – were invented by [Tony Hoare](https://en.wikipedia.org/wiki/Tony_Hoare) way back in 1965. When asked about it in retrospect, he said “I call it my billion-dollar mistake” because they lead to so many problems.

Damn, we can actually point back to a specific person for this ? Cool !

>This is the last day that you’ll be learning the fundamentals of Swift, and it’s devoted exclusively to Swift’s solution to null references, known as optionals. These are a really important language feature, but they can hurt your brain a little – don’t feel bad if you need to repeat some videos a few times.
>
>Today you have 11 one-minute videos to watch, and you’ll meet unwrapping, optional chaining, typecasting, and more. Once you’ve watched each video there’s a short test to help make sure you’ve understood what was taught.

## :one:  [Handling missing data](https://www.hackingwithswift.com/sixty/10/1/handling-missing-data) 

>We’ve used types such as Int to hold values like 5. But if you wanted to store an age property for users, *what would you do if you didn’t know someone’s age?*
>
>You might say “well, I’ll store 0”, but then you would get confused between new-born babies and people whose age you don’t know. 
>
>You could use a special number such as 1000 or -1 to represent “unknown”, both of which are impossible ages, but then would you really remember that number in all the places it’s used?

Lol, I remember trying this kind of a solution first year at EEMI.

>Swift’s solution is called **optionals**, and you can make optionals out of any type. 
>* An optional integer might have a number like 0 or 40, but it might have no value at all – it might literally be missing, which is nil in Swift.
>
>To make a type optional, add a question mark after it. For example, we can make an optional integer like this:

```swift
var age: Int? = nil
```

>That doesn’t hold any number – it holds nothing. But if we later learn that age, we can use it:

```swift
age = 38
```

### :boom: Quiz insights

**Which of these make good candidates for optionals?**

```swift
The capital city of a country your user just typed in.
```
The user may have made a mistake with their typing and the country might not exist.

```swift
Someone's birthday if you know it.
```
You might not know their birthday.

```swift
The year a user last went on a boat.
```
The user might not have ever been on a boat.

```swift
The current destination of a car's satellite navigation system.
```
There may or may not be a current destination set.

```swift
Someone's middle name.
```
A person may or may not have a middle name

```swift
The position of an item in an array.
```
The item may or may not exist in the array.

## :two:  [Unwrapping optionals](https://www.hackingwithswift.com/sixty/10/2/unwrapping-optionals) 

>Optional strings might contain a string like “Hello” or they might be nil – nothing at all.
>
>Consider this optional string:

```swift
var name: String? = nil
```

>What happens if we use `name.count?` A real string has a count property that stores how many letters it has, but this is nil – *it’s empty memory*, not a string, so it doesn’t have a count.
>
>Because of this, trying to read `name.count` is unsafe and Swift won’t allow it. 
>
>Instead, *we must look inside the optional and see what’s there*– a process known as **unwrapping**.
>
>A common way of unwrapping optionals is with `if let `syntax, which **unwraps** with a condition. 
>* If there was a value inside the optional then you can use it, but if there wasn’t the condition fails.
>
>For example:

```swift
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}
```

>If `name` holds a string, it will be put inside `unwrapped` as a regular `String` and we can read its `count` property inside the condition. Alternatively, if name is `empty`, the else code will be run.

### Coded all together

```swift
import UIKit

var name: String? = nil
name = "jamie"
/// resolve `name.count
/// unwrap via `if let` condition
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}
```

### :boom: Quiz insights

```swift
let menuItems: [String]? = ["Pizza", "Pasta"]
if let items = menuItems {
	print("There are \(menuItems.count) items to choose from.")
}
```
:x: Oops – that's not correct. This attempts to use `menuItems` inside the `if let`, when really it should use items.

```swift
var score: Int = nil
score = 556
if let playerScore = score {
	print("You scored \(playerScore) points.")
}
```
:x: Oops – that's not correct. This attempts to assign nil to a non-optional integer.

:star:

```swift
let favoriteTennisPlayer: String? = "Andy Murray"
if let player {
	print("Let's watch \(player)'s highlights video on YouTube.")
}
```
:x: Oops – that's not correct. `if let` needs to bind an optional to a new, unwrapped name, such as `if let player = player`.

## :three:  [Unwrapping with guard](https://www.hackingwithswift.com/sixty/10/3/unwrapping-with-guard) 

