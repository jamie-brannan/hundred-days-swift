import UIKit

let weather = "blah"
let weather2 = "sunny"
let weather3 = "snow"

switch weather {
  case "rain":
      print("Bring an umbrella")
  case "snow":
      print("Wrap up warm")
  case "sunny":
      print("Wear sunscreen")
  /// required in this case if there's not one of the three cases present
  default:
      print("Enjoy your day!")
}


switch weather2 {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    /// keyword that enables the code to drop through to the next case in a switch
    fallthrough
default:
    print("Enjoy your day!")
}


switch weather3 {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
    /// will go to the sunny case but won't keep droping through to default
    fallthrough
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}
