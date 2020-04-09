import UIKit

var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")

/// this is always `false`, so won't print
while false {
    print("This is false")
}

/// however this is going to print once becaues it only fails after 
repeat {
    print("This is false")
} while false
