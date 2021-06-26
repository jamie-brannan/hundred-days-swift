import UIKit

/// plain declaration
//enum Planet: Int {
//    case mercury
//    case venus
//    case earth
//    case mars
//}
/// attribute the identifier of `rawValue` and the `value` of `earth`
//let earth = Planet(rawValue: 2)
/// how that is derived in `mars`
//print(Planet.mars.rawValue)

/// can declare a rawValue without idenifier
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
/// how that is derived in mars is without a identifier
print(Planet.mars)
