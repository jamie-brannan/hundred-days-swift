import UIKit

/// `range` looping and string interpolation
let count = 1...10
for number in count {
    print("Number is \(number)")
}

/// `array` looping and string interpolation
let albums = ["Red", "1989", "Reputation"]
for album in albums {
    print("\(album) is on Apple Music")
}

print("Players gonna ")
/// `_` to loop without a constant
for _ in 1...5 {
    print("play")
}
