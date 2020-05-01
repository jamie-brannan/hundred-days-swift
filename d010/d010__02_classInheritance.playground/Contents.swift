import UIKit

class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

class Poodle: Dog {
    init(name: String) {
      /// need this kind of `init` because it is inheriting from Dog
        super.init(name: name, breed: "Poodle")
    }
}
