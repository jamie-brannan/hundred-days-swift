import UIKit

/// init object
class Person {
    var clothes: String
    var shoes: String

    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
}

/// EXAMPLE: class inheritance

/// parent class
class Singer {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    /// method
    func sing() {
        print("La la la la")
    }
}

/// plain instance of Singer
// var taylor = Singer(name: "Taylor", age: 25)
// taylor.name
// taylor.age
// taylor.sing()

/// child class 1
class CountrySinger: Singer {
  override func sing() {
      print("Trucks, guitars, and liquor")
  }
}

/// alternative instance
var taylor = CountrySinger(name: "Taylor", age: 25)
taylor.sing()

/// child class 2
class HeavyMetalSinger: Singer {
    var noiseLevel: Int

    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
      /**
       Notice how its initializer takes three parameters, then calls super.init() to pass name and age on to the Singer superclass - but only after its own property has been set.
       
       You'll see super used a lot when working with objects, and it just means "call a method on the class I inherited from.” It's usually used to mean "let my parent class do everything it needs to do first, then I'll do my extra bits."
       */
        super.init(name: name, age: age)
    }

    override func sing() {
        print("Grrrrr rargh rargh rarrrrgh!")
    }
}

var spinalTap = HeavyMetalSinger(name: "Spinal Tap", age: 11, noiseLevel: 11)
spinalTap.sing()
