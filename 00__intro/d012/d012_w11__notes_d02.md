# Day 12(2), Week 11
:calendar: – Wednesday May 27, 2020

*At home* :house:

Continuing **Optionals**

## :three:  [Unwrapping with guard](https://www.hackingwithswift.com/sixty/10/3/unwrapping-with-guard) 

>An *alternative* to `if let `is `guard let`, which also unwraps optionals. 
>
>* `guard let` will unwrap an optional for you, but if it finds `nil` inside it expects you to exit the function, loop, or condition you used it in.
>
>:star: However, **the major difference** between `if let` and `guard let` is that *your unwrapped optional remains usable after the guard code*.
>
>Let’s try it out with a `greet()` function. 
>
>This will accept an *optional string* as its only parameter and try to unwrap it, but if there’s nothing inside it will print a message and exit.
>
>Because optionals unwrapped using `guard let `stay around after the `guard` finishes, we can print the unwrapped string at the end of the function:

```swift
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}
```

>Using `guard let` lets you deal with problems at the start of your functions, then exit immediately. This means the rest of your function is the happy path – the path your code takes if everything is correct.

### Code all together
```swift
import UIKit

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}

/// must write `nil`, cannot just put `empty`
greet(nil)
greet("Tommy")

```

### :boom: Quiz insights