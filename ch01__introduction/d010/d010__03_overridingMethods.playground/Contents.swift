import UIKit

class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

/// Poodle inherits from Dog
class Poodle: Dog {
  /// We will alter however it's noise
    override func makeNoise() {
        print("Yip!")
    }
}

/// defalt
class Jack: Dog {
}

let poppy = Poodle()
let cora = Jack()

poppy.makeNoise()
cora.makeNoise()
