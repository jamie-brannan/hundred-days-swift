import UIKit

/// associating values to enums
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

/// what calling it up can be
let talking = Activity.talking(topic: "football")

