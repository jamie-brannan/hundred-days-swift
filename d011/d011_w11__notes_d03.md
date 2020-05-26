# Day 11(3), Week 11
:calendar: – Tuesday May 26, 2020

*At home* :house:

## :two:  [Protocol Inheritance](https://www.hackingwithswift.com/sixty/9/2/protocol-inheritance) 

>One protocol can inherit from another in a process known as **protocol inheritance**. 
>
>Unlike with classes, you can inherit from multiple protocols at the same time before you add your own customizations on top.

>We’re going to define three protocols: `Payable` requires conforming types to implement a `calculateWages() `method, `NeedsTraining` requires conforming types to implement a `study()` method, and `HasVacation` requires conforming types to implement a `takeVacation()` method:

```swift
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}
```

>We can now create a single Employee protocol that brings them together in one protocol. We don’t need to add anything on top, so we’ll just write open and close braces:

```swift
/// single protocol that `inhereits` all previous ones
protocol Employee: Payable, NeedsTraining, HasVacation { }
```

>Now we can make new types conform to that single protocol rather than each of the three individual ones.

### :boom: Quiz insights

```swift
protocol Buyable {
	var cost: Int
}
protocol Sellable {
	func findBuyers() -> [String]
}
protocol FineArt: Buyable, Sellable { }
```

:x: Oops – that's not correct. The cost property must have `{ get }` or `{ get set }` after it.

```swift
protocol GivesOrders {
	func makeItSo()
}
protocol OrdersDrinks {
	func teaEarlGrey(hot: Bool)
}
protocol StarshipCaptain: GivesOrders, OrdersDrinks { }
```
:white_check_mark: 

```swift
protocol HasEngine {
	func startEngine()
}
protocol HasTrunk {
	func openTrunk()
}
struct Car: HasEngine, HasTrunk { }
```
:x: Oops – that's not correct. Although Car conforms to both protocols, there is no protocol inheritance here – neither protocol builds on the other.

