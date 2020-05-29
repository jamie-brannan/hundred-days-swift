import UIKit

/// give loop a label
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
          /// summon the label
            break outerLoop
        }
    }
}
