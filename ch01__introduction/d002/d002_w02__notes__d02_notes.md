# Day 2, Week 2
:calendar: – Tuesday March 31, 2020

Today's theme is **Complex data types**.

- [Day 2, Week 2](#day-2-week-2)
  - [:one: Arrays](#one-arrays)
    - [:boom: Quiz corrected answers](#boom-quiz-corrected-answers)
  - [:two: Sets](#two-sets)
    - [:boom: Quiz corrected answers](#boom-quiz-corrected-answers-1)
  - [:three: Tuples](#three-tuples)
  - [:four: Arrays vs sets vs tuples](#four-arrays-vs-sets-vs-tuples)
  - [:five: Dictonaries](#five-dictonaries)
    - [:boom: Quiz corrected answers](#boom-quiz-corrected-answers-2)
  - [:six: Dictionary default values](#six-dictionary-default-values)
    - [:boom: Quiz corrected answers](#boom-quiz-corrected-answers-3)
  - [:seven: Creating empty collections](#seven-creating-empty-collections)
  - [:eight: Enumerations](#eight-enumerations)
  - [:nine: Enum associated values](#nine-enum-associated-values)
  - [:one::zero: Enum raw values](#onezero-enum-raw-values)
  - [:arrow_right_hook: Complex types summary](#arrow_right_hook-complex-types-summary)
## :one: [Arrays](https://www.hackingwithswift.com/sixty/2/1/arrays)

>**Arrays** are collections of values that are stored as a single value.

```swift
/// Constants that will be added to an `array`
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

/// Constant `array`
let beatles = [john, paul, george, ringo]
// calling an item based on index
print(beatles[1])

// concatinating items based on index with string
print(beatles[1] + ", " + beatles[2])

/// try adding a beatle – but cannot because `beatles` is defined with `let` and is therefore constant
// let beatles[4] = "test this"
print(beatles)

```

Xcode will crash if there's a call to a part of the array that doesn't exist

### :boom: Quiz corrected answers

```swift
// Doesn't work becauset these are different types
let character: [Int] = ["Doctor Who"]
```

## :two: [Sets](https://www.hackingwithswift.com/sixty/2/2/sets)

>Sets are collections of values just like arrays, except they have **two differences**:
>
>1) Items aren’t stored in any order; they are stored in what is effectively a random order.
>2) No item can appear twice in a set; all items must be unique.

```swift
/// unordered `Set` created directly from array
let colors = Set(["red", "green", "blue"])
```

Sets are **unordered**, not necessarily *random* but not assigned an index.

Duplicate information will automatically be deleted

:question: *How exactly does Swift know if theres a duplicate then? Is there a comparison process happening each time the `set` is being called up? Does this make is slower*

### :boom: Quiz corrected answers

>This will create a set with two items – true or false?
```swift
/// Doesn't work because this is not encapsulating an `array`
let earthquakeStrengths = Set(1, 1, 2, 2)
```
> `Set([1, 1, 2, 2])` would have been correct.

## :three: [Tuples](https://www.hackingwithswift.com/sixty/2/3/tuples) 

>Tuples allow you to store several values together in a single value. That might sound like arrays, but tuples are different:
>
> 1) You can’t add or remove items from a tuple; they are **fixed in size**.
> 2) You **can’t change the type of items** in a tuple; they always have the same types they were created with.
> 3) You can access items in a tuple using **numerical positions *or* by naming them**, but Swift won’t let you read numbers or names that don’t exist.

```swift
import UIKit

/// declaration
var name = (first: "Taylor", last: "Swift")

/// call via `index`
name.0
/// call via `name`
name.first

print("Let me test if I can callup " + name.0)

/// can I have more than one?
var cats = (last: "Graham", small: "Watson", bigone: "Butters")
print("I have two cats : \(cats.small) \(cats.last) and \(cats.bigone) \(cats.last)")
print(cats)
```

So basically this is like a fabled `typed json`? Duplicates possible so...? Possible to hold multiline too.

:question: *What is the difference between `json` and tuples*
* fixed in size ?

## :four: [Arrays vs sets vs tuples](https://www.hackingwithswift.com/sixty/2/4/arrays-vs-sets-vs-tuples)

What should I use to store information in what context?

>If you need a specific, fixed collection of related values where each item has a precise position or name, you should use a **tuple**

```swift
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")
```

>If you need a collection of *values that must be unique* or you need to be able to check whether a specific item is in there *extremely quickly*, you should use a **set**

```swift
let set = Set(["aardvark", "astronaut", "azalea"])
```

:question: What would be some real life cases where we'd need to check uniqueness "extremely quickly"?

>If you need a collection of values that *can contain duplicates*, or the *order of your items matters*, you should use an **array**

```swift
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
```

| tuples  | sets  | array  |
|---|---|---|
| fixed, related, precise name or position | unique values, rapidly checkable | ordered and duplicates okay |

## :five: [Dictonaries](https://www.hackingwithswift.com/sixty/2/5/dictionaries)

>Dictionaries are collections of values just like arrays, but rather than storing things with an integer position you can access them using anything you want.
>
>The most common way of storing dictionary data is using strings. For example, we could create a dictionary that stores the height of singers using their name

```swift
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
```

Has a similar format to arrays because :
* brackets `[]`
* comma seperator `,`

But, there a `:` seperator between the identifier and the value. **Identifiers are called `keys`**, and call up the data out of the dictonary like indexes do in arrays.

```swift
heights["Taylor Swift"]
```

>Note: When using type annotations, dictionaries are written in brackets with a colon between your identifier and value types. For example, `[String: Double]` and `[String: String]`.

### :boom: Quiz corrected answers

* attn to the brackets and parentheses

## :six: [Dictionary default values](https://www.hackingwithswift.com/sixty/2/6/dictionary-default-values) 

>If you try to read a value from a dictionary using a key that doesn’t exist, Swift will send you back nil – nothing at all. While this might be what you want, there’s an alternative: we can provide the dictionary with a default value to use if we request a missing key.

```swift
import UIKit

/// Dictionary used
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

/// calling an existing values
favoriteIceCream["Paul"]
/// calling a non existing will result in `nil`
favoriteIceCream["Charlotte"]
/// adding a default value if it's `nil`
favoriteIceCream["Charlotte", default: "Unknown"]
```

:question: *Isn't there a better way to predefine the default value? We did in class once...*

### :boom: Quiz corrected answers

>:x: Oops – that's not correct. This attempts to use an array like a dictionary, which is invalid.

```swift
let ships = ["Star Trek", "Enterprise"]
let enterprise = ships["Star Trek"]
```

This doesn't have a key and it should, if I've understood correctly

## :seven: [Creating empty collections](https://www.hackingwithswift.com/sixty/2/7/creating-empty-collections)

>Arrays, sets, and dictionaries are called **collections**, because they collect values together in one place.

```swift
import UIKit


/// empty `typed dictionary`
var teams = [String: String]()
var teams2 = Dictionary<String, Int>()
teams["Paul"] = "Red"
print(teams)

/// empty `typed array`
var results = [Int]()
var results2 = Array<Int>()


/// empty `typed set`
var words = Set<String>()
var numbers = Set<Int>()

```

:rocket: This will end up being useful for keeping things type-safe and working with data bases right?

## :eight: [Enumerations](https://www.hackingwithswift.com/sixty/2/8/enumerations)

>Enumerations – usually called just *enums* – are a way of defining groups of related values in a way that makes them easier to use.

But use for *what* and *how*?

```swift
import UIKit

/// a bad example of result handling would be...
let result = "failure"
let result2 = "failed"
let result3 = "fail"
/// b/c they `var` name loses meaning

/// with `enum` it's different
enum Result {
    case success
    case failure
}

/// this could prevent you from reusing wrong strings a different time
let result4 = Result.failure
```

:heart: Omg yes, this happens all the time, so cool!

:question: What's the 

Good for when :
* there's a fixed number of responses

## :nine: [Enum associated values](https://www.hackingwithswift.com/sixty/2/9/enum-associated-values)

>As well as storing a simple value, enums can also store associated values attached to each case. This lets you attach additional information to your enums so they can represent more nuanced data.

```swift
import UIKit

/// associating values to enums
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

/// what calling it up can be
let talking = Activity.talking(topic: "football")
```

:question: What's the difference between an `associated value` and a `variable` or `constant`?

## :one::zero: [Enum raw values](https://www.hackingwithswift.com/sixty/2/10/enum-raw-values)

**Raw values** and **associated values** are different. They're optional.

```swift
import UIKit

/// plain declaration
//enum Planet: Int {
//    case mercury
//    case venus
//    case earth
//    case mars
//}
/// attribute the identifier of `rawValue` and the `value` of `earth`
//let earth = Planet(rawValue: 2)
/// how that is derived in `mars`
//print(Planet.mars.rawValue)

/// can declare a rawValue without idenifier
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
/// how that is derived in mars is without a identifier
print(Planet.mars)
```

There's an automatic indexing of the number of the raw value (an `int` by default, but can be a string if you declare it that way)

`enums` can be created by a raw values.

## :arrow_right_hook: [Complex types summary](https://www.hackingwithswift.com/sixty/2/11/complex-types-summary)

>You’ve made it to the end of the second part of this series, so let’s summarize:
>
>1) Arrays, sets, tuples, and dictionaries let you store a group of items under a single value. They each do this in different ways, so which you use depends on the behavior you want.
>
>2) Arrays store items in the order you add them, and you access them using numerical positions.
>
>3) Sets store items without any order, so you can’t access them using numerical positions.
>
>4) Tuples are fixed in size, and you can attach names to each of their items. You can read items using numerical positions or using your names.
>
>5) Dictionaries store items according to a key, and you can read items using those keys.
>
>6) Enums are a way of grouping related values so you can use them without spelling mistakes.
>
>7) You can attach raw values to enums so they can be created from integers or strings, or you can add associated values to store additional information about each case.