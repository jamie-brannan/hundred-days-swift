# *Day 74 • Friday December 24, 2021*

> In the last week your brain has been crammed full of important Swift and iOS skills. Don’t believe me? Here’s a list that’s not even complete: extensions, `NotificationCenter`, `UITextView`, color blending, shake gestures, for case let, reversing arrays, local notifications, and more – and that’s just in one week, while also building an app and a game!
>
> Of course, just learning something new isn’t enough – it’s important to put that learning into practice, not only so that it really starts to stick in your head, but also so that you can take another step towards your goal of being an app developer. After all, it’s fun learning and I hope you’ll carry on discovering great new things in iOS and Swift for years to come, but I hope you have a greater goal in mind.
>
> **Henry Petroski**, a professor of engineering at Duke University in the US, said _“as engineers, we’re going to be in a position to change the world, not just study it.”_ Now that the end of the 100 days challenge is almost in sight, how do you plan to change the world?
>
> Today you have three topics to work through, one of which of is your challenge.

- [*Day 74 • Friday December 24, 2021*](#day-74--friday-december-24-2021)
  - [:one: What you learned](#one-what-you-learned)
  - [:two: Key points](#two-key-points)
    - [Observers in iOS with NotificationCenter](#observers-in-ios-with-notificationcenter)
    - [Permissions](#permissions)
  - [:three: Challenge](#three-challenge)

## :one: [What you learned](https://www.hackingwithswift.com/guide/8/1/what-you-learned) 

> These three projects were a mixed bag in terms of difficulty: although **Safari extensions** are clearly a bit of a wart in Apple’s APIs, it’s still marvelous to be able to add features directly to one of the most important features in iOS. As for the **Fireworks Night project**, I hope it showed you it doesn’t take much in the way of graphics to make something fun!
> 
> You also learned about **local notifications**, which might seem trivial at first but actually open up a huge range of possibilities for your apps because you can prompt users to take action even when your app isn’t running.
> 
> The best example of this is the Duolingo app – it sets “You should practice your language!” reminders for 1 day, 2 days, and 3 days after the app was most recently launched. If you launch the app before the reminders appear, they just clear them and reset the timer so you never notice them.

Lol shout out to Duolingo

>Here’s a quick reminder of the things we covered:
> 
> * How to make extensions for Safari by connecting Swift code to JavaScript. Getting the connection working isn’t too easy, but once it’s set up you can send whatever you want between the two.

Bleh JS wasn't fun :( but it would be worth playing with in freetime and looking at books about it.

> * _Editing multi-line text using UITextView_. This is used by apps like Mail, Messages, and Notes, so you’ll definitely use it in your own apps.

This was a sneaky high user value component I hav enot gotten to use yet for sure. :)

> * You met Objective-C’s `NSDictionary` type. It’s not used much in Swift because you lose Swift’s strong typing, but it’s occasionally unavoidable.

I remember running into this within one of Zino's lessons but I didn't understand programmatically how valuable typing was just yet or what libraries really were. The kind of memories I'm treasuring recrossing by accident. :+1:

> * We used the iOS NotificationCenter center class to receive system messages. Specifically, we requested that a method be called when the keyboard was shown or hidden so that we can adjust the insets of our text view. We’ll be using this again in a later project, so you have ample chance for practice.

This was sweet cause it even made me rethink my behavior as a user.

> * The `follow()` `SKAction`, which causes a node to follow a bezier path that you specify. Use `orientToPath`: true to make the sprite rotate as it follows.

:heart_eyes_cat: Dying to play more with graphics once time opens up to structure a project

It was a bit of a hard left turn to jump back into SpriteKit though.

> * The `color` and `colorBlendFactor` properties for `SKSpriteNode`, which let you dynamically recolor your sprite.
> 
> * The `motionBegan()` method, which gets called on your view controllers when the user shakes their device.
> 
> * Swift’s for `case let` syntax for adding a condition to a loop.

This blew my mind at work when Haifa showed me.

> * The `UserNotifications` framework, which allows you to create notifications and attach them to triggers.

## :two: [Key points](https://www.hackingwithswift.com/guide/8/2/key-points)

### Observers in iOS with NotificationCenter

> There are three pieces of code I’d like to review, just to make sure you understand them fully.
> 
> The first thing I’d like to recap is `NotificationCenter`, which is a system-wide broadcasting framework that _lets you send and receive messages_. 
> 
> These messages come in two forms: 
> * messages that come from iOS, 
> * and messages you send yourself.

And to think I believed it was a misnommer in our project code way back.

>  Regardless of whether the messages come from, `NotificationCenter` is a good example of loose coupling – you don’t care who subscribes to receive your messages, or indeed if anyone at all does; you’re just responsible for posting them.

Computer Sciences Design pattern of an "observer" from what I've grown to understand

> In project 19 we used `NotificationCenter` so that iOS notified us _when the keyboard was shown or hidden_. This meant registering for the `Notification.Name.UIKeyboardWillChangeFrame` and `Notification.Name.UIKeyboardWillHide`: we told iOS we want to be notified when those events occurred, and asked it to execute our `adjustForKeyboard()` method. Here’s the code we used:

```swift
let notificationCenter = NotificationCenter.default
notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
```

Detecting local user behavior to trigger events in app.

> There are lots of these events – just try typing `Notification.Name`. and letting autocomplete show you what’s available. 

:bulb: This would be worth while to explore on my own

> For example, in project 28 we use the `Notification.Name.UIApplicationWillResignActive` event to _detect when the app moves to the background._
> 
> Like I said, it’s also possible to send your own notifications using `NotificationCenter`. _Their names are just strings, and only your application ever sees them, so you can go ahead and make as many as you like._ 
> * For example, to post a “UserLoggedIn” notification, you would write this:

```swift
let notificationCenter = NotificationCenter.default
notificationCenter.post(name: Notification.Name("UserLoggedIn"), object: nil)
```

> **If no other part of your app has subscribed to receive that notification, nothing will happen.** But you can make any other objects subscribe to that notification – it could be one thing, or ten things, it doesn’t matter. This is the essence of loose coupling: you’re transmitting the event to everyone, with no direct knowledge of who your receivers are.

The notion of "subscribers" in English has been missing from all other definitions or explainations I've had in French.

### Permissions

> The second piece of code I’d like to review is this, taken from project 21:

```swift
let center = UNUserNotificationCenter.current()

center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
    if granted {
        print("Yay!")
    } else {
        print("D'oh")
    }
}
```

> In that code, everything from `{ (granted, error) in` to the end is a **closure**: that code won’t get run straight away. Instead, it gets passed as the second parameter to the `requestAuthorization()` method, which stores the code. This is important – in fact essential – to the working of this code, because iOS needs to **ask the user for permission to show notifications**.
> 
> iPhones can do literally billions of things every second, so in the time it takes for the “Do you want to allow notifications” message to appear, then for the user to read it, consider it, then make a choice, the iPhone CPU has done countless other things.
> 
> _It would be a pretty poor experience if your app had to pause completely while the user was thinking, which is why closures are used: **you tell iOS what to do when the user has made a decision, but that code only gets called when that decision is finally made**._ As soon as you call `requestAuthorization()`, execution continues immediately on the very next line after it – iOS doesn’t stop while the user thinks. Instead, you sent the **closure** – _the code to run_ – to the notification center, and that’s what will get called when the user makes a choice.

This is a nice example of step by step usefulness of passing closures from one function to another.

> Finally, let’s take another look at for `case let` syntax. Its job is to perform some _sort of filtering on our data based on the result of a check_, which means inside the Swift loop the compiler has more information about the data it’s working with.
> 
> For example, if we wanted to loop over all the subviews of a UIView, we’d write this:

```swift
for subview in view.subviews {
    print("Found a subview with the tag: \(subview.tag)")
}
```

> All views have a tag, which is an identifying number we can use to distinguish between views in some specific circumstances.
> 
> However, what if wanted to find all the labels in our subviews and print out their text? We can’t print out the text above, because a regular UIView doesn’t have a text property, so we’d probably write something like this:

```swift
for subview in view.subviews {
    guard let label = subview as? UILabel else { continue }
    print("Found a label with the text: \(label.text)")
}
```

>That certainly works, but this is a case where for case let can do the same job in less code:

```swift
for case let label as UILabel in view.subviews {
    print("Found a label with text \(label.text)")
}
```

I'm not sure I've ever run into this in our case. This feels like a difficult thing to just think of "in the wild" programming without having run into it in different coding projects.

> **`for case let` can also do the job of checking optionals for a value.** If it finds a value inside it will unwrap it and provide that inside the loop; if there is no value that element will be skipped.

:bulb: Oh damn this is something I try to use actually.

> The syntax for this is a little curious, but I think you’ll appreciate its simplicity:

```swift
let names = ["Bill", nil, "Ted", nil]

for case let name? in names {
    print(name)
}
```

> In that code the names array will be inferred as `[String?]` because elements are either strings or `nil`. Using for case let there will skip the two nil values, and unwrap and print the two strings.

## :three: [Challenge](https://www.hackingwithswift.com/guide/8/3/challenge) 

> Have you ever heard the phrase, “imitation is the highest form of flattery”? I can’t think of anywhere it’s more true than on iOS: Apple sets an extremely high standard for apps, and encourages us all to follow suit by releasing a vast collection of powerful, flexible APIs to work with.
> 
> Your challenge for this milestone is to use those API to imitate Apple as closely as you can: **I’d like you to recreate the iOS Notes app.** 

Ouf, from which period? Cause It's gotten pretty complicated now.

> I suggest you follow the iPhone version, because it’s fairly simple: a navigation controller, a table view controller, and a detail view controller with a full-screen text view.
> 
> How much of the app you imitate is down to you, but I suggest you work through this list:
>
>  - [x]  Create a table view controller that lists notes. Place it inside a navigation controller. (Project 1)
>
>  - [x]  Tapping on a note should slide in a detail view controller that contains a full-screen text view. (Project 19)
>
>  - [x]  Notes should be loaded and saved using `Codable`. You can use `UserDefaults` if you want, or _write to a file_. (Project 12)
>
>  - [ ]  Add some _toolbar items_ to the detail view controller – **“delete”** and **“compose”** seem like good choices. (Project 4)
>
>  - [ ]  Add an **action button** to the navigation bar in the _detail view controller_ that shares the text using `UIActivityViewController`. (Project 3)

This actually overall feels really attainable.

Will need to do :
  - [x]  set new table view and entrypoint
  - [x]  create first mock data main view with table cell item
  - [x]  create detail view interface
  - [x]  push to detail view interface view table cell select
  - [x]  create data model for user defaults object
  - [x]  create UserDefaults writing and reading functions
  - [ ]  add share action to detail view navigation
  - [ ]  add toolbar items to detail view, delete
    - [ ]  add icon
    - [ ]  add action
  - [x]  add toolbar item to main view, compose
    - [x]  add icon
    - [x]  add actions
      - [x]  cancel
      - [x]  draft – push to a new detail with the title set and an empty body by default