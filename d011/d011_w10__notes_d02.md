# Day 11(2), Week 11
:calendar: – Monday May 25, 2020

*At home* :house:

Continuing the theme of **Protocols and Extensions**

## :one:  [Protocols](https://www.hackingwithswift.com/sixty/9/1/protocols) **(con't)**

Protocols are a description, not a type,b ut you can write something that **conforms** to it.

The full example I came up with in testing example code with *playground* :

```swift
import UIKit

protocol Identifiable {
    var id: String { get set }
}

/// this structure `conforms` to the protocol
struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

/// create an instance of `struct User`
var jamie = User(id: "JB")
/// `func` to print my id using the structure that conforms to the protocol
displayID(thing: jamie)

```

:pushpin: [**Swift Doc**](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html) : *Protocols*

Helped with examples of using procotols

:question: *What is the use of differntiating between somethingt that **conforms** rather than is an instance?*
> how did this evolve as a need in a programing language rather than pure OOP ?

### :boom: Quiz insights

```swift
protocol Climbable {
	var height: Double { get }
	var gradient: Int { get }
}
```

:white_check_mark: 

:x: `{get set}` should not have comma inside

```swift
protocol Buildable {
	var numberOfBricks: Int { set }
	var materials: [String] { set }
}
```
:x: Oops – that's not correct. It's not possible to create set-only properties in Swift.

