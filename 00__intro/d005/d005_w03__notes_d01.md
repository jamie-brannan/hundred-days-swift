# Day 5, Week 3

:calendar: – Thursday April 09, 2020

*At home* :house:

This chapter is all about [Functions, paremeters and errors](https://www.hackingwithswift.com/100/5)!

>Functions let us wrap up pieces of code so they can be used in lots of places. We can send data into functions to customize how they work, and get back data that tells us the result that was calculated.

## :one: [Writing functions](https://www.hackingwithswift.com/sixty/5/1/writing-functions)

>Functions let us re-use code, which means we can write a function to do something interesting then run that function from lots of places. 
>
>Repeating code is generally a bad idea, and functions help us avoid doing that.

Write it only once.

>Swift functions start with the `func` keyword, then your function name, then open and close parentheses. All the body of your function – the code that should be run when the function is requested – is placed inside braces.

```swift
func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""

    print(message)
}
printHelp()
```

Easy peasy.

## :two: [Accepting parameters](https://www.hackingwithswift.com/sixty/5/2/accepting-parameters)

>Functions become more powerful when they can be customized each time you run them. Swift lets you send values to a function that can then be used inside the function to change the way it behaves.

...

>Values sent into functions this way are called **parameters**.
>
>To make your own functions accept parameters, give each parameter a name, then a colon, then tell Swift the type of data it must be. All this goes inside the parentheses after your function name.

So you need to write a function :
* keyword `func`
* parameter a name
* a type of data for the parameter

```swift
func square(number: Int) {
    print(number * number)
}

square(number: 8)
```

## :three: [Returning values](https://www.hackingwithswift.com/sixty/5/3/returning-values)

>As well as receiving data, functions can also send back data. To do this, write a dash then a right angle bracket after your function’s parameter list, then tell Swift what kind of data will be returned.
>
>Inside your function, you use the `return` keyword to send a value back if you have one. Your function then immediately exits, sending back that value – no other code from that function will be run.

```swift
func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)
print(result)
```

## :four: [Parameter labels](https://www.hackingwithswift.com/sixty/5/4/parameter-labels)

>:star: Swift lets us *provide two names* for each parameter: one to be used externally when calling the function, and one to be used internally inside the function. This is as simple as writing two names, separated by a space.

```swift
/// our func
func square(number: Int) -> Int {
    return number * number
}

/// use param name, can use the name `number` as reference within the equaction
let result = square(number: 8)

/// adding a second name
/// externally its `to` and `name` internally
func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Taylor")
```

So remember `func functionName(outsideName insidename: <Type>)`.

### :boom: Quiz responses

```swift
func isPassingGrade(for scores: [Int]) -> Bool {
	var total = 0
	for score in scores {
		total += score
	}
	if total >= 500 {
		return true
	} else {
		return false
	}
}
```

:white_check_mark: This is valid

:question: What is with the `for` and `in` before the label for some reason but never explained?

## :five: [Omitting parameter labels](https://www.hackingwithswift.com/sixty/5/5/omitting-parameter-labels)

>You might have noticed that we don’t actually send any parameter names when we call print() – we say `print("Hello")` rather than `print(message: "Hello")`.
>
>You can get this same behavior in your own functions by using an underscore,` _,` for your external parameter name, like this:

```swift
func greet(_ person: String) {
    print("Hello, \(person)!")
}

/// no need to use `(person: "Taylor")` because the declaration has `_`
greet("Taylor")
```

This allows you to **bypass** needing to use the label when you call it up.

### :boom: Quiz response insights

```swift
func bounceOnTrampoline(times: Int) {
	for _ in 1...times {
		print("Boing!")
	}
}
```

:white_check_mark: Valid swift

:question: So this `_` shortcut can actually be used within the function to replace a variable? 

I'm not sur I understand...

:question: If the `_` is before a label does this have something to do with the external/internal run of it?


## :six: [Default parameters](https://www.hackingwithswift.com/sixty/5/6/default-parameters)

>The `print() `function prints something to the screen, but *always adds a new line to the end of whatever you printed*, so that multiple calls to print() don’t all appear on the same line.
>
>**You can change that behavior if you want**, so you could use spaces rather than line breaks. Most of the time, though, folks want new lines, so `print()` has a ***terminator parameter*** that uses new line as its *default value*.
>
>You can give your own parameters a default value just by writing an `= `after its type followed by the default you want to give it.

```swift
/// `nicely` refers to the default terminator param of `print()`
/// the `Bool = true` is modifying the default for skipping a line.
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)
```

:boom: Quiz insights

```swift
func runRace(distance: Int = 10) {
	if distance < 5 {
		print("This should be easy!")
	} else if distance < 10 {
		print("This should be a nice challenge.")
	} else {
		print("Let's do this!")
	}
}
```

:white_check_mark: I like this declaration

## :seven: [Variadic functions](https://www.hackingwithswift.com/sixty/5/7/variadic-functions)

**varadic** : *(adj)* mathematic term to say it accepts any number of params as long as they're the same type
>ex: `print()`, it accepts many aparams
>
>`print("Haters", "gonna", "hate")`
>
>They are all printed on one line with spaces between them

In general however :

>You can *make any parameter variadic* by writing `...` after its type. 
>>So, an Int parameter is a single integer, whereas `Int...` is zero or more integers – potentially hundreds.
>
>Inside the function, Swift *converts the values* that were passed in to an `array` of integers, so you can loop over them as needed.

`...` creates an implicit array then when it's used in the definition of the function parameters, after you declare the type.

```swift
func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5)
```

:boom: Question insights

>Variadic parameters can potentially receive zero values.
>
>The array we're given might be empty.

:white_check_mark: Cool

## :eight: [Writing throwing functions](https://www.hackingwithswift.com/sixty/5/8/writing-throwing-functions)

>Swift lets us throw errors from functions by marking them as `throws` before their return type, then using the `throw` keyword when something goes wrong.

## :boom: Quiz insights

```swift
enum PlayError: Error {
	case cheating
	case noPlayers
}
/// all good, the `->` is not essential for throwing errors
func playGame(name: String, cheat: Bool = false) throws {
	if cheat {
		throw PlayError.cheating
	} else {
		print("Let's play a game of \(name)...")
	}
}
```

:white_check_mark: Valid swift

```swift
enum MeasureError: Error {
	case unknownItem
}
func measure(itemName: String) throws -> Double {
	switch itemName {
	case "bookcase":
		return 2.0
	case "chair":
		return 1.0
	case "child":
		return 1.3
	case "adult":
		return 1.75
	}
}
```
:x: "*Oops – that's not correct. The switch block is not exhaustive.*"

Not sure what this means?

```swift
/// oops, need to have `enum ChargeError: Error` up here
enum ChargeError {
	case noCable
	case noPower
}
func chargePhone(atHome: Bool) throws {
	if atHome {
		print("Phone is charging...")
	} else {
		throw ChargeError.noPower
	}
}
```

:x: Not valid swift

## :nine: [Running throwing functions](https://www.hackingwithswift.com/sixty/5/9/running-throwing-functions)

>Swift doesn’t like errors to happen when your program runs, which means it won’t let you run an error-throwing function by accident.
>
>Instead, you need to call these functions using three new keywords: 
>* `do` starts a section of code that might cause problems, 
>* `try` is used before every function that might throw an error, 
>* and `catch` lets you handle errors gracefully.
>
>If any errors are thrown inside the `do` block, execution immediately jumps to the `catch` block. 

```swift
do {
    try checkPassword("password")
  /// this print code is never reached b/c error is thrown
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
```

### :boom: Questions insight

>Throwing functions must be called using try

## :one::zero: [`inout` parameters](https://www.hackingwithswift.com/sixty/5/10/inout-parameters)

>All parameters passed into a Swift function are constants, so you can’t change them. 

Waaat, okay I never really realized that.

>If you want, you can pass in one or more parameters as `inout`, which means they can be changed inside your function, and those changes reflect in the original value outside the function.

**`inout`** : *(params)* can chagne inside the function and reflect in the original value outside the function.

```swift
import UIKit

/// want to change the value directly, rather than return a new one
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
/// the `&` is an explicit recognition that it's being used as an `inout`
doubleInPlace(number: &myNum)
```

## :arrow_right_hook: [Functions Summary](https://www.hackingwithswift.com/sixty/5/11/functions-summary)

>You’ve made it to the end of the fifth part of this series, so let’s summarize:
>
>1) Functions let us re-use code without repeating ourselves.
>2) Functions can accept parameters – just tell Swift the type of each parameter.
>3) Functions can return values, and again you just specify what type will be sent >back. Use tuples if you want to return several things.
>4) You can use different names for parameters externally and internally, or omit >the external name entirely.
>5) Parameters can have default values, which helps you write less code when >specific values are common.
>6) Variadic functions accept zero or more of a specific parameter, and Swift >converts the input to an array.
>7) Functions can throw errors, but you must call them using try and handle errors >using catch.
>8) You can use inout to change variables inside a function, but it’s usually better >to return a new value.