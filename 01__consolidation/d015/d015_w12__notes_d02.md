# Day 15(2), Week 12
:calendar: – Saturday June 06, 2020

*At home* :house:

### recap
* polymorphism is when you're an instance of multiple classes, and therefore insances of each at the same time.

### Converting types with typecasting

>You will often find you have an object of a certain type, but really you know it's a different type. Sadly, if Swift doesn't know what you know, it won't build your code. So, there's a solution, and it's called typecasting: converting an object of one type to another.
>
>Chances are you're struggling to think why this might be necessary, but I can give you a very simple example:

```swift
for album in allAlbums {
    print(album.getPerformance())
}
```

>That was our loop from a few minutes ago. The `allAlbums` array holds the type `Album`, but we know that really it's holding one of the *subclasses*: `StudioAlbum` or `LiveAlbum`. Swift doesn't know that, so if you try to write something like `print(album.studio)` it will refuse to build because only `StudioAlbum` objects have that property.
>
>Typecasting in Swift comes in *three forms*, but most of the time you'll only meet two: 
>* `as? `
>* and `as!`, 
>
>known as **optional downcasting** and **forced downcasting**. 
>
>The former means "I think this conversion might be true, but it might fail," and the second means "I know this conversion is true, and I'm happy for my app to crash if I'm wrong."

**optional downcasting** : *(swift)* *"this conversion might be true, but it might fail"*
* written as `as?`

**forced downcasting** : *(swift)* *"I know this conversion is true and I'm happy for my app to crash if I'm wrong"*
* accept the consequences
* written as `as!`

>**Note**: when I say "conversion" I don't mean that the object literally gets transformed. Instead, it's just **converting** how Swift treats the object – you're telling Swift that an object it thought was type A is actually type E.
>
>The question and exclamation marks should give you a hint of what's going on, because this is very similar to **optional territory**. For example, if you write this:

```swift
for album in allAlbums {
    let studioAlbum = album as? StudioAlbum
}
```

>Swift will make `studioAlbum` have the data type `StudioAlbum`?. That is, an optional studio album: the conversion might have worked, in which case you have a studio album you can work with, or it might have failed, in which case you have nil.
>
>This is most commonly used with `if let` to automatically unwrap the optional result, like this:

```swift
for album in allAlbums {
    print(album.getPerformance())

    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}
```

>That will go through every album and print its performance details, because that's common to the `Album` class and all its subclasses. It then checks whether it can convert the `album` value into a `StudioAlbum`, and if it can it prints out the studio name. The same thing is done for the `LiveAlbum` in the array.
>
>**Forced downcasting** is when you're really sure an object of one type can be treated like a different type, but if you're wrong your program will just crash. 
>* Forced downcasting doesn't need to return an optional value, because you're saying the conversion is definitely going to work – if you're wrong, it means you wrote your code wrong.
>
>To demonstrate this in a non-crashy way, let's strip out the live album so that we just have studio albums in the array:

```swift
var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")

var allAlbums: [Album] = [taylorSwift, fearless]

for album in allAlbums {
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.studio)
}
```

>That's obviously a contrived example, because if that really were your code you would just change `allAlbums` so that it had the data type `[StudioAlbum]`. Still, it shows how forced downcasting works, and the example won't crash because it makes the correct assumptions.
>
>Swift lets you downcast as part of the array loop, which in this case would be more efficient. If you wanted to write that forced downcast at the array level, you would write this:

```swift
for album in allAlbums as! [StudioAlbum] {
    print(album.studio)
}
```

>That no longer needs to downcast every item inside the loop, because it happens when the loop begins. Again, you had better be correct that all items in the array are `StudioAlbums`, otherwise your code will crash.
>
>Swift also allows **optional downcasting** at the array level, although it's a bit more tricksy because you need to use **the nil coalescing operator** to ensure there's always a value for the loop. Here's an example:

```swift
for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.location)
}
```

:question: *What's a that again*

>What that means is, “try to convert `allAlbums` to be an array of `LiveAlbum` objects, but if that fails just create an empty array of live albums and use that instead” – i.e., do nothing.

### Converting common types with initializers

>Typecasting is useful when you know something that Swift doesn’t, for example when you have an object of type `A` that Swift thinks is actually type `B`. However, typecasting is useful only when those types really are what you say – you can’t force a type `A` into a type `Z` if they aren’t actually related.
>
>For example, if you have an integer called `number`, you couldn’t write code like this to make it a string:

```swift
let number = 5
let text = number as! String
```

>That is, you can’t force an integer into a string, because they are two completely different types. Instead, you need to create a new string by feeding it the integer, and Swift knows how to convert the two. The difference is subtle: this is a new value, rather than just a re-interpretation of the same value.
>
>So, that code should be rewritten like this:

```swift
let number = 5
let text = String(number)
print(text)
```

>This only works for some of Swift’s built-in data types: you can convert integers and floats to strings and back again, for example, but if you created two custom structs Swift can’t magically convert one to the other – you need to write that code yourself.

## :five: [Closures](https://www.hackingwithswift.com/read/0/21/closures)

>You've met integers, strings, doubles, floats, Booleans, arrays, dictionaries, structs and classes so far, but there's another *type of data* that is used extensively in Swift, and it's called a **closure**. 
>* These are complicated, but they are so powerful and expressive that they are used pervasively in Cocoa Touch, so you won't get very far without understanding them.
>
>A closure can be thought of as **a variable that holds code.** 
>* So, where an integer holds 0 or 500, a closure holds lines of Swift code. 
>
>Closures also **capture the environment** where they are created, which means they *take **a copy of the values** that are used inside them.*

Make a copy without being a stored place?

>You never need to design your own closures so don't be afraid if you find the following quite complicated. However, both Cocoa and Cocoa Touch will often ask you to write closures to match their needs, so you at least need to know how they work. Let's take a Cocoa Touch example first:

```swift
let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})
```

>`UIView` is an iOS data type in UIKit that represents the most basic kind of user interface container. Don't worry about what it does for now, all that matters is that it's the *basic user interface component*. `UIView` has a method called `animate()` and it lets you change the way your interface looks using animation – you describe what's changing and over how many seconds, and Cocoa Touch does the rest.
>
>The `animate()` method takes two parameters in that code: the number of seconds to animate over, and a closure containing the code to be executed as part of the animation. 
>* I've specified half a second as the first parameter, and for the second I've asked UIKit to adjust the view's alpha (that's opacity) to 0, which means "completely transparent."
>
>This method needs to use a closure because UIKit has to do all sorts of work to prepare for the animation to begin, so what happens is that UIKit *takes a copy of the code* **inside the braces (that's our closure),** stores it away, does all its prep work, then runs our code when it's ready. 
>* This wouldn't be possible if we just run our code directly.
>
>The above code also shows how closures capture their environment: I declared the `vw` constant outside of the closure, then used it inside. Swift detects this, and makes that data available inside the closure too.
>
>Swift's system of automatically capturing a closure's environment is very helpful, but can occasionally trip you up: if object A stores a closure as a property, and that property also references object A, you have something called a strong reference cycle and you'll have unhappy users. This is a substantially more advanced topic than you need to know right now, so don't worry too much about it just yet.

### Trailing closures

>As closures are used so frequently, Swift can apply a little syntactic sugar to make your code easier to read. The rule is this: if the last parameter to a method takes a closure, you can eliminate that parameter and instead provide it as a block of code inside braces. For example, we could convert the previous code to this:

```swift
let vw = UIView()

UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}
```

>It does make your code shorter and easier to read, so this syntax form – known as trailing closure syntax – is preferred.