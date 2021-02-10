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
    - [Background](#background)
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

>The first thing you should do is run your game and see what a default SpriteKit template game looks like. You should see a large gray window saying "Hello, World!", and when you tap two spinning boxes should appear. In the bottom right is **a node count** (how many things are on screen right now) and a frame rate. You're aiming for 60 frames per second all the time, if possible.

So a **node** is just "a thing on the screen right now" ?

Ooo there's cool touch animation things that appear too.

>From the project navigator please find and open `GameScene.swift`, and replace its entire contents with this:

```swift
import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
```

>That removes almost all the code, because it’s just not needed.

:white_check_mark: Done. There's no more touch animations.

>
>SpriteKit’s equivalent of Interface Builder is called the **Scene Editor**, and it’s where that big “Hello World” label is. Select `GameScene.sks` to open the scene editor now, then click on the “Hello World” label and delete it.

Whaaaat. This is giving me flashbacks to After Effects!

>While you’re in the scene editor, there’s one more change I’d like to make, and it will help simplify our positioning slightly. With the scene selected, look in the attributes inspector (note: its icon is different here!) for Anchor Point. This determines what coordinates **SpriteKit uses to position children and it’s X:0.5 Y:0.5 by default.**
>
>**This is different to UIKit: it means “position me based on my center”, whereas UIKit positions things based on their top-left corner.**

This is a major difference.

>This is usually fine, but when working with the main scene it’s easiest to set this value to X:0 Y:0. So, please make that change now – anchor point should 0 for both X and Y.
>
>Note: SpriteKit considers Y:0 to be the bottom of the screen whereas UIKit considers it to be the top – hurray for uniformity!
>
>I’d also like you to change the size of the scene, which is just above the anchor point. This is probably 750x1334 by default; please **change it to 1024x768 to match iPad landscape size**.

Noted.

>Tip: The 9.7-inch iPad is 1024 points wide and 768 high, but the 10.5-inch and 12.9-inch are both larger. Helpfully, SpriteKit takes care of this for us: we just asked for a 1024x768 canvas and it will give us one regardless of what device our game runs on – nice!
>
>The last change I’d like you to make is to select `Actions.sks` and tap your backspace button to delete it – select “Move to Trash” when Xcode asks you what you want to do.

:white_check_mark: Okay thrown out.

>All these changes have effectively cleaned the project, resetting it back to a vanilla state that we can build on.
>
>With the template stuff deleted, **I'd like you to import the assets for the project**. If you haven't already downloaded the code for this project, please do so now. You should copy the entire Content folder from the example project into your own, making sure the "Copy items if needed" box is checked.

:white_check_mark: Done, copied.

### Background

>Let's kick off this project by ditching the plain background and replacing it with a picture. If you want to place an image in your game, the class to use is called SKSpriteNode, and it can load any picture from your app bundle just like UIImage.
>
>To place a background image, we need to load the file called background.jpg, then position it in the center of the screen. Remember, unlike UIKit SpriteKit positions things based on their center – i.e., the point 0,0 refers to the horizontal and vertical center of a node. And also unlike UIKit, SpriteKit's Y axis starts at the bottom edge, so a higher Y number places a node higher on the screen. So, to place the background image in the center of a landscape iPad, we need to place it at the position X:512, Y:384.
>
>We're going to do two more things, both of which are only needed for this background. First, we're going to give it the blend mode .replace. Blend modes determine how a node is drawn, and SpriteKit gives you many options. The .replace option means "just draw it, ignoring any alpha values," which makes it fast for things without gaps such as our background. We're also going to give the background a zPosition of -1, which in our game means "draw this behind everything else."
>
>To add any node to the current screen, you use the addChild() method. As you might expect, SpriteKit doesn't use UIViewController like our UIKit apps have done. Yes, there is a view controller in your project, but it's there to host your SpriteKit game. The equivalent of screens in SpriteKit are called scenes.
>
>When you add a node to your scene, it becomes part of the node tree. Using addChild() you can add nodes to other nodes to make a more complicated tree, but in this game we're going to keep it simple.
>
>Add this code to the didMove(to:) method, which is sort of the equivalent of SpriteKit's viewDidLoad() method:

```swift
let background = SKSpriteNode(imageNamed: "background.jpg")
background.position = CGPoint(x: 512, y: 384)
background.blendMode = .replace
background.zPosition = -1
addChild(background)
```

>If you run the app now you'll see a dark blue image for the background rather than plain gray – hardly a massive improvement, but this is just the beginning.

(:camera: screen shot on website)

:white_check_mark: Added background.

>Let's do something a bit more interesting, so add this to the touchesBegan() method:

```swift
if let touch = touches.first {
    let location = touch.location(in: self)
    let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
    box.position = location
    addChild(box)
}
```

>We haven't used touchesBegan() before, so the first two lines needs to be explained. This method gets called (in UIKit and SpriteKit) whenever someone starts touching their device. It's possible they started touching with multiple fingers at the same time, so we get passed a new data type called Set. This is just like an array, except each object can appear only once.
>
>We want to know where the screen was touched, so we use a conditional typecast plus if let to pull out any of the screen touches from the touches set, then use its location(in:) method to find out where the screen was touched in relation to self - i.e., the game scene. UITouch is a UIKit class that is also used in SpriteKit, and provides information about a touch such as its position and when it happened.
>
>The third line is also new, but it's still SKSpriteNode. We're just writing some example code for now, so this line generates a node filled with a color (red) at a size (64x64). The CGSize struct is new, but also simple: it just holds a width and a height in a single structure.
>
>The code sets the new box's position to be where the tap happened, then adds it to the scene. No more talk: press Cmd+R to make sure this all works, then tap around the screen to make boxes appear.
>
>OK, I admit: that's still quite boring. Let's make it even more interesting – are you ready to see quite how powerful SpriteKit is? Just before setting the position of our new box, add this line:

```swift
box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
```

And just before the end of didMove(to:), add this:

```swift
physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
```

>The first line of code adds a physics body to the box that is a rectangle of the same size as the box. The second line of code adds a physics body to the whole scene that is a line on each edge, effectively acting like a container for the scene.
>
>If you run the scene now, I hope you can't help but be impressed: you can tap on the screen to create boxes, but now they'll fall to the ground and bounce off. They'll also stack up as you tap more often, and fall over realistically if your aim isn't spot on.
>
>This is the power of SpriteKit: it's so fast and easy to make games that there really is nothing holding you back. But we're just getting warmed up!

Love this!!! :green_heart:

## :three:  [Bouncing Balls: circleOfRadius](https://www.hackingwithswift.com/read/11/3/bouncing-balls-circleofradius) 

>You're not going to get rich out of red rectangles, so let's use balls instead. Take the box code out (everything after `let location =` in `touchesBegan()`) and replace it with this instead:

```swift
let ball = SKSpriteNode(imageNamed: "ballRed")
ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
ball.physicsBody?.restitution = 0.4
ball.position = location
addChild(ball)
```

> There are two new things there. First, we're using the `circleOfRadius` initializer for `SKPhysicsBody` to add circular physics to this ball, because using rectangles would look strange. Second, we're giving the ball's physics body a restitution (bounciness) level of 0.4, where values are from 0 to 1.
> 
> **Note**: the physics body of a node is optional, because it might not exist. We know it exists because we just created it, so it’s not uncommon to see `physicsBody!` to force unwrap the optional.
> 
> When you run the game now, you'll be able to tap on the screen to drop bouncy balls. It's fractionally more interesting, but let's face it: this is still a dreadful game.

:white_check_mark: Now have asset ball.

> To make it more exciting we're going to add something for the balls to bounce off. In the Content folder I provided you with is a picture called "bouncer.png", so we're going to place that in the game now.
> 
> Just before the end of the `didMove(to:)` method, add this:

```swift
let bouncer = SKSpriteNode(imageNamed: "bouncer")
bouncer.position = CGPoint(x: 512, y: 0)
bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
bouncer.physicsBody?.isDynamic = false
addChild(bouncer)
```

```swift
  func setupBouncer() {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = CGPoint(x: 512, y: 0)
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
    bouncer.physicsBody?.isDynamic = false
    addChild(bouncer)
  }
```


>There's **a new data type** in there called `CGPoint`, but, like `CGSize`, it's very simple:_ it just holds X/Y co-ordinates_. Remember, SpriteKit's positions start from the center of nodes, so X:512 Y:0 means "centered horizontally on the bottom edge of the scene."
>
>Also new is the `isDynamic` property of a physics body. When this is true, the object will be moved by the physics simulator based on gravity and collisions. When it's false (as we're setting it) the object will still collide with other things, but it won't ever be moved as a result.
>
>Using this code, the bouncer node will be placed on the screen and your balls can collide with it – but it won't move. Give it a try now.
>
>Adding a bouncer took five lines of code, but our game needs more than one bouncer. In fact, I want five of them, evenly distributed across the screen. Now, you could just copy and paste the code five times then change the positions, but I hope you realize there's a better way: creating a method that does all the work, then calling that method each time we want a bouncer.
>
>The method code itself is nearly identical to what you just wrote, with the only change being that we need to position the box at the `CGPoint` specified as a parameter:

```swift
func makeBouncer(at position: CGPoint) {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = position
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
    bouncer.physicsBody?.isDynamic = false
    addChild(bouncer)
}
```

>With that method in place, you can place a bouncer in one line of code: just call `makeBouncer(at:)` with a position, and it will be placed and given a non-dynamic physics body automatically.
>
>You might have noticed that the parameter to `makeBouncer(at:)` has two names: `at` and `position`. This isn’t required, but it makes your code more readable: the first name is the one you use when calling the method, and the second name is the one you use inside the method. That is, you write `makeBouncer(at:)` to call it, but inside the method the parameter is named `position` rather than `at`. This is identical to `cellForRowAt` `indexPath` in table views.
>
>To show this off, delete the bouncer code from `didMove(to:)`, and replace it with this:

```swift
makeBouncer(at: CGPoint(x: 0, y: 0))
makeBouncer(at: CGPoint(x: 256, y: 0))
makeBouncer(at: CGPoint(x: 512, y: 0))
makeBouncer(at: CGPoint(x: 768, y: 0))
makeBouncer(at: CGPoint(x: 1024, y: 0))
```

>If you run the game now you'll see five bouncers evenly spread across the screen, and the balls you drop bounce off any of them. It's still not a game, but we're getting there. Now to add something between the bouncers…