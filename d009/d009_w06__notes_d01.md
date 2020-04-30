# Day 9, Week 6

:calendar: – Thursday April 23, 2020

*At home* :house:

**Structs, part two** starts now! :rocket:

>As you’ve seen, structs let us combine individual pieces of data to make something new, then attach methods so we can manipulate that data.
>
>Today you’re going to learn about some of the more advanced features of structs that make them more powerful,
>    * including access control, 
>    * static properties, 
>    * and *laziness*. 
>    
>Yes, *laziness* – Bill Gates once said, “I choose a lazy person to do a hard job, Because a lazy person will find an easy way to do it.” 
>
>In Swift, *laziness* is an important performance optimization, as you’ll see.

## :one: [Initializers](https://www.hackingwithswift.com/sixty/7/8/initializers)

**initializer** : *(swift)* special methods (func in a struct) that provide different ways to create your struct. 
* All structs come with one by default, called their **memberwise initializer** 

    – this asks you to provide a value for each property when you create the struct.

```swift
/// create a user struct with one property
struct User {
    var username: String
}

/// when you create one of these structs, you must provide a username
var user = User(username: "twostraws")

/// we can provide our own initializer (replace the default)
struct User {
    var username: String
    /// ex, create all users as anonymous
    /// ATTN : you do NOT write `func` before initializers
    init() {
        /// make sure all properties have a value before it ends
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "twostraws"
```

Cooooooooool

### :boom: Quiz insights

```swift
struct Dictionary {
	var words = Set<String>()
}
let dictionary = Dictionary()
```

:white_check_mark: Valid swift

```swift
struct Country {
	var name: String
	var usesImperialMeasurements: Bool
	init(countryName: String) {
		name = countryName
		let imperialCountries = ["Liberia", "Myanmar", "USA"]
		if imperialCountries.contains(name) {
			usesImperialMeasurements = true
		} else {
			usesImperialMeasurements = false
		}
	}
}
```

:white_check_mark: Valid swift


## :two: [Referring to the current instance](https://www.hackingwithswift.com/sixty/7/9/referring-to-the-current-instance)

>Inside methods you get a special constant called `self`, which *points* to whatever instance of the `struct` is currently being used. This `self` value is particularly *useful* when you create *initializers that have the same parameter names as your property*.
>
>For example, 
>* if you create a `Person` `struct` with a `name` property, 
>* then tried to write an *initializer* that accepted a `name` parameter, 
>* `self` helps you distinguish between the property and the parameter 
>   – self.name refers to the property, whereas name refers to the parameter.

```swift
struct Person {
    /// the property
    var name: String
    /// that the initalizer, and refer to its instance
    init(name: String) {
        print("\(name) was born!")
        /// assign value
        self.name = name
    }
}
```

### :boom: Quiz insights

```swift
struct Language {
	var nameEnglish: String
	var nameLocal: String
	var speakerCount: Int
	init(english: String, local: String, speakerCount: Int) {
		self.nameEnglish = english
		self.nameLocal = local
		self.speakerCount = speakerCount
	}
}
let french = Language(nameEnglish: "French", nameLocal: "français", speakerCount: 220_000_000)
```

:x: not valid
> Oops – that's not correct. The initializer has the parameter names english and local, not nameEnglish and nameLocal.

