import UIKit

/// want to change the value directly, rather than return a new one
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
/// the `&` is an explicit recognition that it's being used as an `inout`
doubleInPlace(number: &myNum)
