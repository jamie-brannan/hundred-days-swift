# Day , Week 

:calendar: – Tuesday April 21, 2020

*At home* :house:

**Structs, part one** 

> Structs let us create our own data types out of several small types.
>
> For example, you might put three strings and a boolean together and say that represents a user in your app.
>These custom types – users, games, documents, and more – form the real core of the software we build. If you get those right then often your code will follow.

## :one: [Creating your own structs](https://www.hackingwithswift.com/sixty/7/1/creating-your-own-structs)

>Swift lets you design your own `types` in two ways, of which the most common are called **structures**, or just *structs*. Structs can be given their own variables and constants, and their own functions, then created and used however you want.

```swift
// define the type of sport
struct Sport {
    // one property of the string
    var name: String
}
// create an instance 
var tennis = Sport(name: "Tennis")
print(tennis.name)

// change the variable again
tennis.name = "Lawn tennis"
```

### :boom: Quiz insights

* Must have the var keyword
* must use brackets
* can initate the value and imply the type within the struct

## :two: [Computed properties](https://www.hackingwithswift.com/sixty/7/2/computed-properties)

**Continue to think about the `struct Sport` that was just made...

>That has a name property that stores a String. These are called ***stored* properties**...
>
>because Swift has a different kind of property called a ***computed* property** – a property that runs code to figure out its value.

```swift
struct Sport {
    /// stored property
    var name: String
    var isOlympicSport: Bool

    /// computed property
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

/// so because `false`, it's going to see that it's not an Olympic sport
let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)
```

### :boom: Quiz insights

```swift
struct Code {
	var language: String
	var containsErrors = false
	var report {
		if containsErrors {
			return "This \(language) code has bugs!"
		} else {
			return "This looks good to me."
		}
	}
}
```

:x: not valid
>Oops – that's not correct. **Computed properties must always have an explicit type.**

Also :
* cosntants cannot be computed properties

```swift
struct Dog {
	var breed: String
	var cuteness: Int
	var rating: String {
		if cuteness < 3 {
			print("That's a cute dog!")
		} else if cuteness < 7 {
			print("That's a really cute dog!")
		} else {
			print("That a super cute dog!")
		}
	}
}
let luna = Dog(breed: "Samoyed", cuteness: 11)
print(luna.rating)
```

:x: not valid
>Oops – that's not correct. This computed property prints strings rather than returning them.

