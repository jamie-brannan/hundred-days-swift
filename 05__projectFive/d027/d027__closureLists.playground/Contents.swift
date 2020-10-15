import UIKit

var str = "Hello, playground"

class Singer {
    func playSong() {
        print("Shake it off!")
    }
}

// create an instance of Singer class
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor!.playSong()
        return
    }

    return singing
}

// run it
let singFunction = sing()
singFunction()
