# Day 6, Week 3

:calendar: – Saturday April 11, 2020 

*At home* :house:

**Closures, part one** subject

> Please keep in mind Flip Wilson's law: “you can't expect to hit the jackpot if you don't put a few nickels in the machine.”
>
>Initially you’ll think that closures are simply anonymous functions – functions we can create and assign directly to a variable, then pass that variable around as if it were a string or an integer.
>
>However, closures complicate things in two ways:
>
>* **Their syntax can hurt your brain,** and even explanations of their syntax can hurt your brain. 
>    * For example, if a closure returns an integer, and you write a function that returns that closure, then you might read something like “this function returns a closure that returns an integer.” Yeah, I know – it’s hard.
>* If values used inside a closure were created outside the closure then *Swift will make sure they remain available for* **the life of the closure** so you don’t accidentally try to read something that doesn’t exist any more.
>
>To make things easier to understand we start with fairly simple closures that might almost seem pointless, but as we progress on day two (yes, there’s a second day of closures!) you’ll start to see more advanced scenarios that build on what you learn today.

## :one: [Creating basic closures](https://www.hackingwithswift.com/sixty/6/1/creating-basic-closures)

>Swift lets us use functions just like any other type such as strings and integers. This means you can create a function and assign it to a variable, call that function using that variable, and even pass that function into other functions as parameters.

```swift
let driving = {
    print("I'm driving in my car")
}

driving()
```

### :boom: Quiz insights

```swift
var signAutograph(to name: String) = {
	print("To \(name), my #1 fan")
}
signAutograph(to: "Lisa")
```

:x: This is not valid swift.
>Oops – that's not correct. Unlike functions, closures put their parameters inside the opening brace.

```swift
var paintPicture() {
	print("Where are my watercolors?")
}
```

:white_check_mark: This is valid swift
>Correct! This should `read var paintPicture = {`.

## :two: [Accepting paraemters in a closure](https://www.hackingwithswift.com/sixty/6/2/accepting-parameters-in-a-closure)

>When you create closures, they don’t have a name or space to write any parameters. That doesn’t mean they can’t accept parameters, just that they do so in a different way: they are listed inside the open braces.
>
>To make a closure accept parameters, list them inside parentheses just after the opening brace, then write `in` so that Swift knows the main body of the closure is starting.

```swift
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

driving("London")
```
### :boom: Quiz insights

```swift
var pickFruit = { (name: String) in
	switch name {
	case strawberry:
		fallthrough
	case raspberry:
		print("Strawberries and raspberries are half price!")
	default:
		print("We don't have those.")
	}
}

pickFruit("strawberry")
```

:x: This is not valid swift.
>Oops – that's not correct. This is trying to do case matching on strings, but doesn't wrap "strawberry" or "raspberry" in quote marks.

```swift
let calculateResult = { (answer) in
	if answer == 42 {
		print("You're correct!")
	} else {
		print("Try again.")
	}
}
```

:x: This is not valid swift.
>Oops – that's not correct. Swift is unable to figure out what type of data answer is.

```swift
var cutGrass = { (length currentLength: Double) in
	switch currentLength {
	case 0...1:
		print("That's too short")
	case 1...3:
		print("It's already the right length")
	default:
		print("That's perfect.")
	}
}
```

:x: This is not valid swift
>Oops – that's not correct. Closures cannot use external parameter labels.

## :three: [Returning values from a closure](https://www.hackingwithswift.com/sixty/6/3/returning-values-from-a-closure)

>Closures can also return values, and they are written similarly to parameters: you write them inside your closure, directly before the `in` keyword.
>
>To demonstrate this, we’re going to take our `driving()` closure and make it return its value rather than print it directly.

```swift
/// original
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}
/// want to return rather than print, therefore need the `-> String`
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
/// running and then printing message
let message = drivingWithReturn("London")
print(message)
```

### :boom: Quiz insights

```swift
var buyMagazine = { (name: String) -> Int in
	let amount = 10
	print("\(name) costs \(amount)")
	return amount
}
buyMagazine(name: "Wired")
```

:x: This is not valid swift.

>Oops – that's not correct. We don't use parameter names when calling a closure.

## :four: [Closures as parameters](https://www.hackingwithswift.com/sixty/6/4/closures-as-parameters)

>Because closures can be used just like strings and integers, you can pass them into functions. The syntax for this can hurt your brain at first, so we’re going to take it slow.

```swift
/// starting point
let driving = {
    print("I'm driving in my car")
}
```

>If we wanted to pass that closure into a **function so it can be run inside that function**, we would specify the parameter type as `() -> Void`. That means “accepts no parameters, and returns `Void`" – Swift’s way of saying “nothing”.
>
>So, we can write a travel() function that accepts different kinds of traveling actions, and prints a message before and after

```swift
/// declare so you can run a function insaide
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

/// call
travel(action: driving)
```

### :boom: Quiz insights

```swift
let awesomeTalk = {
	print("Here's a great talk!")
}
func deliverTalk(name: String, type: () -> Void) {
	print("My talk is called \(name)")
	type()
}
deliverTalk(name: "My Awesome Talk", type: awesomeTalk)
```

:white_check_mark:  This is valid swift
>Oops – that's not correct. This code is valid Swift.

```swift
var payCash = {
	print("Here's the money.")
}
func buyClothes(item: String, using payment: () -> Void) {
	print("I'll take this \(item).")
	payment()
}
buyClothes(item: "jacket", using: payCash)
```
:white_check_mark: This is valid swift

>Oops – that's not correct. This code is valid Swift.

```swift
let driveSafely = {
	return "I'm being a considerate driver"
}
func drive(using driving: () -> Void) {
	print("Let's get in the car")
	driving()
	print("We're there!")
}
drive(using: driveSafely)
```

>Oops – that's not correct. `drive()` says its parameter must be a closure that accepts no parameters and returns nothing, but the closure it is given returns a string.

## :five: [Trailing closure syntax](https://www.hackingwithswift.com/sixty/6/5/trailing-closure-syntax)

>If the last parameter to a function is a closure, Swift lets you use special syntax called **trailing closure syntax**. Rather than pass in your closure as a parameter, you pass it directly after the function inside braces.

```swift
/// `func` that accepts
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    /// closure
    action()
    print("I arrived!")
}

/// calling `travel` with trailing closure syntax
travel() {
    print("I'm driving in my car")
}

/// don't need paranetheses
travel() {
    print("I'm driving in my car")
}
```