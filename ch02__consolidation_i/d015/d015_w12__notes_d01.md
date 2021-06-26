# Day 15, Week 12
:calendar: – Friday June 05, 2020

*At home* :house:

- [Day 15, Week 12](#day-15-week-12)
  - [:one:  Properties](#one--properties)
    - [Property observers](#property-observers)
    - [Computed properties](#computed-properties)
  - [:two: Static properties and methods](#two-static-properties-and-methods)
  - [:three:  Access control](#three--access-control)
  - [:four:  Polymorphism and typecasting](#four--polymorphism-and-typecasting)
    - [Converting types with typecasting](#converting-types-with-typecasting)

**Condolidations: Day 3**

## :one:  [Properties](https://www.hackingwithswift.com/read/0/17/properties) 

>Structs and classes (collectively: "types") can have their own variables and constants, and these are called properties. These let you attach values to your types to represent them uniquely, but because types can also have methods you can have them behave according to their own data.
>
>Let's take a look at an example now:

```swift
struct Person {
    var clothes: String
    var shoes: String

    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")
taylor.describe()
other.describe()
```

>As you can see, when you use a property inside a method it will automatically use the value that belongs to the same object.

### Property observers

>Swift lets you add code to be run when a property is about to be changed or has been changed. This is frequently a good way to have a user interface update when a value changes, for example.
>
>There are two kinds of property observer: `willSet` and `didSet`, and they are called before or after a property is changed. In `willSet` Swift provides your code with a special value called `newValue` that contains what the new property value is going to be, and in `didSet` you are given `oldValue` to represent the previous value.
>
>Let's attach two property observers to the `clothes` property of a `Person` struct:

```swift
struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }

        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts")
taylor.clothes = "short skirts"
```

>That will print out the messages "I'm changing from T-shirts to short skirts" and "I just changed from T-shirts to short skirts."

### Computed properties

>It's possible to make properties that are actually code behind the scenes. We already used the `uppercased()` method of strings, for example, but there’s also a property called `capitalized` that gets calculated as needed, rather than every string always storing a capitalized version of itself.
>
>To make a **computed property**, place an open brace after your property then use either get or set to make an action happen at the appropriate time. 
>* For example, if we wanted to add a ageInDogYears property that automatically returned a person's age multiplied by seven, we'd do this:

```swift
struct Person {
    var age: Int

    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
}

var fan = Person(age: 25)
print(fan.ageInDogYears)
```

>Computed properties are increasingly common in Apple's code, but less common in user code.
>
>**Note**: If you intend to use them only for reading data you can just remove the get part entirely, like this:

```swift
var ageInDogYears: Int {
    return age * 7
}
```

## :two: [Static properties and methods](https://www.hackingwithswift.com/read/0/18/static-properties-and-methods) 

>Swift lets you create properties and methods that belong to a type, rather than to instances of a type. This is helpful for *organizing your data meaningfully by **storing shared data***.
>
>Swift calls these *shared properties* "**static properties**", and you create one just by using the `static` keyword. 

:question: But a `static var` is still not a constant right ?

>Once that's done, you access the property by using the full name of the type. Here's a simple example:

```swift
struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"

    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)
```

>So, a Taylor Swift `fan` has a `name` and `age` that belongs to them, but they all have the same favorite song.
>
>Because static methods belong to the `struct` itself *rather than* to instances of that struct, you **can't use it** to access any **non-static properties** from the struct.

## :three:  [Access control](https://www.hackingwithswift.com/read/0/19/access-control) 

>**Access control** lets you specify what data inside structs and classes should be exposed to the outside world, and you get to choose four modifiers:

Classic OOP

>* **Public**: this means everyone can read and write the property.
>* **Internal**: this means only your Swift code can read and write the property. If you ship your code as a framework for others to use, they won’t be able to read the property.
>* **File Private**: this means that only Swift code in the same file as the type can read and write the property.
>* **Private**: this is the most restrictive option, and means the property is available only inside methods that belong to the type, or its extensions.
>
>Most of the time you don't need to specify access control, but sometimes you'll want to explicitly set a property to be private because it stops others from accessing it directly. This is useful because your own methods can work with that property, but others can't, thus forcing them to go through your code to perform certain actions.
>
>To declare a property private, just do this:

```swift
class TaylorFan {
    private var name: String?
}
```

>If you want to use “file private” access control, just write it as one word like so: `fileprivate`.

## :four:  [Polymorphism and typecasting](https://www.hackingwithswift.com/read/0/20/polymorphism-and-typecasting) 

>Because classes can inherit from each other (e.g. `CountrySinger` can inherit from `Singer`) it means one class is effectively a **superset** of another: class B has all the things A has, with a few extras. This in turn means that you can treat B as type B or as type A, depending on your needs.

**superset** : *(math)* a set which includes another set of sets

>Confused? Let's try some code:

```swift
class Album {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        /// use property from parent
        super.init(name: name)
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
}
```

>That defines three classes: 
>1) albums,
>2) studio albums 
>3) and live albums, 
>
>...with the latter two both inheriting from `Album`. 
>
>Because any instance of `LiveAlbum` is inherited from `Album` it can be treated just as either `Album` or `LiveAlbum` – *it's both at the same time*. 
>* This is called "**polymorphism**," but it means you can write code like this:

```swift
var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]
```

>There we create an array that holds only albums, but put inside it two studio albums and a live album. This is perfectly fine in Swift because they are all descended from the Album class, so they share the same basic behavior.
>
>**We can push this a step further to really demonstrate how polymorphism works.** Let's add a `getPerformance()` method to all three classes:

```swift
class Album {
    var name: String

    init(name: String) {
        self.name = name
    }

    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}
```

>The `getPerformance()` method exists in the `Album` class, **but** *both child classes override it*. When we create an array that holds `Albums`, we're actually filling it with subclasses of albums: `LiveAlbum` and `StudioAlbum`. 
>
>They go into the array just fine because they inherit from the `Album` class, **but they never lose their original class**. 

:star: It doesn't matter if something is overwritten in a parent class because it'll still exist and be able to be called upon.

>So, we could write code like this:

```swift
var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}
```

>That will automatically use the override version of getPerformance() depending on the subclass in question. That's polymorphism in action: an object can work as its class and its parent classes, all at the same time.

### Converting types with typecasting

>You will often find you have an object of a certain type, but really you know it's a different type. Sadly, if Swift doesn't know what you know, it won't build your code. So, there's a solution, and it's called typecasting: converting an object of one type to another.
>
>Chances are you're struggling to think why this might be necessary, but I can give you a very simple example: