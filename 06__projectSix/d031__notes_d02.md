# *Day 31 (2) • Thursday November 05, 2020*

## :two:  [Auto Layout : Anchors](https://www.hackingwithswift.com/read/6/5/auto-layout-anchors) 

>You’ve seen how to create Auto Layout constraints both in **Interface Builder** and using **Visual Format Language**, but there’s one more option open to you and it’s often the best choice.

:pushpin: [**Apple Developper**](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html) : *Appendix, Visual Format Language*

:pushpin: [**Ray**](https://www.raywenderlich.com/277-auto-layout-visual-format-language-tutorial) : *Auto Layout Visual Format Languague Tutorial*

>Every `UIView` has a set of **anchors** that define its layouts rules. 
>* The most important ones are `widthAnchor`, `heightAnchor`, `topAnchor`, `bottomAnchor`, `leftAnchor`, `rightAnchor`, `leadingAnchor`, `trailingAnchor`, `centerXAnchor`, and `centerYAnchor`.
>
>Most of those should be self-explanatory, but it’s worth clarifying the difference between `leftAnchor`, `rightAnchor`, `leadingAnchor`, and `trailingAnchor`. 
>
>For me, _left and leading are the same_, and _right and trailing are the same too_. This is because my devices are set to use the English language, which is written and read left to right. 
>* However, for r**ight-to-left languages** such as Hebrew and Arabic, _leading and trailing flip around_ so that leading is equal to right, and trailing is equal to left.

:us: Yes! This is very true.

Therefore leading is the start of text being read, and trailing is the tail end of the trail. Where as right and left are always those "cardinal" positions.

>In practice, this means using `leadingAnchor` and `trailingAnchor` if you want your user interface to flip around for right to left languages, and `leftAnchor` and `rightAnchor` for things that should look the same no matter what environment.

:bulb: This would be super important to have set for localisation of apps :earth_americas:

>**The best bit about working with anchors is that they can be created relative to other anchors**. That is you can say “this label’s width anchor is equal to the width of its container,” or “this button’s top anchor is equal to the bottom anchor of this other button.”
>
>To demonstrate anchors, _comment out_ your existing **Auto Layout VFL** code and replace it with this:

```swift
for label in [label1, label2, label3, label4, label5] {
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 88).isActive = true
}
```

>That loops over each of the five labels, setting them to have the same width as our main view, and to have a height of exactly 88 points.

:white_check_mark: Ok, set.

> :anchor: We haven’t set top anchors, though, so the layout won’t look correct just yet. 
>
>What we want is for the top anchor for each label to be equal to the bottom anchor of the previous label in the loop. 
>
>Of course, the first time the loop goes around there is no previous label, so we can model that using optionals:

```swift
var previous: UILabel?
```

>The first time the loop goes around that will be nil, but then we’ll set it to the current item in the loop so the next label can refer to it. If previous is not nil, we’ll set a topAnchor constraint.
>
>Replace your existing Auto Layout anchors with this:

```swift
var previous: UILabel?

for label in [label1, label2, label3, label4, label5] {
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 88).isActive = true

    if let previous = previous {
        // we have a previous label – create a height constraint
        label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
    }

    // set the previous label to be the current one, for the next loop iteration
    previous = label
}
```

>That third anchor combines a different anchor with a constant value to get spacing between the views – these things are really flexible.

Which one is the "third anchor" in this? `topAnchor` ?

>Run the app now and you’ll see all the labels space themselves out neatly. I hope you’ll agree that anchors make Auto Layout code really simple to read and write!

Yup, looks nice.

>Anchors also let us control the **safe area** nicely. The “safe area” is _the space that’s actually visible inside the insets of the iPhone X and other such devices_ 
>* – with their rounded corners, notch and similar. 
>* It’s a space that excludes those areas, so labels no longer run underneath the notch or rounded corners.
>
>We can fix that using constraints. 
>
>In our current code we’re saying **“if we have a previous label, make the top anchor of this label equal to the bottom anchor of the previous label plus 10.”** 
>
>But if we add an else block we can push the first label away from the top of the safe area, so it doesn’t sit under the notch, like this:

```swift
if let previous = previous {
    // we have a previous label – create a height constraint
    label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
} else {
    // this is the first label
    label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
}
```

Yayyy this is nicer because it was bothering my to see the notch not be acknowledged.

>If you run that code now, you should see all five labels start below the notch in iPhone X-style devices.

:tada:

## :three:  [Wrap up](https://www.hackingwithswift.com/read/6/6/wrap-up) 

>There are two types of iOS developer in the world: those who use Auto Layout, and people who like wasting time. 

:boom: Damn, hot take.

>It has bit of a steep learning curve (and we didn't even use the hard way of adding constraints!), but it's **an extremely expressive way of creating great layouts** that adapt themselves automatically to whatever device they find themselves running on – now and in the future.
>
>Most people recommend you do as much as you can inside Interface Builder, and with good reason – you can drag lines about until you're happy, you get an instant preview of how it all looks, and it will warn you if there's a problem (and help you fix it.) 
>* But, as you've seen, **creating constraints** in code is remarkably easy thanks to the Visual Format language and anchors, so you might _find yourself mixing them all to get the best results._
>
>### [Review](https://www.hackingwithswift.com/review/hws/project-6-auto-layout) what you learned
>
>Anyone can sit through a tutorial, but it takes actual work to remember what was taught. It’s my job to make sure you take as much from these tutorials as possible, so I’ve prepared a short review to help you check your learning.

### :boom: Quiz insights

* Auto Layout lets us position one view relative to another.
  * This makes it a great way to handle different languages, because your layouts will adapt when given longer or shorter text.
* Visual Formatting Language metrics let us share sizes across views more easily.
  * Metrics let us define shared values that many views can use.
* Interface Builder will warn us if we try to create invalid or incomplete constraints
  * One of the **advantages** of creating constraints in Interface Builder is that it can identify and try to fix problematic constraints.
* Visual Formatting Language can create horizontal or vertical constraints.
  * VFL creates horizontal constraints using `H:` and vertical constraints using `V:`.
* The safe area layout guide automatically excludes rounded edges and any notch.
  * Important content in our apps should be inside the safe area to avoid problems.
* Each view has multiple Auto Layout anchors we can modify.
  * Many people find anchors the easiest way to make Auto Layout constraints.
* Visual Formatting Language can create multiple constraints at a time.
  * It returns an array of the constraints that were created.
* We can create Auto Layout anchors using constant values.
  * Constant values are commonly used for spacing and sizes.
* ~~You should set a view's `safeAreaAnchor` to make sure it stays inside the available screen space.~~
  * :red_circle: There is no such thing as `safeAreaAnchor`.
* Aspect Ratio constraints ensure the width and height of a view scale evenly.
  * This helps us make sure pictures don't get warped as layouts change.
* A pipe symbol in Visual Formatting Language means the edge of the parent view.
  * This allows you to make sure a view stays next to one or both sides of its parent.
* Required constraints have a priority of 1000 in VFL
* We can force our app to run only in specific orientations.
  * This is often the only option when faced with specific layout needs.

>### Challenge
>
>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:
>
>1) Try replacing the `widthAnchor` of our labels with `leadingAnchor` and `trailingAnchor` constraints, which more explicitly pin the label to the edges of its parent.

Yup, it's pinned to the edge of the leading review

>2) Once you’ve completed the first challenge, try using the `safeAreaLayoutGuide` for those constraints. You can see if this is working by rotating to landscape, because the labels won’t go under the safe area.
>
>3) Try making the height of your labels equal to 1/5th of the main view, minus 10 for the spacing. This is a hard one, but I’ve included hints below!

>### Hints
>
>It is vital to your learning that you try the challenges above yourself, and not just for a handful of minutes before you give up.
>
>Every time you try something wrong, you learn that it’s wrong and you’ll remember that it’s wrong. By the time you find the correct solution, you’ll remember it much more thoroughly, while also remembering a lot of the wrong turns you took.
>
>This is what I mean by “there is no learning without struggle”: if something comes easily to you, it can go just as easily. But when you have to really mentally fight for something, it will stick much longer.
>
>But if you’ve already worked hard at the challenges above and are still struggling to implement them, I’m going to write some hints below that should guide you to the correct answer.
>
>If you ignore me and read these hints without having spent at least 30 minutes trying the challenges above, the only person you’re cheating is yourself.
>
>Still here? OK. If you’re stuck on the last challenge, try looking at Xcode’s code completion options for the constraint() method. We’re using the equalToConstant option right now, but there are others – the equalTo option lets you specify another height anchor as its first parameter, along with a multiplier and a constant.
>
>When you use both a multiplier and a constant, the multiplier gets factored in first then the constant. So, if you wanted to make one view half the width of the main view plus 50, you might write something like this: