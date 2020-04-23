import UIKit

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
