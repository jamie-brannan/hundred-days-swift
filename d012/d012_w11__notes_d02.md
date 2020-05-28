# Day 12(2), Week 11
:calendar: – Wednesday May 27, 2020

*At home* :house:

Continuing **Optionals**

## :three:  [Unwrapping with guard](https://www.hackingwithswift.com/sixty/10/3/unwrapping-with-guard) 

>An *alternative* to `if let `is `guard let`, which also unwraps optionals. 
>
>* `guard let` will unwrap an optional for you, but if it finds `nil` inside it expects you to exit the function, loop, or condition you used it in.
>
>:star: However, **the major difference** between `if let` and `guard let` is that *your unwrapped optional remains usable after the guard code*.
>
>Let’s try it out with a `greet()` function. 
>
>This will accept an *optional string* as its only parameter and try to unwrap it, but if there’s nothing inside it will print a message and exit.
>
>Because optionals unwrapped using `guard let `stay around after the `guard` finishes, we can print the unwrapped string at the end of the function:

```swift
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}
```

>Using `guard let` lets you deal with problems at the start of your functions, then exit immediately. This means the rest of your function is the happy path – the path your code takes if everything is correct.

### Code all together
```swift
import UIKit

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}

/// must write `nil`, cannot just put `empty`
greet(nil)
greet("Tommy")

```

### :boom: Quiz insights

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

>The nil coalescing operator unwraps an optional and returns the value inside if there is one. If there isn’t a value – if the optional was `nil` – then a default value is used instead. Either way, the result won’t be optional: it will either by the value from inside the optional or the default value used as a back up.
>
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