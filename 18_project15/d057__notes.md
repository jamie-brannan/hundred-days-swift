# *Day 57 • Tuesday May 11, 16 2021*

>Today we’re going to be looking at a fundamentally important part of iOS development: animation.

:tada:

>Years ago animation was often considered inconsequential – it was there to make something look nice, rather than adding real value. **But today we recognize that animation helps guide users through state changes in our app**: when they delete an email it moved into the trash can, so they can see that it’s gone and know where to go if they want it back.
>
>**John Maeda**, design lead at Automattic (the company behind Wordpress), put this rather succinctly: _“Design used to be the seasoning you’d sprinkle on for taste; now it’s the flour you need at the start of the recipe.”_ 
>* That means we need to be thinking about animation at the early stages of our app – deciding how the user should interact with everything we show them needs to be at the core of our design.
>
>Today is all about **bringing your user interfaces to life** with movement, scaling, rotation, and more. We’ll be working in a **sandbox**, but you can use these principles anywhere!
>
>**Today you have three topics to work through, and you’ll learn about `animate(withDuration:)`, `CGAffineTransform`, `alpha`, and more.**

- [*Day 57 • Tuesday May 11, 16 2021*](#day-57--tuesday-may-11-16-2021)
  - [:one:  Setting up](#1️⃣-setting-up)
  - [:two:  Preparing for action](#2️⃣-preparing-for-action)
  - [:three:  Switch, case, animate, animate(withDuration:)](#3️⃣-switch-case-animate-animatewithduration)
  - [:four:  Transform CGAffineTransform](#4️⃣-transform-cgaffinetransform)

## :one:  [Setting up](https://www.hackingwithswift.com/read/15/1/setting-up) 

>It's time to introduce one of the most important techniques in iOS development: animation. Sadly, many people don't consider animation important at all, which makes for some thoroughly awful user interface design.
>
>Animation – making things move, scale, and so on – of your views is not only about making things pretty, although that's certainly a large part. **Its main purpose is to give users a sense of what's changing and why, and it helps them make sense of a state change in your program.**
>
>When we use a navigation controller to show a new view controller, we don't just want it to appear. _Instead, we want it to slide in, making it clear that the old screen hasn't gone away, it's just to the left of where we were._
>
>You're almost certainly tired of hearing me say this, but iOS has _a ridiculously powerful_ **animation toolkit **that's also easy to use. I know, I'm a broken record, right?
>
>Well, don't just take my word for it – let's try out some animation together so you can see exactly how it works. So, create a new Single View App project in Xcode, naming it Project15.
>
>Please download the files for this project from GitHub (https://github.com/twostraws/HackingWithSwift) and copy its Content folder into your Xcode project. Finally, set it to work on landscape iPads only. Animation of course works on all devices and in all orientations, but it's easier to work with a fixed size for now.

## :two:  [Preparing for action](https://www.hackingwithswift.com/read/15/2/preparing-for-action) 

>Open Interface Builder with `Main.storyboard` and place a button on there with the title "Tap" – position it in the middle of the screen, near the bottom. Don’t worry that we’re positioning things using an iPhone XR-sized screen – Auto Layout will automatically make it look great on iPads.

:white_check_mark: Added button and constraints.

>We want our button to always stay near the bottom of the view controller, so Ctrl-drag from the button to the view directly below it and choose “Bottom Space to Safe Area.” Now Ctrl-drag the same way again and choose "Center Horizontally in Safe Area.”

:white_check_mark: Done.

>That's it for Auto Layout, so please switch to the assistant view so we can add an action and an outlet. Ctrl-drag from the button to your code to _create an action for the button_ called `tapped()`.

:white_check_mark: Added outlet called `tappedTappedButton`

>**Every time the user taps the "Tap" button, we're going to execute a different animation.** 
>* This will be accomplished by cycling through a counter, and moving an image view. 
>
>To make all that work, you need to add two more properties to the class:

```swift
var imageView: UIImageView!
var currentAnimation = 0
```

>There isn't an image view in the storyboard – we're going to create it ourself in `viewDidLoad()` using an initializer that takes a `UIImage` and makes the image view the correct size for the image.
>
>Add this code to `viewDidLoad()`:

```swift
imageView = UIImageView(image: UIImage(named: "penguin"))
imageView.center = CGPoint(x: 512, y: 384)
view.addSubview(imageView)
```

>That places the penguin in the middle of an iPad-sized landscape screen, ready for us to animate.
>
>There's one more thing we're going to do before we start looking at the animations, and that's to put a little bit of code into the `tapped()` method so that we cycle through animations each time the button is tapped. Put this in there:

```swift
currentAnimation += 1

if currentAnimation > 7 {
    currentAnimation = 0
}
```

>That will add 1 to the value of `currentAnimation` until it reaches 7, at which point it will set it back to 0.

:white_check_mark: compeleted and committed

## :three:  [Switch, case, animate, animate(withDuration:)](https://www.hackingwithswift.com/read/15/3/switch-case-animate-animatewithduration) 

>The `currentAnimation` property can have _a value between 0 and 7_, each one triggering a different animation. 
>* We're going to create a big `switch/case` block inside `tapped()`, but we're going to start small and work our way up – the `default` case will handle any values we don't explicitly catch.
>
>This switch/case statement is going to go inside a new method of the `UIView` class called `animate(withDuration:)`, which is a kind of method you haven't seen before because it actually accepts two closures. The parameters we'll be using are how long to animate for, how long to pause before the animation starts, any options you want to provide, what animations to execute, and finally a closure that will execute when the animation finishes.
>
>Update your `tapped()` method to this:

```swift
@IBAction func tapped(_ sender: UIButton) {
    sender.isHidden = true

    UIView.animate(withDuration: 1, delay: 0, options: [],
       animations: {
        switch self.currentAnimation {
        case 0:
            break

        default:
            break
        }
    }) { finished in
        sender.isHidden = false
    }

    currentAnimation += 1

    if currentAnimation > 7 {
        currentAnimation = 0
    }
}
```

>Note: Because we want to show and hide the “Tap” button, we need to make the `sender` parameter to that method be a `UIButton` rather than `Any`.
>
>All that code won't do anything yet, which is remarkable given that it's quite a lot! However, it has put us in a position where we can start dabbling with animations. But first, here's a breakdown of the code:
>
>* When the method begins, we hide the `sender` button so that our animations don't collide; it gets unhidden in the completion closure of the animation.
>
>* We call `animate(withDuration:)` with a duration of 1 second, no delay, and no interesting options.
>
>* For the `animations` closure _we don’t need to use `[weak self]` because there’s **no risk of strong reference cycles**_ here – the closures passed to `animate(withDuration:)` method **will be used once then thrown away.**
>
>* We switch using the value of `self.currentAnimation`. We need to use `self` to make the **closure capture** clear, remember. This `switch/case` does nothing yet, because both possible cases just call `break`.
>
>* We use **trailing closure** syntax to provide our completion closure. This will be called when the animation completes, and its `finished` value will be true if the animations completed fully.
>
>* As I said, the completion closure unhides the `sender` button so it can be tapped again.
>
>* After the `animate(withDuration:)` call, we have the old code to modify and wrap `currentAnimation`.
>
>If you run the app now and tap the button, you'll notice it doesn't actually hide and show as you might expect. This is because UIKit detects that no animation has taken place, so it calls the completion closure straight away.

:white_check_mark: Yup, no animation so no hiding, just the cases are established with the cases.

## :four:  [Transform CGAffineTransform](https://www.hackingwithswift.com/read/15/4/transform-cgaffinetransform) 
