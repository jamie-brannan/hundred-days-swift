import UIKit

/// define the cases of possible error
enum PasswordError: Error {
    case obvious
}

/// function written to check passwords
/// put `throw` before the `->` return so that it'll be thrown out before anything is returned outside the funciton
func checkPassword(_ password: String) throws -> Bool {
    /// this is just way too obvious so we want this to indicate it's not good before we're done
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
  /// this print code is never reached b/c error is thrown
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
