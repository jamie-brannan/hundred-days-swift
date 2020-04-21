# Day 7, Week 5

:calendar: – Sunday April 19, 2020

*At home* :house:

## :two: [Using closures as parameters when they return values](https://www.hackingwithswift.com/sixty/6/7/using-closures-as-parameters-when-they-return-values)

>We’ve been using `() -> Void` to mean “accepts no parameters and returns nothing”, but you can replace that `Void` with any type of data to force the closure to return a value.

```swift
import UIKit

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
```
### :boom: Quiz insights

```swift
func makePizza(addToppings: (Int)) {
	print("The dough is ready.")
	print("The base is flat.")
	addToppings(3)
}
makePizza { (toppingCount: Int) in
	let toppings = ["ham", "salami", "onions", "peppers"]
	for i in 0..<toppingCount {
		let topping = toppings[i]
		print("I'm adding \(topping)")
	}
}
```
:x: This is not valid

Tuple type! The `addToppings` parameter is specified as a single-item tuple rather than a closure.

```swift
func fix(item: String, payBill: (Int) -> Void) {
	print("I've fixed your \(item)")
	payBill(450)
}
fix(item: "roof") { (bill: Int) in
	print("You want $\(bill) for that? Outrageous!")
}
```

### :three: [Shorthand parameter names](https://www.hackingwithswift.com/sixty/6/8/shorthand-parameter-names)

Took seconda and wrote down a ton of notes and reviewed all of closures in notebook because I kept totally flopping the quizzes, but not doing anything proactive about it slipping through my fingers.

### :boom: Quiz insights

Shorthand parameters are written as $0, $1 and so on.

If there's only one line of code you can skip writing `return`

Swift automatically provides the $ variables; we don't define them ourselves.

When using shorthand parameters you don't list the parameters you accept.
This is correct. In fact, trying to list the parameters will cause an error.


