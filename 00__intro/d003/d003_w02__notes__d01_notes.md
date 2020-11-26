 # Day 3, Week 2
 
 :calendar: – Wednesday April 02, 2020
 
 Today's theme is *Operations and conditions*.

- [Day 3, Week 2](#day-3-week-2)
  - [:one: Arithmetic operators](#one-arithmetic-operators)
    - [Recap](#recap)
    - [:boom: Questions results](#boom-questions-results)
      - [Which of these make result an integer equal to 5?](#which-of-these-make-result-an-integer-equal-to-5)
  - [:two: Operator Overloading](#two-operator-overloading)
    - [:boom: Questions results](#boom-questions-results-1)
      - [This code is valid Swift – true or false?](#this-code-is-valid-swift--true-or-false)
  - [:three: Compound assignment operators](#three-compound-assignment-operators)
  - [:four: Comparison operators](#four-comparison-operators)
  - [:five: Conditions](#five-conditions)
    - [:boom: Questions results](#boom-questions-results-2)
  - [:six: Combining conditions](#six-combining-conditions)
  - [:seven: The Ternary Operator](#seven-the-ternary-operator)
  - [:eight: Switch statements](#eight-switch-statements)
  - [:nine: Range operators](#nine-range-operators)
  - [:arrow_right_hook: Operators and conditions summary](#arrow_right_hook-operators-and-conditions-summary)
 ## :one: [Arithmetic operators](https://www.hackingwithswift.com/sixty/3/1/arithmetic-operators)

 The standard arithmatic operators work

 ```swift
 import UIKit

let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore

let product = firstScore * secondScore
let divided = firstScore / secondScore

let remainder = 13 % secondScore
 ```

The *remainder operator*, or as I've heard it called in french *moduluo* is something I haven't really though to use in languages other than `swift`

[Documentation](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html) : *Basic Operators* - Remainder Operator

>The remainder operator (a % b) works out how many multiples of b will fit inside a and returns the value that is left over (known as the remainder).
>
>>NOTE
>>
>>The remainder operator (%) is also known as a modulo operator in other languages. >>However, its behavior in Swift for negative numbers means that, strictly speaking, >>it’s a remainder rather than a modulo operation.
>>
>>Here’s how the remainder operator works. To calculate 9 % 4, you first work out how many 4s will fit inside 9:
>
>>![../images/remainderInteger_2x.png]
>You can fit two 4s inside 9, and the remainder is 1 (shown in orange).
>
>In Swift, this would be written as:
>
>`9 % 4    // equals 1`
>To determine the answer for a % b, the % operator calculates the following equation >and returns remainder as its output:
>
>`a = (b x some multiplier) + remainder`
>
>where some multiplier is the largest number of multiples of b that will fit inside >a.
>
>Inserting 9 and 4 into this equation yields:
>
>`9 = (4 x 2) + 1`
>
>The same method is applied when calculating the remainder for a negative value of a:
>
>`-9 % 4   // equals -1`
>Inserting -9 and 4 into the equation yields:
>
>`-9 = (4 x -2) + -1`
>
>giving a remainder value of `-1`.
>
>The sign of b is ignored for negative values of b. This means that a % b and a % -b always give the same answer.

### Recap

 | operation | symbol associated |
 |---|---|
 | addition | + |
 | subtraction | - |
 | multiplication | * |
 | division rounded | / |
 | division remainder | % |


### :boom: Questions results

#### Which of these make result an integer equal to 5?

```swift
/// 11 divides into 6 once, leaving remainder 5.
var result = 11 % 6

/// This will create a double, not an integer.
var result = 2 + 2 + 1.0
```

## :two: [Operator Overloading](https://www.hackingwithswift.com/sixty/3/2/operator-overloading)

>Swift supports **operator overloading**, which is a fancy way of saying that what an operator does depends on the values you use it with.
>
>However it is type safe, so there is no way to mix up the functions.

```swift
import UIKit

let meaningOfLife = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf
```

### :boom: Questions results

#### This code is valid Swift – true or false?

`let result = false + false`

>Oops – that's not correct. You can't perform addition using Booleans.

## :three: [Compound assignment operators](https://www.hackingwithswift.com/sixty/3/3/compound-assignment-operators)

>Swift has shorthand operators that combine one operator with an assignment, so you can change a variable in place. These look like the existing operators you know – +, -, *, and /, but they have an = on the end because they assign the result back to whatever variable you were using.

```swift
import UIKit

var score = 95
score -= 5
print(score)

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"
print(quote)
```

## :four: [Comparison operators](https://www.hackingwithswift.com/sixty/3/4/comparison-operators)

>Swift has several operators that perform comparison, and these work more or less like you would expect in mathematics.

```swift
import UIKit

let firstScore = 6
let secondScore = 4

/// `==` checks two values are the same
firstScore == secondScore
/// `=!` (pronounced “not equals”) checks two values are not the same
firstScore != secondScore

firstScore < secondScore
firstScore >= secondScore

/// works with strings because of the alphabetical order
"Taylor" <= "Swift"
```

## :five: [Conditions](https://www.hackingwithswift.com/sixty/3/5/conditions)

>Now you know some operators you can write conditions using if statements. You give Swift a condition, and if that condition is true it will run code of your choosing.

```swift
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Blackjack!")
}
```

### :boom: Questions results

>This code will print "Success" – true or false?

```swift
var actualWage: Int = 22_000
var medianWage: Double = 22_000
if actualWage >= medianWage {
	print("Success")
}
```

>Oops – that's not correct. This attempts to compare an integer to a double, which is invalid.

## :six: [Combining conditions](https://www.hackingwithswift.com/sixty/3/6/combining-conditions)

>Swift has two special operators that let us combine conditions together: they are `&&` (pronounced “and”) and `||` (pronounced “or”).

```swift
import UIKit

let age1 = 12
let age2 = 21

/// That `print()` call will only happen if both ages are over 18, which they aren’t.
if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

/// The alternative to `&&` is `||`, which evaluates as true if either item passes the test.
if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}

```

## :seven: [The Ternary Operator](https://www.hackingwithswift.com/sixty/3/7/the-ternary-operator)

>It works with *three values* at once, which is where its name comes from: 
1) it checks a condition specified in the first value, 
    * and if it’s true returns the second value, 
        * but if it’s false returns the third value.
>
>The **ternary operator** *is a condition plus true or false blocks all in one*, split up by a question mark and a colon, all of which which makes it rather hard to read.

 ```swift
 import UIKit

let firstCard = 11
let secondCard = 10
/// check if the cards are the same
  /// then print text if they are true, print this other text if it's false
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

/// same as this stuff
if firstCard == secondCard {
    print("Cards are the same")
} else {
    print("Cards are different")
}
```

Gotta be careful with types that are being compared

## :eight: [Switch statements](https://www.hackingwithswift.com/sixty/3/8/switch-statements)

>If you have several conditions using if and else if, it’s often clearer to use a different construct known as switch case. Using this approach you write your condition once, then list all possible outcomes and what should happen for each of them.

>`default` – is required because Swift makes sure you cover all possible cases so that no eventuality is missed off.

Defaults are good for catching all unmatched cases.

```swift
import UIKit

let weather = "sunny"

switch weather {
  case "rain":
      print("Bring an umbrella")
  case "snow":
      print("Wrap up warm")
  case "sunny":
      print("Wear sunscreen")
  /// required in this case if there's not one of the three cases present
  default:
      print("Enjoy your day!")
}
```

>Swift will only run the code inside each case. If you want execution to continue on to the next case, use the `fallthrough` keyword like this:

```swift
let weather2 = "sunny"
let weather3 = "snow"

switch weather2 {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    /// keyword that enables the code to drop through to the next case in a switch
    fallthrough
default:
    print("Enjoy your day!")
}

switch weather3 {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
    /// will go to the sunny case but won't keep droping through to default
    fallthrough
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}
```

## :nine: [Range operators](https://www.hackingwithswift.com/sixty/3/9/range-operators)

>Swift gives us two ways of making ranges: the `..<` and `...` operators. 
>
>The **half-open range operator**, `..<`, creates ranges up to but excluding the final value, and t~, `...`, creates ranges up to and including the final value.

```swift
let score = 85

switch score {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}
```

## :arrow_right_hook: [Operators and conditions summary](https://www.hackingwithswift.com/sixty/3/10/operators-and-conditions-summary)

>You’ve made it to the end of the third part of this series, so let’s summarize:
>
> 1) Swift has operators for doing arithmetic and for comparison; they mostly work like you already know.
> 2) There are compound variants of arithmetic operators that modify their variables in place: +=, -=, and so on.
> 3) You can use if, else, and else if to run code based on the result of a condition.
> 4) Swift has a ternary operator that combines a check with true and false code blocks. Although you might see it in other code, I wouldn’t recommend using it yourself.
> 5) If you have multiple conditions using the same value, it’s often clearer to use switch instead.
> 6) You can make ranges using ..< and ... depending on whether the last number should be excluded or included.