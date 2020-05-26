# Day 11, Week 10
:calendar: – Thursday May 14, 2020

*At home* :house:

Today's theme is **Protocols and Extensions**

>Today you’re going to learn some truly Swifty functionality: protocols and protocol-oriented programming (POP).
>
>POP does away with large, complex inheritance hierarchies, and replaces them with much smaller, *simpler* protocols that can be combined together. This really is the fulfillment of something Tony Hoare said many years ago: “inside every large program, there is a small program trying to get out.”

Funny!

:question: What makes this different from **OOP**?

## :one:  [Protocols](https://www.hackingwithswift.com/sixty/9/1/protocols) 

>Protocols are a way of describing what properties and methods something must have. You then tell Swift which types use that protocol – a process known as adopting or conforming to a protocol.

**`protocol`** : *(swift)* describe what properties and methods something must have and which types use it
* you can *conform* or *adopt* to a `protocol`

>For example, we can write a function that accepts something with an `id` property, but we don’t care precisely what type of data is used. 
>
>We’ll start by creating an `Identifiable` protocol, which will require all conforming types to have an `id` string that can be read (“get”) or written (“set”):

```swift
protocol Identifiable {
    var id: String { get set }
}
```

>We can’t create instances of that *protocol - it’s a description of what we want*, rather than something we can create and use directly. 
>
>**But** we can create a struct that conforms to it:

```swift
struct User: Identifiable {
    var id: String
}
```

>Finally, we’ll write a `displayID()` function that accepts any `Identifiable` object:

```swift
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}
```

