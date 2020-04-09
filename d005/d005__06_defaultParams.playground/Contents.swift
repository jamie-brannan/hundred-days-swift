
import UIKit

/// `nicely` refers to the default terminator param of `print()`
/// the `Bool = true` is modifying the default for skipping a line.
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)
