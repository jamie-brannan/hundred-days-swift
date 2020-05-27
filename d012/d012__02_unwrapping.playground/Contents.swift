import UIKit

var name: String? = nil
name = "jamie"
/// resolve `name.count
/// unwrap via `if let` condition
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

