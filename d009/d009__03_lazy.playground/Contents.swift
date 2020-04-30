import UIKit

/// declare the structure
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

/// declare a new structure that uses it as a property
struct Person {
    var name: String
    /// `FamilyTree`only instance created when first accessed
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

/// declare a variable that will `init` with `"Ed"`
var ed = Person(name: "Ed")
/// print a call
print(ed.familyTree)
