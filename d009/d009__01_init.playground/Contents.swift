import UIKit

/// we can provide our own initializer (replace the default)
struct User {
    var username: String
    /// ex, create all users as anonymous
    /// ATTN : you do NOT write `func` before initializers
    init() {
        /// make sure all properties have a value before it ends
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "twostraws"
