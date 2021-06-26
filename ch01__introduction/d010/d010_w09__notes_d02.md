# Day 10 (2), Week 9
:calendar: – Thursday May 14, 2020

*At home* :house:

Contiuing the topic of **Classes**

- [Day 10 (2), Week 9](#day-10-2-week-9)
  - [:three:  Overriding methods (Con't)](#three--overriding-methods-cont)
    - [:boom: Quiz insights](#boom-quiz-insights)
  - [:four:  Final classes](#four--final-classes)
    - [:boom: Quiz insights](#boom-quiz-insights-1)
  - [:five:  Copying Objects](#five--copying-objects)
    - [:boom: Quiz insights](#boom-quiz-insights-2)
  - [:six:  Deinitializers](#six--deinitializers)
    - [:boom: Quiz insights](#boom-quiz-insights-3)
  - [:seven:  Mutability](#seven--mutability)
    - [:boom: Quiz insights](#boom-quiz-insights-4)
  - [:arrow_right_hook: Classes summary](#arrow_right_hook-classes-summary)

## :three:  [Overriding methods (Con't)](https://www.hackingwithswift.com/sixty/8/3/overriding-methods) 

>Child classes can replace parent methods with their own implementations – a process known as overriding. Here’s a trivial `Dog` class with a `makeNoise()` method:

```swift
class Dog {
    func makeNoise() {
        print("Woof!")
    }
}
```

>If we create a new Poodle class that inherits from Dog, it will inherit the makeNoise() method. So, this will print “Woof!”:

```swift
class Poodle: Dog {
}

let poppy = Poodle()
poppy.makeNoise()
```

>**Method overriding** allows us to change the implementation of `makeNoise()` for the Poodle class.
>
>Swift requires us to use `override func `rather than just `func` when overriding a method
>* it stops you from overriding a method by accident, and you’ll get an error if you try to override something that doesn’t exist on the parent class:

```swift
class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}
```

>With that change, `poppy.makeNoise()` will print “Yip!” rather than “Woof!”.

Therefore...

```swift
import UIKit

class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

/// Poodle inherits from Dog
class Poodle: Dog {
  /// We will alter however it's noise
    override func makeNoise() {
        print("Yip!")
    }
}

/// defalt
class Jack: Dog {
}

let poppy = Poodle()
let cora = Jack()

poppy.makeNoise()
cora.makeNoise()
```

### :boom: Quiz insights

```swift
class Airplane: Jet {
	func takeOff() {
		print("Fasten your seatbelts.")
	}
}
class Jet: Airplane {
	override func takeOff() {
		print("Someone call Kenny Loggins, because we're going into the danger zone!")
	}
}
let f14 = Jet()
f14.takeOff()
```
:x: Oops – that's not correct. This attempts to make one class inherit from another, and the other class inherit from the first, which is not valid Swift.


## :four:  [Final classes](https://www.hackingwithswift.com/sixty/8/4/final-classes)

>Although class inheritance is very useful – and in fact large parts of Apple’s platforms require you to use it – sometimes you want to disallow other developers from building their own class based on yours.
>
>Swift gives us a `final` keyword just for this purpose: *when you declare a class as being final, **no other class can inherit from it**.*
>
>This means *they can’t override your methods* in order to change your behavior – they need to use your class the way it was written.
>
>To make a class final just put the `final` keyword before it, like this:

```swift
final class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```

### :boom: Quiz insights

```swift
class Movie { }
final struct Comedy: Movie { }
```

:x: Oops – that's not correct. Inheritance is not possible with structs, only classes.

## :five:  [Copying Objects](https://www.hackingwithswift.com/sixty/8/5/copying-objects) 

>The third difference between classes and structs is how they are copied. When you copy a struct, both the original and the copy are different things – changing one won’t change the other. When you copy a class, both the original and the copy point to the same thing, so changing one does change the other.
>
>For example, here’s a simple `Singer` class that has a `name` property with a default value:

```swift
class Singer {
    /// default value is Taylor Swift
    var name = "Taylor Swift"
}
```

>If we create an instance of that class and prints its name, we’ll get “Taylor Swift”:

```swift
var singer = Singer()
print(singer.name)
```

>Now let’s *create a second variable* from the first one and *change its name*:

```swift
var singerCopy = singer
singerCopy.name = "Justin Bieber"
```

>Because of the way classes work, both `singer` and `singerCopy` **point to the same object** in memory, so when we print the singer name again we’ll see “Justin Bieber”:

We're talking about pointers, pointing to the same place in the memory of the computer right?

:question: Is there a particular symbol like `&` that's used to reference a pointer like we saw in Golang ?

```swift
print(singer.name)
```

>On the other hand, if `Singer` were a struct then we would get “Taylor Swift” printed a second time:

```swift
struct Singer {
    var name = "Taylor Swift"
}
```

So struct instances do not point back, but classes do ? :arrow_right: Yup

```swift
import UIKit

class Singer {
    /// default value is Taylor Swift
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

/// change copy
var singerCopy = singer
singerCopy.name = "Justin Bieber"

/// prints as Jbeebs
print(singer.name)

/// DO THE SAME BUT WITH `struct`

struct SingerStruct {
  var name = "TSwift"
}

var singerStruct = SingerStruct()
print(singerStruct.name)

var singerStructCopy = singerStruct
singerStructCopy.name = "Jbeebs"

/// reprint the original
print(singerStruct.name)
print(singerStructCopy.name)

```

### :boom: Quiz insights

```swift
class Statue {
	var sculptor = "Unknown"
}
var venusDeMilo = Statue()
venusDeMilo.sculptor = "Alexandros of Antioch"
var david = Statue()
david.sculptor = "Michaelangelo"
print(venusDeMilo.sculptor)
print(david.sculptor)
```
:white_check_mark: This creates two seperate instances. This creates two different statues, so it prints two different sculptors.


## :six:  [Deinitializers](https://www.hackingwithswift.com/sixty/8/6/deinitializers) 

>The fourth difference between classes and structs is that classes can have **deinitializers** – *code that gets run when an instance of a class is destroyed.*

Or is it something that's to shut down something that's been initiated? Like an off switch, to destroy what was used and useful, but now goes in the "garbage" so to speak?

:question: Is this what the famous "garbage collectors" that we talked about in Go?

>To demonstrate this, here’s a `Person` class with a `name` property, a simple initializer, and a `printGreeting()` method that prints a message:

```swift
class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}
```

>We’re going to create a few instances of the `Person` class inside a loop, because each time the loop goes around a new person will be created then destroyed:

```swift
for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}
```

>And now for the deinitializer. This will be called when the `Person` instance is being destroyed:

:warning: This must be placed within the class, just like the `init {}`

```swift
deinit {
    print("\(name) is no more!")
}
```

### :boom: Quiz insights

```swift
struct Olympics {
	func deinit() {
		print("And now for the closing ceremony.")
	}
}
```

:x: You don't use `func` or write parentheses after `deinit`.

Also, `structs` may not have `deinit`

## :seven:  [Mutability](https://www.hackingwithswift.com/sixty/8/7/mutability) 

>The final **difference between** classes and structs is *the way they deal with constants.* 
>
>If you have a **constant struct with a variable property**, that property *can’t* be changed because *the `struct` itself is constant*.
>
>However, if you have **a constant class with a variable property**, that property *can* be changed. 
>* Because of this, classes don’t need the `mutating` keyword with methods that change properties; that’s only needed with `structs`.
>
>This difference means you can change any variable property on a class *even when the class is created as a constant* – this is perfectly valid code:

```swift
class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
```

>*If you want to stop that* from happening you need to make the property constant:

```swift
class Singer {
    let name = "Taylor Swift"
}
```

### :boom: Quiz insights

```swift
class Pizza {
	private var toppings = [String]()
	func add(topping: String) {
		toppings.append(topping)
	}
}
var pizza = Pizza()
pizza.add(topping: "Mushrooms")
```

:white_check_mark: Valid swift

```swift
class SewingMachine {
	var itemsMade = 0
	mutating func makeBag(count: Int) {
		itemsMade += count
	}
}
var machine = SewingMachine()
machine.makeBag(count: 1)
```
:x: Cannot use `mutating` keyword with clases, only with `struct`

```swift
struct Piano {
	var untunedKeys = 3
    /// need to add the keyword `mutating` here
	func tune() {
		if untunedKeys > 0 {
			untunedKeys -= 1
		}
	}
}
var piano = Piano()
piano.tune()
```
:x: Oops – that's not correct. The tune() method attempts to modify the untunedKeys property, but it isn't marked as mutating.


```swift
struct Kindergarten {
	var numberOfScreamingKids = 30
	mutating func handOutIceCream() {
		numberOfScreamingKids = 0
	}
}
/// the instance is called as a constant, therefore cannot use `mutating func`
let kindergarten = Kindergarten()
kindergarten.handOutIceCream()
```
:x: Oops – that's not correct. This attempts to call a mutating method on a constant struct instance.

```swift
class Light {
    /// this property would have to have been declared as a constant in order to be constant at all times in instances of all types
	var onState = false
	func toggle() {
		if onState {
			onState = false
		} else {
			onState = true
		}
		print("Click")
	}
}
/// even if instance is a constant, classes can be modified
let light = Light()
light.toggle()
```

:white_check_mark: Correct! This code is valid Swift.


## :arrow_right_hook: [Classes summary](https://www.hackingwithswift.com/sixty/8/8/classes-summary)

>You’ve made it to the end of the eighth part of this series, so let’s summarize:
>
>1) Classes and structs are similar, in that they can both let you create your own types with properties and methods.
>2) One class can inherit from another, and it gains all the properties and methods of the parent class. It’s common to talk about class hierarchies – one class based on another, which itself is based on another.
>3) You can mark a class with the `final` keyword, which stops other classes from inheriting from it.
>4) Method overriding lets a child class replace a method in its parent class with a new implementation.
>5) When two variables point at the same class instance, they both point at the same piece of memory – changing one changes the other.
>6) Classes can have a deinitializer, which is code that gets run when an instance of the class is destroyed.
>7) Classes don’t enforce constants as strongly as structs – if a property is declared as a variable, it can be changed regardless of how the class instance was created.