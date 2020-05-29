# Day 10, Week 7
:calendar: – Thursday April 30, 2020

Today's topic **Classes**

>At first, classes seem very similar to `structs` because we use them to create new data types with **properties** and **methods**. However, they introduce a new, important, and *complex* feature called **inheritance** – the ability to make one `class` build on the foundations of another.
>
>This is a powerful feature, there’s no doubt about it, and there is no way to avoid using classes when you start building real iOS apps. 

## :one: [Creating your own classes](https://www.hackingwithswift.com/sixty/8/1/creating-your-own-classes)

>Classes are similar to structs in that *they allow you to create new types with properties and methods*, but they have five important differences and I’m going to walk you through each of those differences one at a time.
>
>The first difference between classes and structs is :
>1) that classes never come with a memberwise initializer. This means if you have properties in your class, *you must always create your own initializer*.

```swift
class Dog {
    var name: String
    var breed: String
    /// mandatory initializer, if there's properties in the class
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```
>Creating instances of that class looks just the same as if it were a `struct`:

```swift
let poppy = Dog(name: "Poppy", breed: "Poodle")
```

### :boom: Quiz insights

```swift
class Painting {
	var title: String
	var artist: String
	var paintType: String
	func init(title: String, artist: String, paintType: String) {
		self.title = title
		self.artist = artist
		self.paintType = paintType
	}
}
```
:x: `init()` must not have the `func` keyword before it.

```swift
class Image {
	var filename: String
	var isAnimated: Bool
	init(filename: String, isAnimated: Bool) {
		filename = filename
		isAnimated = isAnimated
	}
}
```
:x: Because the parameters and properties have the same names, Swift requires that we use self. to distinguish the properties.

```swift
class ThemePark {
	var entryPrice: Int
	var rides: [String]
	init(rides: [String]) {
		self.rides = rides
		self.entryPrice = rides.count * 2
	}
}
```
:white_check_mark: This is valid

```swift
class Empty { }
let nothing = Empty()
```

:white_check_mark: This is valid, it's just empty

## :two:  [Class inheritance](https://www.hackingwithswift.com/sixty/8/2/class-inheritance)

>The second difference between classes and structs is that you can create a class based on an existing class – it inherits all the properties and methods of the original class, and can add its own on top.
>
>This is called class inheritance or subclassing, the class you inherit from is called the “parent” or “super” class, and the new class is called the “child” class.
>
>Here’s the `Dog` class we just created:

```swift
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```

>We could create a new class based on that one called Poodle. It will inherit the same properties and initializer as `Dog` by default:

```swift
class Poodle: Dog {

}
```

>However, we can also give `Poodle` its own initializer. 
>
>We know it will always have the breed “Poodle”, so we can make a new initializer that only needs a `name` property. Even better, we can make the Poodle initializer call the `Dog` initializer directly so that all the same setup happens:

```swift
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}
```

>For safety reasons, Swift always makes you call `super.init()` from *child classes* – just in case the *parent class *does some important work when it’s created.

### :boom: Quiz insights

```swift
class Vehicle {
	var wheels: Int
	init(wheels: Int) {
		self.wheels = wheels
	}
}
class Truck: Vehicle {
	var goodsCapacity: Int
	init(wheels: Int, goodsCapacity: Int) {
		self.goodsCapacity = goodsCapacity
		super.init()
	}
}
```
:x: Oops – that's not correct. The `Truck` class must call the `Vehicle` initializer at some point.

```swift
class Handbag {
	var price: Int
	init(price: Int) {
		self.price = price
	}
}
class DesignerHandbag: Handbag {
	var brand: String
	init(brand: String, price: Int) {
		self.brand = brand
		super.init(price: price)
	}
}
```
:white_check_mark: Correct! This shows the class `DesignerHandbag` inheriting from `Handbag`.

```swift
class Bicycle {
	var color: String
	init(color: String) {
		self.color = color
	}
}
class MountainBike: Bicycle {
	var tireThickness: Double
	init(color: String, tireThickness: Double) {
		self.tireThickness = tireThickness
		super.init(color: color)
	}
}
```

* class cannot inhereit from itself

```swift
class Bicycle {
	var color: String
	init(color: String) {
		self.color = color
	}
}
class MountainBike: Bicycle {
	var tireThickness: Double
	init(color: String, tireThickness: Double) {
		self.tireThickness = tireThickness
		super.init(color: color)
	}
}
```
:white_check_mark: This shows the class `LaserPrinter` inheriting from `Printer`.

## :three:  [Overriding methods](https://www.hackingwithswift.com/sixty/8/3/overriding-methods) 

>Child classes can replace parent methods with their own implementations – a process known as overriding. Here’s a trivial Dog class with a makeNoise() method:

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

>Method overriding allows us to change the implementation of makeNoise() for the Poodle class.
>
>Swift requires us to use override func rather than just func when overriding a method – it stops you from overriding a method by accident, and you’ll get an error if you try to override something that doesn’t exist on the parent class:

```swift
class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}
```

With that change, `poppy.makeNoise()` will print “Yip!” rather than “Woof!”.

