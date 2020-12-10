# Day 3, Week 3

:calendar: – Monday April 06, 2020

*At home* :house:

[Loops, Loops, and more Loops](https://www.hackingwithswift.com/100/4)

- [Day 3, Week 3](#day-3-week-3)
  - [:one: For loops](#one-for-loops)
## :one: [For loops](https://www.hackingwithswift.com/sixty/4/1/for-loops)

>Swift has a few ways of writing loops, but their underlying mechanism is the same: run some code repeatedly until a condition evaluates as false.
>
>The most common `loop` in Swift is a for loop: it will loop over **arrays** and **ranges**, and each time the loop goes around it will pull out one item and assign to a constant.

```swift
import UIKit

/// `range` looping and string interpolation
let count = 1...10
for number in count {
    print("Number is \(number)")
}

/// `array` looping and string interpolation
let albums = ["Red", "1989", "Reputation"]
for album in albums {
    print("\(album) is on Apple Music")
}

print("Players gonna ")
/// `_` to loop without a constant
for _ in 1...5 {
    print("play")
}

```

The output in the console is way more important than any of the other example snippets before.

:star: I didn't know about the `_` to replace a constant in a loop!
> I'm pretty sure this is used in functions declarations too.

