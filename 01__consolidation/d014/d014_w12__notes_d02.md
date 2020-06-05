# Day 14(2), Week 12
:calendar: – Friday June 05, 2020

*At home* :house:

**Consolidation : Day 2, part 2 ;)**

## :four:  [Enumerations](https://www.hackingwithswift.com/read/0/14/enumerations) 

>**Enumerations** – usually just called "enum" and pronounced "ee-num" - are a way for you to* define your own kind of value* in Swift.

Like a type right

>In some programming languages they are simple little things, but Swift adds a huge amount of power to them if you want to go beyond the basics.
>
>Let's start with a simple example from earlier:

```swift
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}
```

>That function accepts a string that defines the current weather. 
>* The problem is, a string is a poor choice for that kind of data – is it "rain", "rainy" or "raining"? Or perhaps "showering", "drizzly" or "stormy"? 
>* Worse, what if one person writes "Rain" with an uppercase R and someone else writes "Ran" because they weren't looking at what they typed?
>
>Enums solve this problem by **letting you define a new data type**, then define the possible values it can hold. 
>
>For example, we might say there are five kinds of weather: sun, cloud, rain, wind and snow. 
>* If we make this an enum, it means Swift will accept only those five values – anything else will trigger an error. 
>And behind the scenes enums are usually just simple numbers, which are a lot faster than strings for computers to work with.
>
>Let's put that into code:

```swift
enum WeatherType {
    case sun, cloud, rain, wind, snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    if weather == WeatherType.sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus(weather: WeatherType.cloud)
```

>Take a look at the first three lines: line 1 gives our type a name, `WeatherType`. This is what you'll use in place of `String` or `Int` in your code. 
>* Line 2 defines the five possible cases our enum can be, as I already outlined. 
>Convention has these start with a lowercase letter, so “sun”, “cloud”, etc. And line 3 is just a closing brace, ending the enum.
>
>Now take a look at how it's used: I modified the getHaterStatus() so that it takes a WeatherType value. The conditional statement is also rewritten to compare against WeatherType.sun, which is our value. Remember, this check is just a number behind the scenes, which is lightning fast.
>
>Now, go back and read that code again, because I'm about to rewrite it with two changes that are important. All set?

```swift
enum WeatherType {
    case sun
    case cloud
    case rain
    case wind
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    if weather == .sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus(weather: .cloud)
```

>I made two differences there. First, each of the weather types are now on their own line. This might seem like a small change, and indeed in this example it is, but it becomes important soon. The second change was that I wrote `if weather == .sun` – I didn't need to spell out that I meant `WeatherType.sun` because Swift knows I am comparing against a WeatherType variable, so it's using type inference.
>
>Enums are particularly useful inside `switch/case` blocks, particularly because Swift knows all the values your enum can have so it can ensure you cover them all. For example, we might try to rewrite the `getHaterStatus()` method to this:

```swift
func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .cloud, .wind:
        return "dislike"
    case .rain:
        return "hate"
    }
}
```

Yes, I realize "haters gonna dislike" is hardly a great lyric, but it's academic anyway because this code won't build: it doesn't handle the `.snow` case, and Swift wants all cases to be covered. You either have to add a case for it or add a default case.

#### Enums with additional values

One of the most powerful features of Swift is that enumerations can have values attached to them that you define. To extend our increasingly dubious example a bit further, I'm going to add a value to the `.wind` case so that we can say how fast the wind is. Modify your code to this:

```swift
enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}
```

>As you can see, the other cases don't need a speed value – I put that just into `wind`. Now for the real magic: Swift lets us add extra conditions to the `switch/case` block so that a case will match only if those conditions are true. This uses the `let` keyword to access the value inside a case, then the `where` keyword for pattern matching.
>
>Here's the new function:

```swift
func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: WeatherType.wind(speed: 5))
```

>You can see `.wind` appears in there twice, but the first time is true only if the wind is slower than 10 kilometers per hour. If the wind is 10 or above, that won't match. The key is that you use `let` to get hold of the value inside the enum (i.e. to declare a constant name you can reference) then use a `where` condition to check.
>
>Swift evaluates `switch/case` from top to bottom, and stops as soon as it finds a match. This means that if `case .cloud, .wind`: appears before `case .wind(let speed) where speed < 10`: then it will be executed instead – and the output changes.
>
>So, think carefully about how you order cases!
>
>**Tip**: Swift’s optionals are actually implemented using enums with associated values. There are two cases: none, and `some`, with `some` having whatever value is inside the optional.

## :five:  [Structs](https://www.hackingwithswift.com/read/0/15/structs) 

>Structs are complex data types, meaning that they are made up of multiple values. You then create an instance of the struct and fill in its values, then you can pass it around as a single value in your code. For example, we could define a `Person` struct type that contains two properties: `clothes` and `shoes`:

```swift
struct Person {
    var clothes: String
    var shoes: String
}
```

>When you define a struct, Swift makes them very easy to create because it automatically generates what's called a memberwise initializer. In plain speak, it means you create the struct by passing in initial values for its two properties, like this:

```swift
let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")
```

>Once you have created an instance of a struct, you can read its properties just by writing the name of the struct, a period, then the property you want to read:

```swift
print(taylor.clothes)
print(other.shoes)
```

>If you assign one struct to another, Swift copies it behind the scenes so that it is a complete, standalone duplicate of the original. Well, that's not strictly true: Swift uses a technique called "copy on write" which means it only actually copies your data if you try to change it.
>
>To help you see how struct copies work, put this into your playground:

```swift
struct Person {
    var clothes: String
    var shoes: String
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

var taylorCopy = taylor
taylorCopy.shoes = "flip flops"

print(taylor)
print(taylorCopy)
```

>That creates two `Person` structs, then creates a third one called `taylorCopy` as a copy of `taylor`. What happens next is the interesting part: the code changes `taylorCopy`, and prints both it and `taylor`. 
>
>If you look in your results pane (you might need to resize it to fit) you'll see that the copy has a different value to the original: changing one did not change the other.

#### Functions inside structs

>You can place functions inside structs, and in fact it’s a good idea to do so for all functions that read or change data inside the struct. For example, we could add a function to our `Person` struct to describe what they are wearing, like this:

```swift
struct Person {
    var clothes: String
    var shoes: String

    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}
```

>There’s one more thing you ought to know but can't see in that code: when you write a function inside a struct, it's called a method instead. In Swift you write `func` whether it's a function or a method, but the distinction is preserved when you talk about them.

## :six:  [Classes](https://www.hackingwithswift.com/read/0/16/classes) 

>Swift has another way of building complex data types called classes. They look similar to structs, but have a number of important differences, including:
>
>* You don't get an automatic memberwise initializer for your classes; you need to write your own.
>* You can define a class as being based off another class, adding any new things you want.
>* When you create an instance of a class it’s called an object. If you copy that object, both copies point at the same data by default – change one, and the copy changes too.
>
>All three of those are massive differences, so I'm going to cover them in more depth before continuing.

### Initializing an object

>If we were to convert our `Person` *struct* into a `Person` ***class***, Swift wouldn't let us write this:

```swift
class Person {
    var clothes: String
    var shoes: String
}
```

>This is because we're declaring the two properties to be `String`, which if you remember means they absolutely must have a value. This was fine in a struct because Swift automatically produces a memberwise initializer for us that forced us to provide values for the two properties, but this doesn't happen with classes so Swift can't be sure they will be given values.
>
>There are three solutions: make the two values optional strings, give them default values, or write our own initializer. The first option is clumsy because it introduces optionals all over our code where they don't need to be. The second option works, but it's a bit wasteful unless those default values will actually be used. That leaves the third option, and really it's the right one: write our own initializer.
>
>To do this, create a method inside the class called `init()` that takes the two parameters we care about:

```swift
class Person {
    var clothes: String
    var shoes: String

    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
}
```

>There are two things that might jump out at you in that code.
>
>First, you don't write `func` before your `init()` method, because it's special. Second, because the parameter names being passed in are the same as the names of the properties we want to assign, you use `self`. to make your meaning clear – "the `clothes` property of this object should be set to the `clothes` parameter that was passed in." You can give them unique names if you want – it's down to you.
>
>**Important**: Swift requires that all non-optional properties have a value by the end of the initializer, or by the time the initializer calls any other method – whichever comes first.

### Class Inhereitance

>The second difference between classes and structs are that classes can build on each other to produce greater things, known as class inheritance. This is a technique used extensively in Cocoa Touch, even in the most basic programs, so it's something you should get to grips with.
>
>Let's start with something simple: a `Singer` class that has properties, which is their name and age. As for methods, there will be a simple initializer to handle setting the properties, plus a `sing()` method that outputs some words:

```swift
class Singer {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func sing() {
        print("La la la la")
    }
}
```

>We can now create an instance of that object by calling that initializer, then read out its properties and call its method:

```swift
var taylor = Singer(name: "Taylor", age: 25)
taylor.name
taylor.age
taylor.sing()
```

>That's our basic class, but we're going to build on it: I want to define a `CountrySinger` class that has everything the `Singer` class does, but when I call `sing()` on it I want to print "Trucks, guitars, and liquor" instead.
>
>You could of course just copy and paste the original `Singer` into a new class called `CountrySinger` but that's a lazy way to program and it will come back to haunt you if you make later changes to `Singer` and forget to copy them across. Instead, Swift has a smarter solution: we can define `CountrySinger` as being based off `Singer` and it will get all its properties and methods for us to build on:

```swift
class CountrySinger: Singer {

}
```

>That colon is what does the magic: it means "`CountrySinger` extends `Singer`." 
>* Now, that new CountrySinger class (called a *subclass*) doesn't add anything to Singer (called the parent class, or superclass) yet. 
>
>We want it to have its own `sing()` method, but in Swift you need to learn **a new keyword**: *override*. 
>* This means "I know this method was implemented by my parent class, but I want to change it for this subclass."

**override** : *(swift)* keyword that means to change something implemented in the parent class for this subclass 

>Having the override keyword is helpful, because it makes your intent clear. 
>
>It also allows Swift to check your code: if you don't use `override` Swift won't let you change a method you got from your **superclass**, or if you use `override` and there wasn't anything to `override`, Swift will point out your error.
>
>So, we need to use `override func`, like this:

```swift
class CountrySinger: Singer {
    override func sing() {
        print("Trucks, guitars, and liquor")
    }
}
```

>Now modify the way the `taylor` object is created:

```swift
var taylor = CountrySinger(name: "Taylor", age: 25)
taylor.sing()
```

>If you change CountrySinger to just Singer you should be able to see the different messages appearing in the results pane.
>
>Now, to make things more complicated, we're going to define a new class called HeavyMetalSinger. But this time we're going to store a new property called noiseLevel defining how loud this particular heavy metal singer likes to scream down their microphone.
>
>This causes a problem, and it's one that needs to be solved in a very particular way:
>
>Swift wants all non-optional properties to have a value.
>* Our Singer class doesn't have a noiseLevel property.
>* So, we need to create a custom initializer for HeavyMetalSinger that accepts a noise level.
>* That new initializer also needs to know the name and age of the heavy metal singer, so it can pass it onto the superclass Singer.
>* Passing on data to the superclass is done through a method call, and you can't make method calls in initializers until you have given all your properties values.
>* So, we need to set our own property first (noiseLevel) then pass on the other parameters for the superclass to use.
>
>That might sound awfully complicated, but in code it's straightforward. Here's the HeavyMetalSinger class, complete with its own sing() method:

```swift
class HeavyMetalSinger: Singer {
    var noiseLevel: Int

    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }

    override func sing() {
        print("Grrrrr rargh rargh rarrrrgh!")
    }
}
```

>Notice how its initializer takes three parameters, then calls `super.init()` to pass name and age on to the `Singer` superclass - but only after its own property has been set. 
>* You'll see `super` used a lot when working with objects, and it just means *"call a method on the class I inherited from.”* 
>* It's usually used to mean *"let my parent class do everything it needs to do first, then I'll do my extra bits."*
>
>**Class inheritance** is a big topic so don't fret if it's not clear just yet. However, there is one more thing you need to know: class inheritance often spans many levels. 
>
>For example, 
>* A could inherit from B, 
>* and B could inherit from C,
>* and C could inherit from D,
>* and so on. 
>
>This lets you build functionality and re-use up over a number of classes, helping to keep your code modular and easy to understand.

### Working with Objective-C code

>If you want to have some part of Apple’s operating system call your Swift class’s method, you need to mark it with a special attribute: `@objc`. 
>* This is short for “Objective-C”, and the attribute effectively marks the method as being available for older Objective-C code to run – which is almost all of iOS, macOS, watchOS, and tvOS. 
>
>For example, if you ask the system to call your method after one second has passed, you’ll need to mark it with `@objc`.
>
>**Don’t worry too much about `@objc` for now** – not only will I be explaining it in context later on, but Xcode will always tell you when it’s needed. 
>* Alternatively, if you don’t want to use `@objc` for individual methods you can put `@objc`Members before your class to automatically make all its methods available to Objective-C.

:pray:

### Values and references

>When you copy a struct, the whole thing is duplicated, including all its values. This means that changing one copy of a struct doesn't change the other copies – they are all individual. With classes, each copy of an object points at the same original object, so if you change one they all change. Swift calls structs "value types" because they just point at a value, and classes "reference types" because objects are just shared references to the real value.
>
>This is an important difference, and it means the choice between structs and classes is an important one:
>
>* If you want to have one shared state that gets passed around and modified in place, you're looking for classes. You can pass them into functions or store them in arrays, modify them in there, and have that change reflected in the rest of your program.
>* If you want to avoid shared state where one copy can't affect all the others, you're looking for structs. You can pass them into functions or store them in arrays, modify them in there, and they won't change wherever else they are referenced.
>* If I were to summarize this key difference between structs and classes, I'd say this: classes offer more flexibility, whereas structs offer more safety. As a basic rule, you should always use structs until you have a specific reason to use classes.