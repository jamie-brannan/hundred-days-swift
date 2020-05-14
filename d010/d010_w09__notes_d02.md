# Day 10 (2), Week 9
:calendar: – Thursday May 14, 2020

*At home* :house:

Contiuing the topic of **Classes**

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

