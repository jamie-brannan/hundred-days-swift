import UIKit

/// create an array
var toys = ["Woody"]
/// count number of `items` in the array
print(toys.count)
/// add a new item to the array
toys.append("Buzz")
/// locate any item in them with
toys.firstIndex(of: "Buzz")
/// sort alphabetically in an array
print(toys.sorted())
/// remove an item from array
toys.remove(at: 0)
