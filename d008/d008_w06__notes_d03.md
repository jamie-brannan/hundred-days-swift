# Day 8 (3), Week 6

:calendar: – Thursday April 23, 2020

*At home* :house:


## :five: [Mutating methods](hackingwithswift.com/sixty/7/5/mutating-methods)

>If a `struct` has a variable property but the *instance of the struct was created as a* **constant**, that property can’t be changed – the struct is constant, so all its properties are also constant regardless of how they were created.
>
>The problem is that when you create the struct Swift 
> * has no idea whether you will use it with constants or variables,
>   * so by default it takes **the safe approach**: Swift won’t let you write methods that change properties unless you specifically request it.
>
>When you want to change a property inside a method, you need to mark it using the `mutating` keyword

```swift
struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

/// the person's name is Ed
var person = Person(name: "Ed")
/// the person's name is modified and becomes anonomous
/// `mutating` makes it so that it modifies the variable in the structure
person.makeAnonymous()
```

Therefore we can define...

**mutating method** : *(swift)* a `func` with `mutating` keyword that'll allow variables in a structure a variable property in a `struct`

### :boom: Quiz insights

```swift
struct Diary {
	var entries: String
	mutating func add(entry: String) {
		entries += "\(entry)"
	}
}
```

:white_check_mark: 

```swift
struct Tree {
	var height: Int
	mutating func grow() {
		height *= 1.001
	}
}
```

:x: Not valid
>Oops – that's not correct. This code attempts to multiply an Int by a Double, which is not allowed.

Must have parantheses as well after mtuating function name.

## :six: [Properties and methods of string](https://www.hackingwithswift.com/sixty/7/6/properties-and-methods-of-strings)

>We’ve used lots of strings so far, and it turns out they are `structs` – they have their own methods and properties we can use to query and manipulate the string.

```swift
/// create a `string`
let string = "Do or do not, there is no try."
/// read the number of characters
print(string.count)
/// find out if it starts with specific letters
print(string.hasPrefix("Do"))
/// forced uppercasing
print(string.uppercased())
/// sort into an array, character by character in alpha numeric order
print(string.sorted())
```

:question: is this via ASCII order ? What's the order exactly for `sorted()`?

## :seven: [Properties and methods of arrays](https://www.hackingwithswift.com/sixty/7/7/properties-and-methods-of-arrays)

>`Arrays` are also `structs`, which means they too have their own methods and properties we can use to query and manipulate the array.

```swift
/// create an array
var toys = ["Woody"]
/// count number of `items` in the array
print(toys.count)
/// add a new item to the *end* of array
toys.append("Buzz")
/// locate any item in them with
toys.firstIndex(of: "Buzz")
/// sort alphabetically in an array
print(toys.sorted())
/// remove an item at end of array
toys.remove(at: 0)
```

>Arrays have lots more properties and methods – try typing `toys.` to bring up Xcode’s **code completion options**.

### :boom: Quiz insights

```swift
let movies = ["A New Hope", "Empire Strikes Back", "Return of the Jedi"]
movies.firstIndex(of: "A New Hope") == 4
```

:x: Oops – that's not correct. "A New Hope" exists at index 0.

```swift
var examScores = [100, 95, 92]
examScores.insert(98)
```

:x: Oops – that's not correct. This is invalid Swift, because the insert() method must also be told where to insert the item.


