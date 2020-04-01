import UIKit

/// a bad example of result handling would be...
let result = "failure"
let result2 = "failed"
let result3 = "fail"
/// b/c they `var` name loses meaning

/// with `enum` it's different
enum Result {
    case success
    case failure
}

/// this could prevent you from reusing wrong strings a different time
let result4 = Result.failure

