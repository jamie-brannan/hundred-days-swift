# Day 9(3), Week 7
:calendar: – Thursday April 30, 2020

*At home* :house:

Continuting to learn **Structs**

- [Day 9(3), Week 7](#day-93-week-7)
		- [:three: :boom: Quiz insights](#three-boom-quiz-insights)
	- [:five: Access control](#five-access-control)
		- [Starting point](#starting-point)
		- [Modified](#modified)
		- [:boom: Quiz insights](#boom-quiz-insights)
	- [:arrow_right_hook: Structs Summary](#arrow_right_hook-structs-summary)
		- [:boom: Quiz insights](#boom-quiz-insights-1)
### :three: :boom: Quiz insights

```swift
struct Question {
	static let answer = 42
	var questionText = "Unknown"
	init(questionText: String, answer: String) {
		self.questionText = questionText
		self.answer = answer
	}
}
```

:x: Oops – that's not correct. This code has several problems, not least that `answer` is a constant static integer.

```swift
struct Person {
	static var population = 0
	var name: String
	init(personName: String) {
		name = personName
		population += 1
	}
}
```
:x: Oops – that's not correct. Referencing a static property inside a regular method isn't allowed; this should use `Person.population`.

```swift
struct FootballTeam {
	static let teamSize = 11
	var players: [String]
}
```
:white_check_mark: This is valid swift
* it's okay for the `static let` because there's not attempt to change it

```swift
struct Raffle {
	var ticketsUsed = 0
	var name: String
	var tickets: Int
	init(name: String, tickets: Int) {
		self.name = name
		self.tickets = tickets
		Raffle.ticketsUsed += tickets
	}
}
```
:x: `ticketsUsed` is not declared as a static property.

## :five: [Access control](https://www.hackingwithswift.com/sixty/7/12/access-control)

>**Access control** lets you *restrict* which code can use properties and methods. This is important because you might want to stop people reading a property directly, for example.

**access control** : *(swift)* restrict and allow which code can use properties and methods
> This is a term that applies to physical and cyber security ([Wikipedia, *Access control*](https://en.wikipedia.org/wiki/Access_control))

### Starting point

>We could create a `Person` struct that has an `id` property to store their social security number:

```swift
struct Person {
    var id: String

    init(id: String) {
        self.id = id
    }
}

let ed = Person(id: "12345")
```

>Once that person has been created, we can make their `id` be private so you can’t read it from outside the struct – trying to write `ed.id` simply won’t work.
>
>Just use the `private` keyword, like this:

```swift
struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }
}
```

### Modified

>Now only **methods** *inside* `Person` can read the `id` property. For example:

```swift
struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}
```

We are effectively *scoping* the property to the method, and protecting it from the outside.

This is more or less just the concern of Object Oriented Practices.

>Another common option is `public`, which lets all other code use the property or method.

Exactly, aka, the *opposite* of `private`.


### :boom: Quiz insights

```swift
struct FacebookUser {
	private var privatePosts: [String]
	public var publicPosts: [String]
}
let user = FacebookUser()
```

:x: Oops – that's not correct. This has a **private property**, so Swift is *unable to generate its memberwise initializer for us*.

___

**memberwise initializer** : *(swift)* `struct` types have this is the automatically if it doesn't have a custom initializer. Unlike a "default initializer", `structs` recieve a memberwise initializer even if the stored properties don't have default values.
* ([Swift doc, *Initialization*](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html))

___

 ```swift
 struct Contributor {
	private var name = "Anonymous"
}
let paul = Contributor()
 ```

 :white_check_mark: 

 ```swift
 struct Office {
	private var passCode: String
	var address: String
	var employees: [String]
	init(address: String, employees: [String]) {
		self.address = address
		self.employees = employees
		self.passCode = "SEKRIT"
	}
}
let monmouthStreet = Office(address: "30 Monmouth St", employees: ["Paul Hudson"])
 ```
 
:white_check_mark: 

```swift
struct RebelBase {
	private var location: String
	private var peopleCount: Int
	init(location: String, people: Int) {
		self.location = location
        /// this needs to be `self.peopleCount = people
		self.people = peopleCount
	}
}
let base = RebelBase(location: "Yavin", people: 1000)
```
:x: Oops – that's not correct. This attempts to set a property called people, but no such property exists.
> the param names when you call up the struct need to only be the properties not the names that you give things in the **memberwise init**

```swift
struct School {
	var staffNames: [String]
	private var studentNames: [String]
	init(staff: String...) {
		self.staffNames = staff
		self.studentNames = [String]()
	}
}
let royalHigh = School(staff: "Mrs Hughes")
```

:white_check_mark: This is valid.

```swift
struct Customer {
	var name: String
	private var creditCardNumber: Int
	init(name: String, creditCard: Int) {
		self.name = name
		self.creditCardNumber = creditCard
	}
}
let lottie = Customer(name: "Lottie Knights", creditCard: 1234567890)
```

:white_check_mark: This is valid

```swift
struct Toy {
	var customerPrice: Double
	private var actualPrice: Int
	init(price: Int) {
		actualPrice = price
		customerPrice = actualPrice * 2
	}
}
let buzz = Toy(price: 10)
```

:x: Correct! `actualPrice` is an `Int` and multiplying it by 2 makes another `Int`, but Swift won't let us assign that integer to a `Double`.

## :arrow_right_hook: Structs Summary

>You’ve made it to the end of the seventh part of this series, so let’s summarize:
>
> 1) You can create your own types using structures, which can have their own properties and methods.
> 2) You can use stored properties or use computed properties to calculate values on the fly.
> 3) If you want to change a property inside a method, you must mark it as mutating.
> 4) Initializers are special methods that create structs. You get a memberwise initializer by default, but if you create your own you must give all properties a value.
> 5) Use the `self` constant to refer to the current instance of a struct inside a method.
> 6) The `lazy` keyword tells Swift to create properties only when they are first used.
> 7) You can share properties and methods across all instances of a struct using the static keyword.
> 8) Access control lets you restrict what code can use properties and methods.

### :boom: Quiz insights

* Methods that change properties must be marked mutating
> Swift won't let you change a struct's properties unless you mark the method as mutating.
* Strings and arrays are both structs.
* Computed properties let us run code to return a value.
* You can share properties and methods across all instances of a `struct` using `static`
* Structs can have custom initializers.
> Custom initializers usually replace the default memberwise initialiser.
* Structs can have as many or as few properties as you need.