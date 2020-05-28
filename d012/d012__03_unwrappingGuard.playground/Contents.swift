import UIKit

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}

/// must write `nil`, cannot just put `empty`
greet(nil)
greet("Tommy")
