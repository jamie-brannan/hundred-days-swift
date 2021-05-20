# *Day 59 • Monday May 17, 20 2021*

>I don’t know what you’ll go on to do once you reach the end of these 100 days. Maybe you’ll go on to make your own games, maybe you’ll join a company that specializes in Core Image work, or maybe you’ll create your own app that uses collection views and animations to build something new.
>
>This uncertainty is part of why the 100 days curriculum is so varied – I try to cover a little bit of everything so you’re able to say you have some experience no matter where you end up working.
>
>But the main reason we cover so much ground is because **I want to inspire in you a desire to keep learning about iOS**, because it’s a marvelously powerful ecosystem where so many extraordinary frameworks lie at our fingertips it can be hard to know where to start. As Anthony J. D'Angelo once said, “develop a passion for learning – if you do, you will never cease to grow.”

:rocket: Definitely feel I'm on that track.

>Today we’re going to be reviewing what has been covered in projects 13, 14, and 15, and you’ll also be faced with a fresh challenge to _write a new app from scratch_. While you tackle it, please keep in your head that passion for learning, because you’re growing as a developer all the time.
>
>**Today you have three topics to work through, one of which of is your challenge.**

- [*Day 59 • Monday May 17, 20 2021*](#day-59--monday-may-17-20-2021)
  - [:one:  What you learned](#one--what-you-learned)
  - [:two:  Key points](#two--key-points)
  - [:three:  Challenge](#three--challenge)

>Note: Don’t worry if you don’t complete challenges in the day they were assigned – in future days you’ll find you have some time to spare here and there, so challenges are something you can return back to in the future.

## :one:  [What you learned](https://www.hackingwithswift.com/guide/6/1/what-you-learned) 

>Project 13 was a trivial application if you look solely at the amount of code we had to write, but it’s remarkable behind the scenes thanks to the power of Core Images. Modern iPhones have extraordinary CPU and GPU hardware, and Core Image uses them both to the full so that advanced image transformations can happen in real time – if you didn’t try project 13 on a real device, you really ought to if only to marvel at how incredibly fast it is!
>
>You also met `UIKit`’s animation framework for the first time, which is a _wrapper_ on top of another of Apple’s cornerstone frameworks: Core Animation. 

Had to check what the definition of wrapper is here.

>This is a particularly useful framework to get familiar with because of its simplicity: you tell it what you want (“move this view to position X/Y”) then tell it a duration (“move it over three seconds”), and Core Animation figures out what each individual frame looks like.
>
>Here are just some of the other things you’ve now learned:
>
>* How to let the user select from a range of values using `UISlider`.
>
>* How to move, rotate, and scale views using `CGAffineTransform`.
>
>* Saving images back to the user’s photo library by calling the `UIImageWriteToSavedPhotosAlbum()` function.
>
>* Create Core Image contexts using `CIContext`, and creating then applying Core Image filters using `CIFilter`.
>
>* Changing sprite images without moving the sprite, using `SKTexture`.
>
>* Cropping a sprite so that only part of it is visible, using `SKCropNode`.
>
>* More `SKActions`, including `moveBy(x:y:)`, `wait(forDuration:)`, `sequence()`, and even how to run custom closures using `run(block:)`.
>
>* The `asyncAfter()` method of GCD, which causes code to be run after a delay.
>
>* Plus you had more practice using `UIImagePickerController`, to select pictures from the user’s photo library. We’ll be using this again – it’s a really helpful component to have in your arsenal!

## :two:  [Key points](https://www.hackingwithswift.com/guide/6/2/key-points) 

>There are three pieces of code I’d like to revisit briefly, just to make sure you understand them fully.
>
>First, I want to look more closely at how closure capturing works with `asyncAfter()`. Here’s some code as an example:

```swift
DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
    self.doStuff()
}
```
>The call to `asyncAfter()` needs two parameters, but we pass the second one in using _trailing closure syntax_ because it’s clearer. 
>
>The first parameter is specified as a _DispatchTime_ value, which is the exact time to execute the code. 
>* When we specify `.now()`, Swift is smart enough to realize that means `DispatchTime.now()`, which is the current time. It then lets us add 1 second to it, so that the finished deadline ends up being one second away from now.
>
>Then there’s the `[unowned self]`. This is called a **capture list**, and it gives Swift instructions how to handle values that get used inside the closure. In this case, `self.doStuff()` references self, so the capture list `[unowned self]` means _“I know you want to capture self strongly so that it can be used later, but I want you not to have any ownership at all.”_

I still cannot picture what *capture* or *ownership* looks like :thinking:

>If the closure runs and `self` has become `nil` for some reason, the call to `self.doStuff()` will crash: _we told Swift not to worry about ownership, then accidentally let self get destroyed, so the crash is our own fault._ 
>
>As an alternative, we could have written `[weak self]`, which would capture self in the closure as an optional. With that change, you’d need to run this code instead:

```swift
self?.doStuff()
```
>Closure capturing can be a complicated topic. In this case, `[unowned self]` isn’t really even needed because there’s no chance of a _reference cycle_: `self` doesn’t own `DispatchQueue.main`, so the reference will be destroyed once the closure finishes. However, there’s no harm adding `[weak self]`, which is why I often include it.
>
>The second piece of code I’d like to review is this, taken from project 15:

```swift
UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
    switch self.currentAnimation {
    case 0:
        break

    default:
        break
    }
}) { finished in
    sender.isHidden = false
}
```
>At this point in your Swift career you’ve seen several functions that accept closures, but this one takes two: one is _a set of animations to perform_, and one is _a set of actions to run when the animations have completed_. 
>* **I didn’t include closure capturing here because it isn’t needed – the animation closure will be used once then destroyed.**

This is something I remember being encouraged to do in school from the start, but have a hard time thinking of when to actually implement it myself.

>I don’t want to sound like a broken record, but: if you use `[weak self]` when it isn’t needed, nothing happens. But _if you don’t use it and it was needed, bad things will happen - at the very least you’ll leak memory_.
>
>The final piece of code to review is this, also taken from project 15:

```swift
self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
self.imageView.transform = CGAffineTransform.identity
```
>There are a few things in there that I’d like to recap just briefly:
>
> 1. The `self` is required when accessing `imageView`, because we’re _inside a closure and Swift wants us to explicitly acknowledge we recognize `self` will be captured._
>
> 2. The `CGFloat.pi` constant is equal to 180 degrees, and it also has equivalents in `Float.pi` and `Double.pi` – this is just to save you having to typecast values.
>
> 3. The identity matrix, `CGAffineTransform.identity`, has no transformations: it’s not scaled, moved, or rotated, and _it’s useful for resetting a transform_.

## :three:  [Challenge](https://www.hackingwithswift.com/guide/6/3/challenge) 

>Your challenge is to make an app that contains facts about countries: show a list of country names in a table view, then when one is tapped bring in a new screen that contains its capital city, size, population, currency, and any other facts that interest you. The type of facts you include is down to you – Wikipedia has a huge selection to choose from.
>
>To make this app, I would recommend you blend parts of project 1 project 7. 
>* That means showing **the country names in a table view**, 
>* then **showing the detailed information in a second table view**.
>
>**How you load data into the app** is going to be an interesting problem for you to solve.
>
> I suggested project 7 above because a sensible approach would be to create **a JSON file** with your facts in, then load that in using `contentsOf` and parse it using `Codable`. 
> Regardless of how you end up solving this, I suggest you don’t just hard-code it into the app – i.e., _typing all the facts manually_ into your Swift code. You’re better than that!


Project 1 :arrow_right: **Photo Viewer** from day ~20

Project 7 :arrow_right: **White House API Viewer** from day ~20

No API then? Just a local JSON? ~~Maybe I can find one...~~ more hassle than its worth and not neccesarily what'll endure over time, if a service ends.


>Go ahead and try coding it now. If you hit problems, here are some hints:
>
>   - [ ]  You should create a custom `Country` struct that has _properties for each of the facts_ you have in your JSON file. You can then have a `[Country]` array in your view controller.

Full country name
* ~~abreviation – `String`~~
* motto – `String`
* ~~fouding – `Date` (yyyy)~~
* continent - `String`
* capital – `String`
* language – `String`
* population - `Int`
* government – `String`
* GDP – `Int`

Starting point to build up from :

```json
{
    "United States of America" : {
        "motto": "In God We Trust",
        "language": "English",
        "capital": "Washington D.C."
    },
    "France" : {
        "motto": "Liberté, égalité, fraternité",
        "language": "French",
        "capital": "Paris"
    }
}
```

  - [x]  copy v1 json (with two items) to project
  - [x]  create Country struct
  - [x]  create Countries struct
  - [x]  create storyboard of table view encapsulated in a navigation controller
  - [ ]  query v1 json locally upon opening the app.

 [Apple Developer, *Foundation > Archives and Serialization*](https://developer.apple.com/documentation/foundation/jsondecoder) : **JSONDecoder**, *An object that decodes instances of data type form JSON orjects*

:pushpin: [**Hacking With Swift**](https://www.hackingwithswift.com/example-code/system/how-to-decode-json-from-your-app-bundle-the-easy-way) : *How to decode JSON from your app bundle the easy way*
* this feels a bit over kill...

:pushpin: [**Hacking With Swift**](https://www.hackingwithswift.com/example-code/system/how-to-find-the-path-to-a-file-in-your-bundle) : *How to find the path to a file in your bundle*
>>Rather than try to figure out the layout of your bundle at runtime, the correct thing to do is call the `path(forResource:)` method if you’re looking for a string path, or `url(forResource:)` if you’re looking for a `URL`.

```swift
let stringPath = Bundle.main.path(forResource: "input", ofType: "txt")
```

So in this case it's going to be a path because we're within the bundle – then use `JSONDecoder().Decode(Countries.self, from: stringPath)`



>   - [ ]  When using a table view in your detail view controller, try setting the `numberOfLines` property of _the cell’s text label to be 0_. That ought to allow the cell to fill up to two lines of text by default.

:question: *This is done through storyboard normally, right?* 

>   - [ ]  Don’t forget all the little UI touches: adding **a disclosure indicator** to the countries table, adding titles to the navigation controller, and so on. You could even _add an action button_ to the **detail view that shares a fact** about the selected country.

:question: *What's a discolsure indictor in this context?* 
* I've never heard of it, but maybe it's in the video?

**Detail view**
  - [ ]  share page button
  - [ ]  navigation controller title