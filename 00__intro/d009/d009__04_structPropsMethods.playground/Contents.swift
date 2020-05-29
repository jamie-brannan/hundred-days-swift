
import UIKit

/// starting point
  ///// declare struct
  //struct Student {
  //    var name: String
  //    /// initialize the struct
  //    init(name: String) {
  //        self.name = name
  //    }
  //}
  //
  ///// several instances
  //let ed = Student(name: "Ed")
  //let taylor = Student(name: "Taylor")
  //print(ed, taylor)

    struct Student {
        /// static property added
          /// let's count the class as they're created
        static var classSize = 0
        var name: String

        init(name: String) {
            self.name = name
            /// increment the class size for each instance added
            Student.classSize += 1
        }
    }

    /// 1
    let ed = Student(name: "Ed")
    /// 2
    let taylor = Student(name: "Taylor")

    /// print the count of this structure
    print(Student.classSize)
