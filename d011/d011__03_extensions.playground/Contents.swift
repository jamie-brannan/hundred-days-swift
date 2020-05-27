import UIKit

/// if we extend the type `Int` so that it can be squared
extension Int {
    func squared() -> Int {
        return self * self
    }
}

/// this number is implied to be of type `Int`
let number = 8
number.squared()

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

/// get a `bool` statement, testing this `int`
number.isEven
