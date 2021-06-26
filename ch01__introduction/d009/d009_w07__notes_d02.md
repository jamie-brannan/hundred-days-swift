# Day 9 (2), Week 7 

:calendar: – Wednesday April 29, 2020

*At home* :house:

Continuting to learn **Structs**

- [Day 9 (2), Week 7](#day-9-2-week-7)
  - [:three: Lazy properties](#three-lazy-properties)
    - [:boom: Quiz insights](#boom-quiz-insights)
  - [:four: Static properties and methods](#four-static-properties-and-methods)
    - [Starting point](#starting-point)
    - [Modified](#modified)

## :three: [Lazy properties](https://www.hackingwithswift.com/sixty/7/10/lazy-properties)

>As a performance optimization, Swift lets you create some properties only when they are needed. 

```swift
/// it doesn’t do much, but in theory creating a family tree for someone takes a long time
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}
```

We might use that `FamilyTree` struct as a *property* inside a `Person` struct, like this:

```swift
struct Person {
    var name: String
    var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = Person(name: "Ed")
```

>*But what if we didn’t always need the family tree for a particular person?* 
>
>If we add the lazy keyword to the `familyTree` property, **then** Swift *will only **create*** the `FamilyTree` struct *when it’s first accessed*:

```swift
lazy var familyTree = FamilyTree()

ed.familyTree
```

So

```swift
import UIKit

/// declare the structure
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

/// declare a new structure that uses it as a property
struct Person {
    var name: String
    /// `FamilyTree`only instance created when first accessed
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

/// declare a variable that will `init` with `"Ed"`
var ed = Person(name: "Ed")
/// print a call
print(ed.familyTree)

```

### :boom: Quiz insights

* Lazy properties can be used inside any kind of structs
* Lazy properties are a performance optimization.
* A lazy property can be an instance of a different struct.
* You can assign lazy properties by calling a method.
* Lazy properties are created only when first accessed.

## :four: [Static properties and methods](https://www.hackingwithswift.com/sixty/7/11/static-properties-and-methods)

### Starting point

>All the properties and methods we’ve created so far have belonged to individual instances of structs, which means that if we had a `Student` struct we could create several student instances each with their own properties and methods

```swift
/// declare struct
struct Student {
    var name: String
    /// initialize the struct
    init(name: String) {
        self.name = name
    }
}

/// several instances
let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")
```

### Modified

>You can also ask Swift to *share* specific properties and methods across all instances of the `struct` by declaring them as static.
>
>...add a **static property** to the `Student` struct to store how many students are in the class. Each time we create a new student, we’ll add one to it:

```swift
struct Student {
    /// static property added
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        /// increment the class size for each instance added
        Student.classSize += 1
    }
}
```

So basically lets make this automatically count the students while we create them – without it being an id system.

>Because the `classSize` property *belongs to the struct **itself rather than** instances of the struct*, we need to read it using `Student.classSize`:

```swift
print(Student.classSize)
```

So all together the code would look like this:

```swift
struct Student {
    /// static property added
      /// let's count the class as they're created
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        /// increment the class size for each instance added
        Student.classSize += 1
    }
}

/// 1
let ed = Student(name: "Ed")
/// 2
let taylor = Student(name: "Taylor")

/// print the count of this structure
print(Student.classSize)
```

