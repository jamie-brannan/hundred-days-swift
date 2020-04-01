import UIKit

/// Dictionary used
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

/// calling an existing values
favoriteIceCream["Paul"]
/// calling a non existing will result in `nil`
favoriteIceCream["Charlotte"]
/// adding a default value if it's `nil`
favoriteIceCream["Charlotte", default: "Unknown"]
