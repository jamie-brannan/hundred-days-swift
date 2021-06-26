# Day 8 (02), Week 6

:calendar: – Wednesday April 22, 2020

*At home* :house:

Continuing Day 08 of challenge

- [Day 8 (02), Week 6](#day-8-02-week-6)
	- [:three: Proeprty observers](#three-proeprty-observers)
		- [:boom: Quiz insights](#boom-quiz-insights)
	- [:four: Methods](#four-methods)
		- [:boom: Quiz insights](#boom-quiz-insights-1)

## :three: [Proeprty observers](https://www.hackingwithswift.com/sixty/7/3/property-observers)

**property observers** : *(swift)* let you run code before or after any property changes.

```swift
/// create a `struct`
struct Progress {
    var task: String
    var amount: Int
}

/// create an instance
var progress = Progress(task: "Loading data", amount: 0)
/// adjust it over time
progress.amount = 30
progress.amount = 80
progress.amount = 100
```

> **However :** What we want to happen is for Swift to print a message every time amount changes, and we can use a `didSet` **property observer** for that.

```swift
struct Progress {
    var task: String
    var amount: Int {
        /// `property observer` put in place
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}
```

> :heavy_plus_sign: You can also use willSet to take action before a property changes, but that is rarely used.

### :boom: Quiz insights

```swift
struct App {
	var name: String
	var isOnSale: Bool {
		didSet {
			if isOnSale {
				print("Go and download my app!")
			} else {
				print("Maybe download it later.")
			}
		}
	}
}
```

:white_check_mark: Valid swift
It is okay to use prints within a property observers

```swift
struct FootballMatch {
	let homeTeamScore: Int {
		didSet {
			print("Yay - we scored!")
		}
	}
	let awayTeamScore: Int {
		didSet {
			print("Boo - they scored!")
		}
	}
}
```

:x: Not valid
>Oops – that's not correct. You can't attach a property observer to a constant, because it will never change.

```swift
struct House {
	var numberOfOccupants: Int {
		didSet:
			print("\(numberOfOccupants) people live here now.")
	}
}
```
:x: Not valid
>Oops – that's not correct. `didSet:` should be `didSet {`.

## :four: [Methods](https://www.hackingwithswift.com/sixty/7/4/methods)

>Structs can have functions inside them, and those functions can use the properties of the struct as they need to. 

**method** : *(swift)* a funciton inside a `struct`
* but they still use the same func keyword.

>We can demonstrate this with a City struct. This will have a population property that stores how many people are in the city, plus a `collectTaxes()` method that returns the population count multiplied by 1000. 
>
>Because the method belongs to City it can read the current city’s population property.

```swift
struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()
```

### :boom: Quiz insights

```swift
struct Student {
	var name: String
	var sleepy: Bool
	func study {
		if sleepy {
			print("I'm too tired right now.")
		} else {
			print("I'm hitting the books!")
		}
	}
}
```

:x: Oops – that's not correct. The study() method is missing parentheses.

