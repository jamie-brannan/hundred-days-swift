# *Day 63 • Thursday June 10, 2021*

>When you follow this course you are, in a way, following in my footsteps. I lay out a path for you to follow, showing you how to make a variety of apps and games, and give you tips and advice to help you stay on track.
>
>But every couple of days comes a day like this one – a day where there is no track laid down by me, and it’s down to you to go through my review questions and complete the challenges all by yourself.
>
>These days are really important. As Mahatma Gandhi said, “An ounce of practice is worth more than tons of preaching.” Well, it’s time for the preaching to stop and for your practice to begin!
>
>**Today you should work through the wrap up chapter for project 17, complete its review, then work through all three of its challenges.**

## :one:  [Wrap up](https://www.hackingwithswift.com/read/17/5/wrap-up) 

>That's it! We just made a game in 20 minutes or so, which shows you just how fast SpriteKit is. I even showed you how per-pixel collision detection works (it's so easy!), how to advance particle systems so they start life with some history behind them, how to run code repeatedly using Timer, and how to adjust linear and angular damping so that objects don't slow down over time.

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
>  - [x]  Stop the player from cheating by lifting their finger and tapping elsewhere – try implementing `touchesEnded()` to make it work.

* created a `gameOver` function
* edited the `didBegin` and `touchesEnded` functions

>  - [ ]  Make the timer start at one second, but then after 20 enemies have been made subtract 0.1 seconds from it so it’s triggered every 0.9 seconds. After making 20 more, subtract another 0.1, and so on. Note: you should call `invalidate()` on `gameTimer` before giving it a new value, otherwise you end up with multiple timers.
  
>  - [ ]  Stop creating space debris after the player has died.


## :two:  [Review for Project Space Race](https://www.hackingwithswift.com/review/hws/project-17-space-race) 

### :boom: Quiz insights

* Swift has two property observers: willSet and didSet.
  * willSet is triggered before a property changes, and didSet is triggered after.
* SKLabelNode can draw any fonts available to our game.
  * If UIFont can read it, SKLabelNode can too.
* We can create an SKSpriteNode from a texture, from an image name, or from a color.
  * All three initializers are useful.
* Creating a new SKEmitterNode from a filename returns an optional.
  * You can unwrap it safely or unsafely depending on how confident you are.
* t's possible to copy a SpriteKit particle file from one project to another.
  * You can take your SKS file and associated texture file and re-use it anywhere you want.
* touchesMoved() is called when an existing touch changes position.
* SpriteKit can create pixel-perfect collision detection by examining the pixels in a sprite's texture.
  * This is the easiest way of getting collision data for important shapes.
* SpriteKit positions objects from their center by default.
  * You can adjust the anchor point if you want something different.
* The velocity property of a physics body controls how fast it's moving in a particular direction
  * It's provided as a CGVector.
* Particle emitters start with no particles when they are created.
  * Calling advanceSimulationTime() helps us create initial particles to fill the screen.
* Any time we use #selector to call a method, we must mark that method as @objc.
  * @objc makes a Swift method available to Objective-C code.
* The Timer class lets us run code after some time has elapsed, either once or repeatedly.
  * It's the most common way to run code repeatedly.
* The update() method is called once every frame, and lets us make changes to our game.
  * Try not to do too much work, because it can slow your game down.

