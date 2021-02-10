# *Day 46 • Wednesday February 10, 2021*

>“In the beginning there was nothing, which exploded.” That’s a quote from Terry Pratchett’s book Lords and Ladies, and gives us an inkling of just how complicated physics is in the real world.
>
>Fortunately, SpriteKit’s version of physics is much easier. You’ve already seen how it lets us create boxes and balls easily enough, but today we’re going to look at the way it reports collisions back to us so we can take action.
>
>This does mean learning a few new things, but I’ve tried to take a few shortcuts to lessen the learning curve. I’m not skipping them entirely, though: we’re going to return to concepts such as bitmasks in future days, because they are important.
>
>**Today you have three topics to work through, and you’ll learn about `SKAction`, `SKPhysicsContactDelegate`, `SKLabelNode`, and more.**

- [*Day 46 • Wednesday February 10, 2021*](#day-46--wednesday-february-10-2021)
  - [:one:  Spinning Slots `SKAction`](#one--spinning-slots-skaction)
    - [Good and bad slots](#good-and-bad-slots)
    - [Adding spin](#adding-spin)
  - [:two:  Collision detection `SKPhysicsContactDelegate`](#two--collision-detection-skphysicscontactdelegate)
  - [:three:  Scores on the board `SKLabelNode`](#three--scores-on-the-board-sklabelnode)

## :one:  [Spinning Slots `SKAction`](https://www.hackingwithswift.com/read/11/4/spinning-slots-skaction) 

>The purpose of the game will be to drop your balls in such a way that they land in good slots and not bad ones. We have bouncers in place, but we need to fill the gaps between them with something so the player knows where to aim.
>
>We'll be filling the gaps with two types of target slots: good ones (colored green) and bad ones (colored red). As with bouncers, we'll need to place a few of these, which means we need to make a method. This needs to load the slot base graphic, position it where we said, then add it to the scene, like this:

```swift
func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode

    if isGood {
        slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
    } else {
        slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
    }

    slotBase.position = position
    addChild(slotBase)
}

```

>Unlike `makeBouncer(at:)`, this method has a second parameter – whether the slot is good or not – and that affects which image gets loaded. But first, we need to call the new method, so add these lines just before the calls to `makeBouncer(at:)` in `didMove(to:)`:

```swift
makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
```

>The X positions are exactly between the bouncers, so if you run the game now you'll see bouncer / slot / bouncer / slot and so on.

### Good and bad slots

>One of the obvious-but-nice things about using methods to create the bouncers and slots is that if we want to change the way slots look we only need to change it in one place. For example, we can make the slot colors look more obvious by adding a glow image behind them:

```swift
func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode
    var slotGlow: SKSpriteNode

    if isGood {
        slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
        slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
    } else {
        slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
        slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
    }

    slotBase.position = position
    slotGlow.position = position

    addChild(slotBase)
    addChild(slotGlow)
}
```

>That basically doubles every line of code, changing "Base" to "Glow", but the end result is quite pleasing and it's clear now which slots are good and which are bad.
>
:white_check_mark: put in place.

>We could even make the slots spin slowly by using a new class called `SKAction`. 
>* SpriteKit actions are ridiculously powerful and we're going to do some great things with them in later projects, but for now we just want the glow to rotate very gently.
>
>Before we look at the code to make this happen, you need to learn a few things up front:
>
>* _Angles are specified in **radians**, not degrees_. This is true in UIKit too. **360 degrees is equal to the value of 2 x Pi – that is, the mathematical value π.** Therefore π radians is equal to 180 degrees.
>
>* Rather than have you try to memorize it, there is a built-in value of π called `CGFloat.pi`.
>
>* Yes `CGFloat` is yet another way of representing decimal numbers, just like `Double` and `Float`. Behind the scenes, `CGFloat` can be either a `Double` or a `Float` depending on the device your code runs on. Swift also has `Double.pi` and `Float.pi` for when you need it at different precisions.
>
>* When you create an action it will execute once. If you want it to run forever, you create another action to wrap the first using the `repeatForever()` method, then run that.

### Adding spin

>Our new code will rotate the node by 180 degrees (available as the constant `CGFloat.pi` or just `.pi`) over 10 seconds, repeating forever. Put this code just before the end of the `makeSlot(at:)` method:

```swift
let spin = SKAction.rotate(byAngle: .pi, duration: 10)
let spinForever = SKAction.repeatForever(spin)
slotGlow.run(spinForever)
```

>If you run the game now, you'll see that the glow spins around very gently. It's a simple effect, but it makes a big difference.

(:camera: screen shot on website)

:white_check_mark: Yay spint set!

:question: *So `SKAction` is a type of animation?*
* What would be the UIKit animation equivalent?


## :two:  [Collision detection `SKPhysicsContactDelegate`](https://www.hackingwithswift.com/read/11/5/collision-detection-skphysicscontactdelegate) 

>Just by adding a physics body to the balls and bouncers we already have some collision detection because the objects bounce off each other. But it's not being detected by us, which means we can't do anything about it.
>
>In this game, we want the player to win or lose depending on how many green or red slots they hit, so we need to make a few changes:
>
>* Add rectangle physics to our slots.
>* Name the slots so we know which is which, then name the balls too.
>* Make our scene the contact delegate of the physics world – this means, "tell us when contact occurs between two bodies."
>* Create a method that handles contacts and does something appropriate.
>
>The first step is easy enough: add these two lines just before you call `addChild()` for `slotBase`:

```swift
slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
slotBase.physicsBody?.isDynamic = false
```

>The slot base needs to be non-dynamic because we don't want it to move out of the way when a player ball hits.
>
>The second step is also easy, but bears some explanation. As with UIKit, it's easy enough to store a variable pointing at specific nodes in your scene for when you want to make something happen, and there are lots of times when that's the right solution.
>
>But for general use, Apple recommends assigning names to your nodes, then checking the name to see what node it is. We need to have three names in our code: good slots, bad slots and balls. This is really easy to do – just modify your `makeSlot(at:)` method so the `SKSpriteNode` creation looks like this:

```swift
if isGood {
    slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
    slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
    slotBase.name = "good"
} else {
    slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
    slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
    slotBase.name = "bad"
}
```

>Then add this to the code where you create the balls:

```swift
ball.name = "ball"
```

>We don't need to name the bouncers, because we don't actually care when their collisions happen.
>
>Now comes the tricky part, which is setting up our scene to be the contact delegate of the physics world. The initial change is easy: we just need to conform to the SKPhysicsContactDelegate protocol then assign the physics world's contactDelegate property to be our scene. But by default, you still won't get notified when things collide.
>
>What we need to do is change the contactTestBitMask property of our physics objects, which sets the contact notifications we want to receive. This needs to introduce a whole new concept – bitmasks – and really it doesn't matter at this point, so we're going to take a shortcut for now, then return to it in a later project.
>
>Let's set up all the contact delegates and bitmasks now. First, make your class conform to the SKPhysicsContactDelegate protocol by modifying its definition to this:

```swift
class GameScene: SKScene, SKPhysicsContactDelegate {
```

Then assign the current scene to be the physics world's contact delegate by putting this line of code in didMove(to:), just below where we set the scene's physics body:

```swift
physicsWorld.contactDelegate = self
```

>Now for our shortcut: we're going to tell all the ball nodes to set their contactTestBitMask property to be equal to their collisionBitMask. Two bitmasks, with confusingly similar names but quite different jobs.
>
>The collisionBitMask bitmask means "which nodes should I bump into?" By default, it's set to everything, which is why our ball are already hitting each other and the bouncers. The contactTestBitMask bitmask means "which collisions do you want to know about?" and by default it's set to nothing. So by setting contactTestBitMask to the value of collisionBitMask we're saying, "tell me about every collision."
>
>This isn't particularly efficient in complicated games, but it will make no difference at all in this current project. And, like I said, we'll return to this in a later project to explain more. Until then, add this line just before you set each ball's restitution property:

```swift
ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask           
```

>That’s the only change required for us to detect collisions, so now it's time to write the code that does the hard work.
>
>But first, a little explanation: when contact between two physics bodies occurs, we don't know what order it will come in. That is, did the ball hit the slot, did the slot hit the ball, or did both happen? I know this sounds like pointless philosophy, but it's important because we need to know which one is the ball!
>
>Before looking at the actual contact method, I want to look at two other methods first, because this is our ultimate goal. The first one, collisionBetween() will be called when a ball collides with something else. The second one, destroy() is going to be called when we're finished with the ball and want to get rid of it.
>
>Put these new methods into to your code:

```swift
func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
        destroy(ball: ball)
    } else if object.name == "bad" {
        destroy(ball: ball)
    }
}

func destroy(ball: SKNode) {
    ball.removeFromParent()
}
```

>The removeFromParent() method removes a node from your node tree. Or, in plain English, it removes the node from your game.
>
>You might look at that and think it's utterly redundant, because no matter what happens it's effectively the same as writing this:

```swift
func collisionBetween(ball: SKNode, object: SKNode) {
    ball.removeFromParent()
}
```

>But trust me on this: we're going to make these methods do more shortly, so get it right now and it will save refactoring later.
>
>With those two in place, our contact checking method almost writes itself. We'll get told which two bodies collided, and the contact method needs to determine which one is the ball so that it can call collisionBetween() with the correct parameters. This is as simple as checking the names of both properties to see which is the ball, so here's the new method to do contact checking:

```swift
func didBegin(_ contact: SKPhysicsContact) {
    if contact.bodyA.node?.name == "ball" {
        collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
    } else if contact.bodyB.node?.name == "ball" {
        collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
    }
}
```

>If you're particularly observant, you may have noticed that we don't have a special case in there for when both bodies are balls – i.e., if one ball collides with another. This is because our collisionBetween() method will ignore that particular case, because it triggers code only if the other node is named "good" or "bad".
>
>Run the game now and you'll start to see things coming together: you can drop balls on the bouncers and they will bounce, but if they touch one of the good or bad slots the balls will be destroyed. It works, but it's boring. Players want to score points so they feel like they achieved something, even if that "something" is just nudging up a number on a CPU.
>
>Before I move on, I want to return to my philosophical question from earlier: “did the ball hit the slot, did the slot hit the ball, or did both happen?” That last case won’t happen all the time, but it will happen sometimes, and it’s important to take it into account.
>
>If SpriteKit reports a collision twice – i.e. “ball hit slot and slot hit ball” – then we have a problem. Look at this line of code:

```swift
collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
```

>And now this line of code:

```swift
ball.removeFromParent()
```

>The first time that code runs, we force unwrap both nodes and remove the ball – so far so good. The second time that code runs (for the other half of the same collision), our problem strikes: we try to force unwrap something we already removed, and our game will crash.
>
>To solve this, we’re going to rewrite the didBegin() method to be clearer and safer: we’ll use guard to ensure both bodyA and bodyB have nodes attached. If either of them don’t then this is a ghost collision and we can bail out immediately.

```swift
func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }

    if nodeA.name == "ball" {
        collisionBetween(ball: nodeA, object: nodeB)
    } else if nodeB.name == "ball" {
        collisionBetween(ball: nodeB, object: nodeA)
    }
}
```

>It takes a little more explanation and a little more code, but the result is safer – and that’s always worth striving for!


## :three:  [Scores on the board `SKLabelNode`](https://www.hackingwithswift.com/read/11/6/scores-on-the-board-sklabelnode) 

>To make a score show on the screen we need to do two things: create a score integer that tracks the value itself, then create a new node type, SKLabelNode, that displays the value to players.
>
>The SKLabelNode class is somewhat similar to UILabel in that it has a text property, a font, a position, an alignment, and so on. Plus we can use Swift's string interpolation to set the text of the label easily, and we're even going to use the property observers you learned about in project 8 to make the label update itself when the score value changes.
>
>Declare these properties at the top of your class:

```swift
var scoreLabel: SKLabelNode!

var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```

>We're going to use the Chalkduster font, then align the label to the right and position it on the top-right edge of the scene. Put this code into your didMove(to:) method, just before the end:

```swift
scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
scoreLabel.text = "Score: 0"
scoreLabel.horizontalAlignmentMode = .right
scoreLabel.position = CGPoint(x: 980, y: 700)
addChild(scoreLabel)

```

>That places the label into the scene, and the property observer automatically updates the label as the score value changes. But it's not complete yet because we don't ever modify the player's score. Fortunately, we already have places in the collisionBetween() method where we can do exactly that, so modify the method to this:

```swift
func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
        destroy(ball: ball)
        score += 1
    } else if object.name == "bad" {
        destroy(ball: ball)
        score -= 1
    }
}
```

>The += and -= operators add or subtract one to the variable depending on whether a good or bad slot was struck. When we change the variable, the property observer will spot the change and update the label.
>
>We have a score, so that means players have the achievement they were craving, right? Well, no. Clearly all it takes to get a number even higher than Gangnam Style's YouTube views is to sit and tap at the top of the screen directly above a green slot.
>
>Let's add some actual challenge: we're going to let you place obstacles between the top of the scene and the slots at the bottom, so that players have to position their balls exactly correctly to bounce off things in the right ways.
>
>To make this work, we're going to add two more properties. The first one will hold a label that says either "Edit" or "Done", and one to hold a boolean that tracks whether we're in editing mode or not. Add these two alongside the score properties from earlier:

```swift
var editLabel: SKLabelNode!

var editingMode: Bool = false {
    didSet {
        if editingMode {
            editLabel.text = "Done"
        } else {
            editLabel.text = "Edit"
        }
    }
}
```

>Then add this to didMove(to:) to create the edit label in the top-left corner of the scene:

```swift
editLabel = SKLabelNode(fontNamed: "Chalkduster")
editLabel.text = "Edit"
editLabel.position = CGPoint(x: 80, y: 700)
addChild(editLabel)
```

>That's pretty much identical to creating the score label, so nothing to see here. We're using a property observer again to automatically change the editing label's text when edit mode is changed.
>
>But what is new is detecting whether the user tapped the edit/done button or is trying to create a ball. To make this work, we're going to ask SpriteKit to give us a list of all the nodes at the point that was tapped, and check whether it contains our edit label. If it does, we'll flip the value of our editingMode boolean; if it doesn't, we want to execute the previous ball-creation code.
>
>We're going to insert this change just after let location = and before let ball =, i.e. right here:

```swift
let location = touch.location(in: self)
// new code to go here!
let ball = SKSpriteNode(imageNamed: "ballRed")
```

>Change that to be:

```swift
let location = touch.location(in: self)

let objects = nodes(at: location)

if objects.contains(editLabel) {
    editingMode.toggle()
} else {
    let ball = SKSpriteNode(imageNamed: "ballRed")
    // rest of ball code
}
```

>Did you notice I slipped in a small but important new method there? editingMode.toggle() changes editingMode to true if it’s currently false, and to false if it was true. We could have written editingMode = !editingMode there and it would do the same thing, but toggle() is both shorter and clearer. That change will be picked up by the property observer, and the label will be updated to reflect the change.
>
>Obviously the // rest of ball code comment is where the rest of the ball-creating code goes, but note that you need to add the new closing brace after you've created the ball, to close the else block.
>
>Now that we have a boolean telling us whether we're in editing mode or not, we're going to extend touchesBegan() even further so that if we're in editing mode we add blocks to the screen of random sizes, and if we're not it drops a ball.
>
>To get the structure right, this is what you want to have:

```swift
if objects.contains(editLabel) {
    editingMode.toggle()
} else {
    if editingMode {
        // create a box
    } else {
        // create a ball
    }
}
```

>The // create a ball comment is where your current ball creation code goes. The // create a box comment is what we're going to write in just a moment.
>
>First, we're going to use a new property on nodes called zRotation. When creating the background image, we gave it a Z position, which adjusts its depth on the screen, front to back. If you imagine sticking a skewer through the Z position – i.e., going directly into your screen – and through a node, then you can imagine Z rotation: it rotates a node on the screen as if it had been skewered straight through the screen.
>
>To create randomness we’re going to be using both Int.random(in:) for integer values and CGFloat.random(in:) for CGFloat values, with the latter being used to create random red, green, and blue values for a UIColor. So, replace the // create a box comment with this:

```swift
let size = CGSize(width: Int.random(in: 16...128), height: 16)
let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
box.zRotation = CGFloat.random(in: 0...3)
box.position = location

box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
box.physicsBody?.isDynamic = false

addChild(box)
```

>So, we create a size with a height of 16 and a width between 16 and 128, then create an SKSpriteNode with the random size we made along with a random color, then give the new box a random rotation and place it at the location that was tapped on the screen. For a physics body, it's just a rectangle, but we need to make it non-dynamic so the boxes don't move when hit.
>
>At this point, we almost have a game: you can tap Edit, place as many blocks as you want, then tap Done and try to score by dropping balls. It's not perfect because we don't force the Y position of new balls to be the top of the screen, but that's something you can fix yourself – how else would you learn, right?

(:camera: screen shot on website)