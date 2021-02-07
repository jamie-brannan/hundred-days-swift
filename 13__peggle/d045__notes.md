# *Day 45 • Sunday February 07, 2021*

>It’s time for another game project, but this time we’ll be doing something quite different: we won’t be using UIKit. Instead we’ll be using **SpriteKit**, which is Apple’s high-performance drawing toolkit that lets us build advanced 2D games with relative ease.

Yesss, awesome. Besides playing with ARKit at school, this is my first time moving away from UIKit centric basics.

>On one hand this means you’ll be learning a whole load of useful new skills, such as how to _detect touches_, how to _add physics_, and _more_. On the other hand, it can feel a bit disconcerting at first, because most of the UIKit knowledge you’ve accrued so far won’t come in use – you need to learn to adapt to the SpriteKit way of working.
>
>This is where it becomes more important than ever to work hard. Here’s a quote from Michael Jordan, who knows more than his far share both about the importance of games and also the importance of hard work in the face of adversity:
>
>>“I’ve missed more than 9000 shots in my career. I've lost almost 300 games. 26 times, I've been trusted to take the game winning shot and missed. I've failed over and over and over again in my life. And that is why I succeed.”
>
>**Success is something you need to fight for.** Hopefully today will feel more like fun than fighting, but don’t be surprised if you come back to project 12 with a fresh interest in getting back to UIKit!

:muscle: Let's do this.

>**Today you have three topics to work through, and you’ll learn about `SKSpriteNode`, `SKPhysicsBody`, and more.**

- [*Day 45 • Sunday February 07, 2021*](#day-45--sunday-february-07-2021)
  - [:one:  Setting up](#one--setting-up)
  - [:two:  Falling boxes: `SKSpriteNode`, `UITouch`, and `SKPhysicsBody`](#two--falling-boxes-skspritenode-uitouch-and-skphysicsbody)
  - [:three:  Bouncing Balls: circleOfRadius](#three--bouncing-balls-circleofradius)

## :one:  [Setting up](https://www.hackingwithswift.com/read/11/1/setting-up) 

>This project is going to feel like a bit of a reset for you, because we're going to go back to basics. This isn't because I like repeating myself, but instead because you're going to learn a wholly new technology called SpriteKit.
>
>So far, everything you've made has been based on UIKit, Apple's user interface toolkit for iOS. We've made several games with it, and it really is very powerful, but even UIKit has its limits – and 2D games aren't its strong suit.
>
>A much better solution is called SpriteKit, and it's Apple's fast and easy toolkit designed specifically for 2D games. It includes sprites, fonts, physics, particle effects and more, and it's built into every iOS device. What's not to like?
>
>So, this is going to be a long tutorial because you're going to learn an awful lot. To help keep you sane, I've tried to make the project as iterative as possible. That means we'll make a small change and discuss the results, then make another small change and discuss the results, until the project is finished.
>
>And what are we building? **Well, we're going to produce a game similar to pachinko, although a lot of people know it by the name "Peggle."** To get started, create a new project in Xcode and choose Game. Name it Project11, set its Game Technology to be SpriteKit, then make sure all the checkboxes are deselected before saving it somewhere.
>
>Before we start, please configure your project so that it runs only for iPads in landscape mode.
>
>Warning: When working with SpriteKit projects, I strongly recommend you use a real device for testing your projects because the iPad simulator is extraordinarily slow for games. If you don’t have a device, please choose the lowest-spec iPad simulator available to you instead, but be prepared for dreadful performance that is not at all indicative of a real device.

## :two:  [Falling boxes: `SKSpriteNode`, `UITouch`, and `SKPhysicsBody`](https://www.hackingwithswift.com/read/11/2/falling-boxes-skspritenode-uitouch-skphysicsbody) 

## :three:  [Bouncing Balls: circleOfRadius](https://www.hackingwithswift.com/read/11/3/bouncing-balls-circleofradius) 

