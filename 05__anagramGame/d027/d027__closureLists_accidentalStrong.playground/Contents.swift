import UIKit

var str = "Hello, playground"

class Singer {
    init() {
        playSong()
    }

    func playSong() {
        print("Shake it off!")
    }
}

func sing() -> () -> Void {
    let taylor = Singer()
    let adele = Singer()

    let singing = { [unowned taylor, adele] in
        taylor.playSong()
        adele.playSong()
        return
    }

    return singing
}

