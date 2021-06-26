# Day 12(3), Week 11
:calendar: – Thursday May 28, 2020

*At home* :house:

Continued **Optionals**

- [Day 12(3), Week 11](#day-123-week-11)
	- [:three:  Unwrapping with guard](#three--unwrapping-with-guard)
		- [:boom: Quiz insights](#boom-quiz-insights)
	- [:four: Force unwrapping](#four-force-unwrapping)
		- [:boom: Quiz insights](#boom-quiz-insights-1)
	- [:five:  Implicity unwrapped optionals](#five--implicity-unwrapped-optionals)
		- [:boom: Quiz insights](#boom-quiz-insights-2)
	- [:six:  Nil coalescing](#six--nil-coalescing)
	- [:seven:  Optional chaining](#seven--optional-chaining)
		- [:boom: Quiz insights](#boom-quiz-insights-3)
	- [:eight:  Optional try](#eight--optional-try)
		- [normal optional](#normal-optional)
		- [forced unwrapping optional](#forced-unwrapping-optional)
		- [:boom: Quiz insights](#boom-quiz-insights-4)
	- [:nine: Failable initializers](#nine-failable-initializers)
		- [:boom: Quiz insights](#boom-quiz-insights-5)
	- [:one::zero:  Typecasting](#onezero--typecasting)
		- [:boom: Quiz insights](#boom-quiz-insights-6)
	- [:arrow_right_hook: Optionals summary](#arrow_right_hook-optionals-summary)

## :three:  [Unwrapping with guard](https://www.hackingwithswift.com/sixty/10/3/unwrapping-with-guard) 

### :boom: Quiz insights

```swift
let lightsaberColor: String? = "green"
let color = lightsaberColor ?? "blue"
```
:white_check_mark: 

```swift
var conferenceName: String? = "WWDC"
var conference: String = conferenceName ?? nil
```
:x: This code could result in trying to assign `nil` to `conference`, which is not allowed.

```swift
let userID: Int? = 556
let id = userID ?? "Unknown"
```
:x: This attempts to use nil coalescing across different types, which isn't allowed.

```swift
let jeansNumber: Int? = nil
let jeans = jeansNumber ? 501
```
:x: Nil coalescing uses two question marks, not one.

**This code will print a message – true or false?**

```swift
func playScale(name: String?) {
	guard let name = name {
		return
	}
	print("Playing the \(name) scale.")
}
playScale(name: "C")
```
:x: False, `guard` must be followed by `else`.

```swift
func uppercase(string: String?) -> String? {
	guard let string = string else {
		return nil
	}
	return string.uppercased()
}
if let result = uppercase(string: "Hello") {
	print(result)
}
```
:white_check_mark: True

```swift
func describe(occupation: String?) {
	guard let occupation = occupation else {
		print("You don't have a job.")
		return
	}
	print("You are an \(occupation).")
}
let job = "engineer"
describe(occupation: job)
```
:white_check_mark: 

```swift
func plantTree(_ type: String?) {
	guard let type else {
		return
	}
	print("Planting a \(type).")
}
plantTree("willow")
```
:x: This needs to provide a name for the unwrapped `type` parameter, such as `guard let type = type else`.

## :four: [Force unwrapping](https://www.hackingwithswift.com/sixty/10/4/force-unwrapping) 

>Optionals represent data that may or may not be there, *but sometimes you know for sure that a value isn’t nil*. 
>* In these cases, Swift lets you **force unwrap** the optional: convert it from an optional type to a non-optional type.
>
>For example, if you have a string that contains a number, you can convert it to an `Int` like this:

```swift
let str = "5"
let num = Int(str)
```

>That makes `num` an *optional* `Int` because you might have tried to convert a string like “Fish” rather than “5”.
>
>Even though Swift isn’t sure the conversion will work, you can see the code is safe so you can force unwrap the result by writing `!` after `Int(str)`, like this:

```swift
let num = Int(str)!
```

>Swift will immediately unwrap the optional and make `num` a regular `Int` rather than an `Int?`. But if you’re wrong – if `str` was something that couldn’t be converted to an integer – your code will crash.
>
>As a result, you should force unwrap only when you’re sure it’s safe – there’s a reason it’s often called the crash operator.

### :boom: Quiz insights

```swift
let legoBricksSold: Int? = 400_000_000_000
let numberSold = legoBricksSold!
```
:white_check_mark: 

```swift
func league(for skillLevel: Int) -> Int? {
	switch skillLevel {
	case 1:
		fallthrough
	case 2:
		return 3
	case 3:
		return 2
	case 4:
		return 1
	default:
		return nil
	}
}
let allocatedLeague = league(for: 3)!
```
:white_check_mark: 

## :five:  [Implicity unwrapped optionals](https://www.hackingwithswift.com/sixty/10/5/implicitly-unwrapped-optionals) 

>Like regular optionals, **implicitly unwrapped** optionals might contain a value or they might be `nil`. 
>
>However, unlike regular optionals **you don’t need to unwrap them in order to use them**:* you can use them as if they weren’t optional at all*.

What?? It's an optional without being an optional.

>:star: Implicitly unwrapped optionals are created by adding an **exclamation mark after your type name**, like this:

```swift
let age: Int! = nil
```

>Because they behave as if they were already unwrapped, you don’t need `if let` or `guard let` to use implicitly unwrapped optionals. *However, if you try to use them and they have no value – if they are `nil` – your code crashes.*
>
>Implicitly unwrapped optionals exist because sometimes a variable will start life as nil, but will always have a value before you need to use it. 
>
>Because you know they will have a value by the time you need them, it’s helpful not having to write `if let` all the time.

Interesting :thinking:

>That being said, if you’re able to use regular optionals instead it’s generally a good idea.

:memo:

### :boom: Quiz insights

**Which of these are true about optionals?**

* Swift uses nil to represent the absence of a value.
* A `String!` does not need to be unwrapped before use. If you access an implicitly unwrapped optional while it contains nil, your code will crash.
* A String? must be unwrapped before use.
* Optionals allow us to represent the absence of a value. They can store a regular value for their type or nil.

## :six:  [Nil coalescing](https://www.hackingwithswift.com/sixty/10/6/nil-coalescing) 

>The **nil coalescing operator** unwraps an optional and returns the value inside if there is one. 
>
>:star: If there isn’t a value – if the optional was `nil` – *then* a **default value** is used instead. 

omg I love these! :heart_eyes:

>**Either way, the result won’t be optional:** it will either by the value from inside the optional or the default value used as a back up.

:white_check_mark: Useful

>Here’s a function that accepts an integer as its only parameter and returns an optional string:

```swift
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}
```

>If we call that with ID 15 we’ll get back `nil` because the user isn’t recognized, but with nil coalescing we can provide a default value of “Anonymous” like this:

```swift
let user = username(for: 15) ?? "Anonymous"
```

>That will check the result that comes back from the `username()` function: if it’s a string then it will be unwrapped and placed into `user`, but if it has `nil` inside then “Anonymous” will be used instead.

## :seven:  [Optional chaining](https://www.hackingwithswift.com/sixty/10/7/optional-chaining)

>Swift provides us with *a shortcut* when using optionals: if you want to access something like `a.b.c` and `b` is optional, you can write a question mark after it to enable ***optional chaining***: `a.b?.c.`
>
>When that code is run, Swift will check whether `b` has a value, *and if* it’s `nil` **the rest of the line will be ignored** – Swift will return `nil` immediately. 
>
>But if it has a value, it will be unwrapped and execution will continue.
>
>To try this out, here’s an array of names:

```swift
let names = ["John", "Paul", "George", "Ringo"]
```

>We’re going to use the `first` property of that array, which will return the first name if there is one or `nil` if the array is empty. We can then call `uppercased()` on the result to make it an uppercase string:

```swift
let beatle = names.first?.uppercased()
```

>That question mark is optional chaining – *if* `first` returns nil *then* Swift won’t try to uppercase it, and will set `beatle` to `nil` immediately.

### :boom: Quiz insights

**This code is valid Swift – true or false?**

```swift
let names = ["Taylor", "Paul", "Adele"]
let lengthOfLast = names.last?.count?
```
:x: The `count` property is not optional, so this should read `names.last?.count`.

```swift
let credentials = ["twostraws", "fr0sties"]
let lowercaseUsername = credentials.first.lowercased()
```
:x: Accessing the `first` property returns an optional, so this should read `credentials.first?.lowercased()`.

```swift
let songs: [String]? = [String]()
let finalSong = songs?.last?.uppercased()
```
:white_check_mark: 

```swift
func albumReleased(in year: Int) -> String? {
	switch year {
	case 2006: return "Taylor Swift"
	case 2008: return "Fearless"
	case 2010: return "Speak Now"
	case 2012: return "Red"
	case 2014: return "1989"
	case 2017: return "Reputation"
	default: return nil
	}
}
let album = albumReleased(in: 2006)?.uppercased()
```
:white_check_mark: 

## :eight:  [Optional try](https://www.hackingwithswift.com/sixty/10/8/optional-try) 

>Back when we were talking about throwing functions, we looked at this code:

```swift
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
```

>That runs **a throwing function**, using `do`, `try`, and `catch` to handle errors gracefully.

But why would you need this specifically in this kind of a situation? I don't think I've seen this yet in a real code base.

>*There are two alternatives* to `try`, both of which will make more sense now that you understand optionals and force unwrapping.

### normal optional

>**The first** is `try?`, and changes throwing functions into functions that return an optional. If the function throws an error you’ll be sent `nil` as the result, otherwise you’ll get the return value wrapped as an optional.
>
>Using `try?` we can run `checkPassword()` like this:

```swift
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}
```

### forced unwrapping optional

>**The other alternative** is `try!`, which you can use when you know for sure that the function will not fail. If the function does throw an error, your code will crash.
>
>Using `try!` we can rewrite the code to this:

```swift
try! checkPassword("sekrit")
print("OK!")
```

### :boom: Quiz insights

**Which of these are true about throwing functions?**

* When using try you must catch all errors that can be thrown.
*  If you use try! and your call throws an error, your code crashes.
* Functions that throw errors must be marked `throws`.

:woman_shrugging: Don't know this one

* You can combine `try?` with `if let`
* Using `try?` converts a function's return value into an optional.

:woman_shrugging: I don't understand the consequences of this point.

* If you use `try` you must either catch the error or mark your function as `throws`

## :nine: [Failable initializers](https://www.hackingwithswift.com/sixty/10/9/failable-initializers) 

>When talking about force unwrapping, I used this code:

```swift
let str = "5"
let num = Int(str)
```

>**That converts a string to an integer,** *but* because you might try to pass any string there what you actually get back is *an optional integer*.
>
>:warning: **This is a failable initializer**: an initializer that might work or might not. 
>
>You can write these in your own structs and classes by using `init?() `rather than `init()`, and return `nil` if something goes wrong. 
>
>The return value will then be an optional of your type, for you to unwrap however you want.
>
>As an example, we could code a `Person` struct that must be created using a nine-letter ID string. If anything other than a nine-letter string is used we’ll return `nil`, otherwise we’ll continue as normal.
>
>Here’s that in Swift:

```swift
struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}
```

### :boom: Quiz insights

**This code will result in a constant set to `nil` – true or false?**

```swift
struct Password {
	var text: String
	init?(input: String) {
		if input.count < 6 {
			print("Password too short.")
			return nil
		}
		text = input
	}
}
let password = Password(input: "hell0")
```
:white_check_mark: 

```swift
var hasForcePowers = "true"
let convertedHasForcePowers = Bool(hasForcePowers)
```
:x: This will result in a constant set to true.

```swift
struct DEFCONRating {
	var number: Int
	init?(number: Int) {
		guard number > 0 else { return nil }
		guard number <= 5 else { return nil }
		self.number = number
	}
}
let defcon = DEFCONRating(number: 6)
```
:x: This creates a DEFCONRating above 5, so the initializer will return nil.

```swift
var enabled = "False"
let convertedEnabled = Bool(enabled)
```
:x: Creating a Boolean from an invalid string might fail.

```swift
var rating = "5 stars"
let convertedRating = Int(rating)
```

:x: Creating an integer from an invalid string will fail.

```swift
class Hotel {
	var starRating: Int
	init?(rating: Int) {
		if rating <= 1 {
			print("This probably has bed bugs.")
			return nil
		}
		self.starRating = rating
	}
}
let hotelElan = Hotel(rating: 1)
```
:white_check_mark: 

## :one::zero:  [Typecasting](https://www.hackingwithswift.com/sixty/10/10/typecasting) 

>Swift *must always know the type* of each of your variables, but sometimes you know more information than Swift does. 

How? Doesn't it only know what we tell it?

>For example, here are three classes:

```swift
class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
```

>We can create a couple of fish and a couple of dogs, and put them into an array, like this:

```swift
let pets = [Fish(), Dog(), Fish(), Dog()]
```

>Swift can see both `Fish` and `Dog` inherit from the `Animal` class, so it uses type inference to make `pets` an array of `Animal`.
>
>*If* we want to loop over the `pets` array *and ask* all the dogs to bark, we need to perform a **typecast**:
* *Swift will check* to see whether each pet is a `Dog` object, and if it is we can then call `makeNoise()`.

Why are we talking about Swift like a person here? I'm a bit lost.

>This uses a new *keyword* called **`as?`**, which **returns an optional**: *it will be `nil` if the typecast failed, or a converted type otherwise*.

Okay? :crystal_ball: I trust you. But I want to ask *et alors?*

>Here’s how we write the loop in Swift:

```swift
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
```

### :boom: Quiz insights

**This code will print some output – true or false?**

```swift
class Museum {
	var name = "National Museum"
}
class HistoryMuseum: Museum { }
class ToyMuseum: Museum { }
let museum = ToyMuseum()
if let unwrappedMuseum = museum as? HistoryMuseum {
	print("This is the \(unwrappedMuseum.name).")
}
```

:x: `museum` is an instance of `ToyMuseum`, not `HistoryMuseum`, so the typecast will fail.

 ```swift
class Person {
	var name = "Taylor Swift"
}
class User: Person { }
let taylor = User()
if let user = taylor as? User {
	print("\(user.name) is a user.")
}
```
:white_check_mark: 

```swift
let flavor = "apple and mango"
if let taste = flavor as? String {
	print("We added \(taste).")
}
```
:white_check_mark: 

```swift
class Transport { }
class Train: Transport {
	var type = "public"
}
class Car: Transport {
	var type = "private"
}
let travelPlans = [Train(), Car(), Train()]
for plan in travelPlans {
	if let train = plan as? Train {
		print("We're taking \(train.type) transport.")
	}
}
```
:white_check_mark: 

```swift
class Glasses {
	var isShortSighted = true
}
struct Sunglasses: Glasses { }
let shades = Sunglasses()
if let glasses = shades as? Glasses {
	if glasses.isShortSighted {
		print("These sunglasses are for shortsighted people.")
	} else {
		print("These sunglasses are for longsighted people.")
	}
}
```
:x: `Sunglasses` is a `struct`, and cannot use class inheritance.


## :arrow_right_hook: [Optionals summary](https://www.hackingwithswift.com/sixty/10/11/optionals-summary) 

>You’ve made it to the end of the tenth part of this series, so let’s summarize:
>
>1) Optionals let us represent the absence of a value in a clear and unambiguous way.
>2) Swift won’t let us use optionals without unwrapping them, either using if let or using guard let.
>3) You can force unwrap optionals with an exclamation mark, but if you try to force unwrap nil your code will crash.
>4) Implicitly unwrapped optionals don’t have the safety checks of regular optionals.
>5) You can use nil coalescing to unwrap an optional and provide a default value if there was nothing inside.
>6) Optional chaining lets us write code to manipulate an optional, but if the optional turns out to be empty the code is ignored.
>7) You can use try? to convert a throwing function into an optional return value, or try! to crash if an error is thrown.
>8) If you need your initializer to fail when it’s given bad input, use init?() to make a failable initializer.
>9) You can use typecasting to convert one type of object to another.
