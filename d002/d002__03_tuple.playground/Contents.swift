import UIKit

/// declaration
var name = (first: "Taylor", last: "Swift")

/// call via `index`
name.0
/// call via `name`
name.first

print("Let me test if I can callup " + name.0)

/// can I have more than one?
var cats = (last: "Graham", small: "Watson", bigone: "Butters")
print("I have two cats : \(cats.small) \(cats.last) and \(cats.bigone) \(cats.last)")
print(cats)
