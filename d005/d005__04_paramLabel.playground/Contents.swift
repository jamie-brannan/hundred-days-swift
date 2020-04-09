import UIKit

/// our func
func square(number: Int) -> Int {
    return number * number
}

/// use param name, can use the name `number` as reference within the equaction
let result = square(number: 8)

/// adding a second name
/// externally its `to` and `name` internally
func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Taylor")
