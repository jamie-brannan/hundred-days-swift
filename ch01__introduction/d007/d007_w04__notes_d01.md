# Day 7, Week 4

:calendar: – Tuesday April 14, 2020

*At home* :house:

Today's theme continues to be **Closures** (part 2).

- [Day 7, Week 4](#day-7-week-4)
	- [:one: Using closures as parameters when they accept parameters](#one-using-closures-as-parameters-when-they-accept-parameters)
		- [:boom: Question insights](#boom-question-insights)
	- [Wrap up](#wrap-up)

>Today you have seven one-minute videos to watch, and you’ll learn about how closures accept parameters and return values.

## :one: [Using closures as parameters when they accept parameters](https://www.hackingwithswift.com/sixty/6/6/using-closures-as-parameters-when-they-accept-parameters)

>This is where closures can start to be read a bit like line noise: a closure you pass into a function can also accept its own parameters.
>
>We’ve been using `() -> Void` to mean “accepts no parameters and returns nothing”, but you can go ahead and fill the `()` with the types of any parameters that your closure should accept.
>
>To demonstrate this, we can write a `travel()` function that accepts a ***closure*** as its only parameter, and that **closure** in turn accepts a string:

```swift
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

/// this prints out
    /// I'm getting ready to go.
    /// I'm going to London in my car
    /// I arrived!

```

### :boom: Question insights

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
> Oops – that's not correct. The addToppings parameter is specified as a single-item tuple rather than a closure.

```swift
func fix(item: String, payBill: (Int) -> Void) {
	print("I've fixed your \(item)")
	payBill(450)
}
fix(item: "roof") { (bill: Int) in
	print("You want $\(bill) for that? Outrageous!")
}
```

:white_check_mark: Valid swift

```swift
func study(reviseNotes: (String) -> Void) {
	let notes = "Napoleon was a short, dead dude."
	for _ in 1...10 {
		reviseNotes(notes)
	}
}
study { (notes: String) in
	print("I'm reading my notes: \(notes)")
}
```

:white_check_mark: Valid swift

```swift
func makeSale(signContract: (String) -> Void) {
	let clientName = "Apple"
	print("\(clientName) should buy our product.")
	print("You're interested? Great! Sign here.")
	signContract(clientName)
}
makeSale { (client: String) in
	print("We agree to pay you $100 million.")
	print("Signed, \(client)")
}
```
:white_check_mark: Valid swift


```swift
func processPrimes(using closure: (Int) -> Void) {
	let primes = [2, 3, 5, 7, 11, 13, 17, 19]
	for prime in primes {
		closure(prime)
	}
}
processPrimes { (prime: Int) 
	print("\(prime) is a prime number.")
	let square = prime * prime
	print("\(prime) squared is \(square)")
}
```

:x:  This is not valid
>Oops – that's not correct. The processPrimes closure is missing the in keyword after its parameter list.





## Wrap up

1) Shadow sur la nav

2) Back button controls

3) Resize space of the label