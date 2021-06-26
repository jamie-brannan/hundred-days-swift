import UIKit

// define the type of sport
struct Sport {
    // one property of the string
    var name: String
}
// create an instance
var tennis = Sport(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn tennis"
