import UIKit

var str = "Hello, playground"

/// Constants that will be added to an `array`
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

/// Constant `array`
let beatles = [john, paul, george, ringo]
// calling an item based on index
print(beatles[1])

// concatinating items based on index with string
print(beatles[1] + ", " + beatles[2])

/// try adding a beatle – but cannot because `beatles` is defined with `let` and is therefore constant
// let beatles[4] = "test this"
print(beatles)
