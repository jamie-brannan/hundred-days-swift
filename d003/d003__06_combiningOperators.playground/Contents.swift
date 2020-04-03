import UIKit

let age1 = 12
let age2 = 21

/// That `print()` call will only happen if both ages are over 18, which they aren’t.
if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

/// The alternative to `&&` is `||`, which evaluates as true if either item passes the test.
if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}
