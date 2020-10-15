# Day 27 • Thursday October 15, 2020

>You probably remember learning about **closures** a couple of weeks ago, mostly because it was a particularly tough part of the course. Since then I’ve tried to work them back in slowly so you can master them little by little, and today it’s time to dive into them with our own closure.

Yikes :sweat_smile:

>I think you already know what I’m going to say, but I’ll say it anyway: this isn’t going to be easy. But the US general George Patton once said, _“accept the challenges so that you can feel the exhilaration of victory”_ – when you finally feel like you understand closures (which might be today!) that’s when you know you’re really getting comfortable with Swift.

:us: :eagle: :fireworks: En effet.

>Today I’ll be introducing a new aspect of closures called **capture lists**. 
>* To make things easier, I prepared a new article just for this series that explains in detail what capture lists are and how they work – you should start by reading that.
>
>Today you should work through the article on capture lists, then the three topics from project 5.

## :one: [**Capture lists in Swift** : What's the difference between weak, strong and unowned references?](https://www.hackingwithswift.com/articles/179/capture-lists-in-swift-whats-the-difference-between-weak-strong-and-unowned-references) 

>Capture lists come before a closure’s parameter list in your code, and capture values from the environment as either strong, weak, or unowned. We use them a lot, mainly to avoid strong reference cycles – aka retain cycles.
>
>Deciding which to use isn’t easy when you’re learning, so you can spend time trying to figure out strong vs weak, or weak vs unowned, but as you progress with your learning you’ll start to realize there’s often only one right choice.
>
>First, let’s take a look at the problem. First, here’s a simple class:

```swift
class Singer {
    func playSong() {
        print("Shake it off!")
    }
}
```

>Second, here’s a function that creates an instance of Singer, creates a closure that uses the singer’s playSong() method, and returns that closure for us to use elsewhere:

```swift
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = {
        taylor.playSong()
        return
    }

    return singing
}
```

Finally, we can call sing() to get back a function we can call wherever we want to have playSong() printed:

```swift
let singFunction = sing()
singFunction()
``` 

That will print “Shake it off!” thanks to the call to `singFunction().`

### Strong Capturing (_default_)

>Unless you ask for something special, Swift uses strong capturing. This means the closure will capture any external values that are used inside the closure, and make sure they never get destroyed.

:point_up: Therefore this is it's default

>Look again at our sing() function:

```swift
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = {
        taylor.playSong()
        return
    }

    return singing
}
```

>That `taylor` constant is made inside the `sing() `function, 
>* so _**normally** it would be destroyed_ when the function ends. 
> 
>However, _it gets used inside the closure_, which means Swift will automatically make sure it __stays alive for as long as the closure exists__ somewhere, even after the function has returned.
>
>This is strong capturing in action. If Swift allowed `taylor` to be destroyed, then the closure would no longer be safe to call – its `taylor.playSong()` method wouldn’t be valid any more.

### Weak Capturing

>Swift lets us specify a **capture list** to determine how values used inside the closure should be captured. 
>
>The most common alternative to strong capturing is called weak capturing, and it changes two things:
>
>1) Weakly captured values aren’t kept alive by the closure, so they might be destroyed and be set to `nil`.
>2) As a result of 1, weakly captured values are always _optional_ in Swift. This stops you assuming they are present when in fact they might not be.
>
>We can modify our example to use weak capturing and you’ll see an immediate difference: