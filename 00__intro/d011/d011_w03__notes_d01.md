# Hacking Swift : [Day 1](https://www.hackingwithswift.com/100/swiftui/1), Week 1

:calendar: – Thursday March 26, 2020

>SwiftUI is a powerful framework for building user-interactive apps for iOS, macOS, tvOS, and even watchOS. But you can’t build software without having a programming language, so behind SwiftUI lies Swift itself: a powerful, flexible, and modern programming language that you’ll use for all your SwiftUI apps.
>
>As Mark Twain once said, “the secret to getting ahead is getting started.” Well, you’re starting now, so we’re going to dive in and >learn about variables, constants, and simple data types in Swift.
>
>**Today you have eight one-minute videos to watch**. Once you’ve watched each video there’s a short test to help make sure you’ve >understood what was taught.
>
>I know, I know: the temptation is strong to continue on to watch more videos and take more tests beyond those linked below, but >remember: don’t rush ahead! It’s much better to do one hour a day every day than do chunks with large gaps between.

## :one: [Variables](https://www.hackingwithswift.com/sixty/1/1/variables)

`IndependentStudy/hackingSwift/100DaysChallenge/d001/d001_variables.playground`

In following the video, understand after following how to write variables and manipulation possible. No secret, but they're mutable.

```swift
import UIKit

/// create variable
var str = "Hello, playground"

/// change the same variable
str = "Goodbye"
```

## :two: [Strings and integers](https://www.hackingwithswift.com/sixty/1/2/strings-and-integers)

Typing of numbers and not crossing them.

:sparkle: You can use `_` as separators for numbers! What!
> :mag: What are the realife use cases of this 

```swift
import UIKit

var str = "Hello, playground"

/// a whole number therefore an automatic
// Int
var age = 38
/// You can seperate numbers by underscores?? what??
/// Reccomended for big numbers in swift
var population = 8_000_000

// type(of: <#T##T#>)
/// what are "metatypes"?

var test = population + age
print(test)
```

## :three: [Multi-line strings](https://www.hackingwithswift.com/sixty/1/3/multi-line-strings)

>Holy fuck you can put markdown backtick short cuts ares comments in Swift, it's so beautiful!

```swift
import UIKit

var str = "Hello, playground"

/// Once again when is this used in the real working world and apps?
/// It's kind of rare to use multiple line raw strings right?
/// How are the line breaks register within the strings and how does that translate to the display?

/// line breaks included as `\n`
var str1 = """
This goes over
multiple
lines
"""
/// ATTN, this does not work unless the `"""` are on separate lines
```


## :four: [Doubles and booleans](https://www.hackingwithswift.com/sixty/1/4/doubles-and-booleans)

Two other basic types : double and booleans

```swift
var pi = 3.141

var awesome = true

```