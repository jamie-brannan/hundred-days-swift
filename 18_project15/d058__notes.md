# *Day 58 • Sunday May 16, 2021*

>I hope you can agree that animation in iOS is almost invisible – we just lay out all the changes we want to happen, and Core Animation figures out all the intermediate steps to make it happen.
>
>As I’ve said several times, animation is more than about making our software look good – it has a functional purpose too, ensuring that users understand why things and changing and what states they are moving from and to.
>
>Larry Niven once said, “that's the thing about people who think they hate computers – what they really hate is lousy programmers.” Folks paid a lot of money for their iPhones and iPads, and Apple’s software oozes polish and refinement – if you don’t put a similar level of care into your own code then your app will stick out, and not in a good way.
>
>So, with today’s challenges you need to apply your new animation knowledge to the projects you’ve made previously. I think you’ll be pleased how easy it is, and I hope also inspired to take on more animations in the future!
>
>Today you should work through the wrap up chapter for project 15, complete its review, then work through all three of its challenges.
>
>**That’s another project finished, and one that sets you up to use animation at will in the future – post some videos online to show folks your creations!**

## :one:  [Wrap up](https://www.hackingwithswift.com/read/15/5/wrap-up) 

>Core Animation is an extraordinary toolkit, and UIKit wraps it in a simple and flexible set of methods. And because it's so simple to use, you really have no excuse for not using it.
>
>In this project you learned about the `animate(withDuration:)` method of `UIView`, spring animations, as well as alpha values and `CGAffineTransform`.
>
>Remember, animation isn’t just there to make our apps look pretty – it also helps guide the users eyes. So, if you're moving something around conceptually (e.g., moving an email to a folder, showing a palette of paint brushes, rolling a dice, etc) then move it around visually too. Your users will thank you for it!

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
>   - [x]  Go back to project 8 and make the letter group buttons fade out when they are tapped. We were using the `isHidden` property, but you'll need to switch to alpha because `isHidden` is either true or false, it has no animatable values between.

**Swifty Words** project.

_"the letter group buttons fade out when they are tapped"_
* remove `isHidden` and swap it for alpha 3 or something.

```swift
  @objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else { return }
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
//    sender.isHidden = true
    UIView.animate(withDuration: 1, delay: 0, options: [], animations: { sender.alpha = 0.1 })
  }

  @objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""
    
    for btn in activatedButtons {
      //      btn.isHidden = false
      btn.alpha = 1
    }
    
    activatedButtons.removeAll()
  }
```

:white_check_mark: mission complete

>   - [x]  Go back to project 13 and make the image view fade in when a new picture is chosen. To make this work, set the `alpha` to 0 first.

**InstaFilter** project.

Specifically **when a new picture is chosen**, we have a fade in.
  - [x]  so review structure and identify the UIView that'll be animated
  - [x]  when does it need to have the alpha set `imageView.alpha = 0`
  - [x]  when does it need to have the alpha altered

>   - [ ]  Go back to project 2 and make the flags scale down with a little bounce when pressed.

  - [x]  `UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],` in the right spot
  - [x]  ...on the right element

```swift
  @IBAction func buttonTapped(_ sender: UIButton) {
    /// title of the alert card
    UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: [], animations: {
      sender.transform = CGAffineTransform(scaleX: 2, y: 2)
      sender.transform = .identity
    }) { finished in
      var resultTitle: String
      if sender.tag == self.correctAnswer {
        resultTitle = "Correct"
        self.score += 1
        self.roundAlert(title: resultTitle, countrySelected: sender.tag)
      } else {
        resultTitle = "Wrong"
        self.score -= 1
        self.roundAlert(title: resultTitle, countrySelected: sender.tag)
      }

      if self.round == 10 {
        self.finalScoreAlert()
      } else {
        return
      }
    }
  }
```

## :two:  [Review](https://www.hackingwithswift.com/review/hws/project-15-animation) 

### :boom: Quiz insights
* We can control the center of a view using its center property.
  * This is often the easiest way to move a view around the screen.
* We can add a delay to animations so they start after a few seconds.
  * This lets you time them as accurately as you need.
* When creating a scaling CGAffineTransform we can provide different X and Y values.
  * This lets us squash our views if needed.
* The break keyword exits the current loop or switch block.
  * If you label your statements you can also exit one particular scope.
* A scale transform of X:0.5 Y:0.5 makes a view 50% of its default size.
  * A scale of 1.0 makes a view 100% of its regular size, so 0.5 is indeed half.
* ~~Creating a 360-degree rotation will make a view spin in a complete circle.~~
  * Core Animation tries to compute the smallest move to make your rotation work, which in this case will do nothing.
* An alpha value of 1 means "fully visible".
  * Conversely, an alpha value of 0 means "fully invisible".
* The sender parameter tells us which UIKit control triggered a method.
  * This isn't required, but it's often useful.
* In UIKit, making a translation transform with a negative Y value moves it up the screen.
  * This is the opposite direction to SpriteKit.
* UIKit uses ease in, ease out animations by default.
  * This means your animation starts slowly, picks up speed, then decelerates towards the end.
* UIKit has a special clear color that is transparent.
  * It has an alpha value of zero, making it invisible.
* The identity transform resets views to their default size, position, and rotation.
  * It's the default value of a view's transform.
* Spring animations cause their values to overshoot and bounce.
  * iOS apps use these regularly, albeit usually with a very gentle spring effect.