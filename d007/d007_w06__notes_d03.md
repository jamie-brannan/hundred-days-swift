# Day 3, Week 6

:calendar: – Tuesday April 21, 2020

*At home* :house:

## :five: [Returnign closures from functions](https://www.hackingwithswift.com/sixty/6/10/returning-closures-from-functions)

### :boom: Quiz insights

```swift
func mealProducer() -> (Int) -> String {
	return {
		print("I'll make dinner for \($0) people.")
	}
}
let makeDinner = mealProducer()
print(makeDinner(5))
```

:x: Oops – that's not correct. mealProducer() says it will return a closure that accepts an integer and returns a string, but it returns a closure that accepts a string and returns nothing.

## :six: [Capturing values](https://www.hackingwithswift.com/sixty/6/11/capturing-values)

>If you use any external values inside your closure, Swift captures them – stores them alongside the closure, so they can be modified even if they don’t exist any more.

## :arrow_right_hook:

>You’ve made it to the end of the sixth part of this series, so let’s summarize:
>
>1) You can assign closures to variables, then call them later on.
>2) Closures can accept parameters and return values, like regular functions.
>3) You can pass closures into functions as parameters, and those closures can have parameters of their own and a return value.
>4) If the last parameter to your function is a closure, you can use trailing closure syntax.
>5) Swift automatically provides shorthand parameter names like $0 and $1, but not everyone uses them.
>6) If you use external values inside your closures, they will be captured so the closure can refer to them later.