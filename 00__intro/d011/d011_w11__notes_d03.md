# Day 11(3), Week 11
:calendar: – Tuesday May 26, 2020

*At home* :house:

## :two:  [Protocol Inheritance](https://www.hackingwithswift.com/sixty/9/2/protocol-inheritance) 

>One protocol can inherit from another in a process known as **protocol inheritance**. 
>
>Unlike with classes, you can inherit from multiple protocols at the same time before you add your own customizations on top.

>We’re going to define three protocols: `Payable` requires conforming types to implement a `calculateWages() `method, `NeedsTraining` requires conforming types to implement a `study()` method, and `HasVacation` requires conforming types to implement a `takeVacation()` method:

```swift
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}
```

>We can now create a single Employee protocol that brings them together in one protocol. We don’t need to add anything on top, so we’ll just write open and close braces:

```swift
/// single protocol that `inhereits` all previous ones
protocol Employee: Payable, NeedsTraining, HasVacation { }
```

>Now we can make new types conform to that single protocol rather than each of the three individual ones.

### :boom: Quiz insights

```swift
protocol Buyable {
	var cost: Int
}
protocol Sellable {
	func findBuyers() -> [String]
}
protocol FineArt: Buyable, Sellable { }
```

:x: Oops – that's not correct. The cost property must have `{ get }` or `{ get set }` after it.

```swift
protocol GivesOrders {
	func makeItSo()
}
protocol OrdersDrinks {
	func teaEarlGrey(hot: Bool)
}
protocol StarshipCaptain: GivesOrders, OrdersDrinks { }
```
:white_check_mark: 

```swift
protocol HasEngine {
	func startEngine()
}
protocol HasTrunk {
	func openTrunk()
}
struct Car: HasEngine, HasTrunk { }
```
:x: Oops – that's not correct. Although Car conforms to both protocols, there is no protocol inheritance here – neither protocol builds on the other.

## :three:  [Extensions](https://www.hackingwithswift.com/sixty/9/3/extensions) 

>**Extensions** allow you to add methods to existing types, to make them do things they weren’t originally designed to do.
>
>For example, we could add an extension to the `Int` type so that it has a `squared()` method that returns the current number multiplied by itself:

```swift
extension Int {
    func squared() -> Int {
        return self * self
    }
}
```

>To try that out, just create an integer and you’ll see it now has a squared() method:

```swift
let number = 8
number.squared()
```

>*Swift doesn’t let you add stored properties in extensions, so you must use computed properties instead.*

:question: What is the difference between "stored properties" and "computed properties" again?

:pushpin: [**Swift Doc**](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) : *Properties*

| stored | computed |
|:---|:---|
| *"In its simplest form, a stored property is a constant or variable that is stored as part of an instance of a particular class or structure. Stored properties can be either variable stored properties (introduced by the var keyword) or constant stored properties (introduced by the let keyword)."* | *"...do not actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly."* |

>For example, we could add a new `isEven` computed property to integers that returns true if it holds an even number:

```swift
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
```

### Coded all togetehr

```swift
import UIKit

/// if we extend the type `Int` so that it can be squared
extension Int {
    func squared() -> Int {
        return self * self
    }
}

/// this number is implied to be of type `Int`
let number = 8
number.squared()

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

/// get a `bool` statement, testing this `int`
number.isEven
```

### :boom: Quiz insights

```swift
extension String {
	func append(_ other: String) {
		self += other
	}
}
```
:x: Oops – that's not correct. The `append()` method must be marked mutating.

```swift
extension Int {
	var isAnswerToLifeUniverseAndEverything: Bool {
		let target = 42
		self == target
	}
}
```
:x: Oops – that's not correct. This computed property doesn't actually return a value.

```swift
extension Bool {
	func toggled() -> Bool {
		if self = true {
			return false
		} else {
			return true
		}
	}
}
```

:x: Oops – that's not correct. `if self = true `should read `if self == true`.

## :four:  [Protocol extensions](https://www.hackingwithswift.com/sixty/9/4/protocol-extensions) 

>**Protocols let you describe what methods something should have, but don’t provide the code inside.** 
>
>Extensions let you provide the code inside your methods, **but** *only affect one data type – you can’t add the method to lots of types at the same time.*
>
>Protocol extensions solve both those problems: they are like regular extensions, except rather than extending a specific type like `Int` you extend a whole protocol so that all conforming types get your changes.
>
>For example, here is an array and a set containing some names:

```swift
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
```

>Swift’s arrays and sets both conform to a protocol called `Collection`, so we can write an extension to that protocol to add a `summarize()` method to print the collection neatly

```swift
extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}
```

>Both `Array` and `Set` will now have that method, so we can try it out:

```swift
pythons.summarize()
beatles.summarize()
```

### :boom: Quiz insights

**This extension correctly implements a method from its protocol – true or false?**

```swift
protocol SmartPhone {
	func makeCall(to name { get set })
}
extension SmartPhone {
	func makeCall(to name: String) {
		print("Dialling \(name)...")
	}
}
```
:x: Correct! `makeCall(to name { get set })` is invalid syntax.

```swift
protocol Club {
	func organizeMeeting(day: String)
}
extension Club {
	override func organizeMeeting(day: String) {
		print("We're going to meet on \(day).")
	}
}
```
:x: Oops – that's not correct. The `override` keyword must not be used here.

## :five:  [Protocol-oriented Programming](https://www.hackingwithswift.com/sixty/9/5/protocol-oriented-programming) 

>Protocol extensions can provide default implementations for our own protocol methods. This makes it easy for types to conform to a protocol, and allows a technique called “protocol-oriented programming” – crafting your code around protocols and protocol extensions.
>
>First, here’s a protocol called `Identifiable` that requires any conforming type to have an id property and an `identify()` method:

```swift
protocol Identifiable {
    var id: String { get set }
    func identify()
}
```

>We could make every conforming type write their own `identify()` method, but protocol extensions allow us to provide a default:

```swift
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}
```
>Now when we create a type that conforms to `Identifiable` it gets `identify()` automatically:

```swift
struct User: Identifiable {
    var id: String
}

let twostraws = User(id: "twostraws")
twostraws.identify()
```

### Coded all together

```swift
import UIKit

/// protocol with stored properities and comuted property
protocol Identifiable {
    var id: String { get set }
    func identify()
}

/// implemented the protocol
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}

/// structure adheres to the protocol
struct User: Identifiable {
    var id: String
}

let twostraws = User(id: "twostraws")
twostraws.identify()
```

### :boom: Quiz insights

**Which of these are true about protocols?**

* Protocols can mark properties as read-only or read-write.
* You can write extensions for protocols to provide default implementations. This lets us share code more easily.
* You can write extensions for Swift's built-in protocols. This lets us add functionality very quickly.
* Each type can conform to as many protocols as you want. This is correct.
* Protocols specify what methods and properties conforming types must have. This is correct.
* Only extensions can contain method implementations.
> :pushpin: [**Swift Doc**](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) : *Extensions*

## :arrow_right_hook: [Protocols and extensions summary](https://www.hackingwithswift.com/sixty/9/6/protocols-and-extensions-summary) 

>You’ve made it to the end of the ninth part of this series, so let’s summarize:
>
>1) Protocols describe what methods and properties a conforming type must have, but don’t provide the implementations of those methods.
>2) You can build protocols on top of other protocols, similar to classes.
>3) Extensions let you add methods and computed properties to specific types such as Int.
>4) Protocol extensions let you add methods and computed properties to protocols.
>5) Protocol-oriented programming is the practice of designing your app architecture as a series of protocols, then using protocol extensions to provide default method implementations.
