import UIKit

protocol Identifiable {
    var id: String { get set }
}

/// this structure `conforms` to the protocol
struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

/// create an instance of `struct User`
var jamie = User(id: "JB")
/// `func` to print my id using the structure that conforms to the protocol
displayID(thing: jamie)
