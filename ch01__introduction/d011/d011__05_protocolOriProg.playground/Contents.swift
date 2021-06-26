import UIKit

/// protocol with stored properities and comuted property
protocol Identifiable {
    var id: String { get set }
    func identify()
}

/// implemented the protocol
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}

/// structure adheres to the protocol
struct User: Identifiable {
    var id: String
}

let twostraws = User(id: "twostraws")
twostraws.identify()
