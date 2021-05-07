# *Day 56 • Monday May 03, 2021*

>It’s the second day of the Whack-a-Penguin project, and you know what? It’s finished today – it took you just two days to make in full! I know you’ve had to work hard every day so far, but at the same time I hope you can look back and admire your own progress.
>
>Marie Curie, the only person in history to win the Nobel prize in two different sciences, once said, “I was taught that the way of progress was neither swift nor easy.” While your progress here is certainly Swift (sorry not sorry), I’m sure you’ll agree it’s not easy.
>
>And that’s OK. I’ve said more than once that there’s no learning without struggle, so if you find yourself struggling every day it’s a good sign that you’re learning too.
>
>**Today you should work through the “Whack to win” chapter and wrap up for project 14, complete its review, then work through all three of its challenges.**

## :one:  [Whack to Win : `SKAction` Sequences](https://www.hackingwithswift.com/read/14/4/whack-to-win-skaction-sequences) 

>To bring this project to a close, we still need to do two major components: **letting the player tap on a penguin to score, then letting the game end after a while**. 
>* :warning: Right now it never ends, so with `popupTime` getting lower and lower it means the _game will become impossible after a few minutes._
>
>We're going to add a `hit()` method to the `WhackSlot` class that will handle hiding the penguin. 
>* This needs to wait for a moment (so the player still sees what they tapped), move the penguin back down again, then set the penguin to be invisible again.
>
>We're going to use an `SKAction` for each of those three things, which means you need to learn some new uses of the class:
>
>* `SKAction.wait(forDuration:)` creates an action that waits for a period of time, measured in seconds.
>
>* `SKAction.run(block:)` will run any code we want, provided as a closure. "Block" is Objective-C's name for a Swift closure.
>
>* `SKAction.sequence()` takes an array of actions, and executes them in order. Each action won't start executing until the previous one finished.
>
>We need to use `SKAction.run(block:)` in order to set the penguin's `isVisible` property to be false rather than doing it directly, because we want it to fit into the sequence. Using this technique, it will only be changed when that part of the sequence is reached.
>
>Put this method into the `WhackSlot` class:

```swift
func hit() {
    isHit = true

    let delay = SKAction.wait(forDuration: 0.25)
    let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
    let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
    charNode.run(SKAction.sequence([delay, hide, notVisible]))
}
```

:white_check_mark: Added, but this isn't identical to what the Youtube video tutorial goes through? 

>With that new method in place, we can call it from the `touchesBegan()` method in `GameScene.swift`. This method needs to figure out what was tapped using the same `nodes(at:)` method you saw in project 11: find any touch, find out where it was tapped, then get a node array of all nodes at that point in the scene.
>
>We then need to loop through the list of all nodes that are at that point, and see if they have the name "charFriend" or "charEnemy" and take the appropriate action. Rather than dump all the code on you at once, here's the basic outline of `touchesBegan()` to start with:

```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    let tappedNodes = nodes(at: location)

    for node in tappedNodes {
        if node.name == "charFriend" {
            // they shouldn't have whacked this penguin
        } else if node.name == "charEnemy" {
            // they should have whacked this one
        }
    }
}
```

:white_check_mark: Completed the empty function

>Nothing complicated there – this is all stuff you know already.
>
>What is new is what comes in place of those two comments. The first comment marks the code block that will be executed if the player taps a friendly penguin, which is obviously against the point of the game.
>
>When this happens, we need to call the `hit()` method to make the penguin 
>* hide itself,
>* subtract 5 from the current score,
>* then run an action that plays a "bad hit" sound.
> 
>All of that should only happen if the slot was visible and not hit.
>
>The code for this block is going to do something interesting that you haven't seen before, and it looks like this:

```swift
let whackSlot = node.parent?.parent as? WhackSlot
```

>**It gets the parent of the parent of the node, and typecasts it as a `WhackSlot`.** 
>* This line is needed because the player has tapped the penguin sprite node, not the slot – we need to get the parent of the penguin, which is the crop node it sits inside, then get the parent of the crop node, which is the `WhackSlot` object, which is what this code does.
>
>You're also going to meet a new piece of code: SKAction's `playSoundFileNamed()` method, which plays a sound and optionally waits for the sound to finish playing before continuing – useful if you're using an action sequence.
>
>We haven't used sound files in iOS yet, but there isn't really a whole lot to say. The three main sound file formats you'll use are MP3, M4A and CAF, with the latter being a renamed AIFF file. AIFF is a pretty terrible file format when it comes to file size, but it's much faster to load and use than MP3s and M4As, so you'll use them often.
>
>Put this code where the `// they shouldn't have whacked this penguin` comment was:

```swift
guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
if !whackSlot.isVisible { continue }
if whackSlot.isHit { continue }

whackSlot.hit()
score -= 5

run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion:false))
```

>**When the player taps a bad penguin, the code is similar.** 
>* The differences are that we want to add 1 to the score (so that it takes five correct taps to offset one bad one), and run a different sound. 
>* But we're also going to set the `xScale` and `yScale` properties of our character node so the penguin visibly shrinks in the scene, as if they had been hit.
>
>Put this code where the `// they should have whacked this one` comment was:

```swift
guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
if !whackSlot.isVisible { continue }
if whackSlot.isHit { continue }

whackSlot.charNode.xScale = 0.85
whackSlot.charNode.yScale = 0.85

whackSlot.hit()
score += 1

run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion:false))
```

>Since we're now potentially modifying the `xScale` and `yScale` properties of our character node, we need to reset them to 1 inside the `show()` method of the slot. Put this just before the `run()` call inside `show()`:

```swift
charNode.xScale = 1
charNode.yScale = 1
```

>Now, looking at our `touchesBegan()` method in GameScene.swift, you should see we can actually move the code around a little to remove duplication. Specifically, checking `isVisible` and `isHit` doesn’t need to be done twice, and neither does calling `whackSlot.hit()` – a better idea is to move those lines outside of their conditions, like this:

```swift
for node in tappedNodes {
    guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
    if !whackSlot.isVisible { continue }
    if whackSlot.isHit { continue }
    whackSlot.hit()

    if node.name == "charFriend" {
        // they shouldn't have whacked this penguin
        score -= 5

        run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
    } else if node.name == "charEnemy" {
        // they should have whacked this one
        whackSlot.charNode.xScale = 0.85
        whackSlot.charNode.yScale = 0.85
        score += 1

        run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
    }
}
```

>This game is almost done. Thanks to the property observer we put in early on the game is now perfectly playable, at least until `popupTime` gets so low that the game is effectively unplayable.
>
>To fix this final problem and bring the project to a close, we're going to limit the game to creating just 30 rounds of enemies. Each round is one call to `createEnemy()`, which means it might create up to five enemies at a time.
>
>First, add this property to the top of your game scene:

```swift
var numRounds = 0

```

>Every time `createEnemy()` is called, we're going to add 1 to the `numRounds` property. When it is greater than or equal to 30, we're going to end the game: hide all the slots, show a "Game over" sprite, then exit the method. Put this code just before the `popupTime` assignment in `createEnemy()`:

```swift
numRounds += 1

if numRounds >= 30 {
    for slot in slots {
        slot.hide()
    }

    let gameOver = SKSpriteNode(imageNamed: "gameOver")
    gameOver.position = CGPoint(x: 512, y: 384)
    gameOver.zPosition = 1
    addChild(gameOver)

    return
}
```

>That uses a positive `zPosition` so that the game over graphic is placed over other items in our game.
>
>The game is now complete! Go ahead and play it for real and see how you do. If you're using the iOS simulator, bear in mind that it's much hard to move a mouse pointer than it is to use your fingers on a real iPad, so don't adjust the difficulty unless you're testing on a real device!

## :two:  [Wrap up](https://www.hackingwithswift.com/read/14/5/wrap-up) 

>You have another game under your belt, and I hope your brain is already starting to bubble up ideas for things you can do to improve it. Plus, you learned more skills, not least SKCropNode, SKTexture, GCD's asyncAfter(), plus lots of new SKAction types, so it's all time well spent.
>
>Try experimenting with the difficulty and see what you come up with – is it easier or harder if the penguin show/hide animation happens at random speeds?

### Review what you learned

>Anyone can sit through a tutorial, but it takes actual work to remember what was taught. It’s my job to make sure you take as much from these tutorials as possible, so I’ve prepared a short review to help you check your learning.

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
> 1. Record your own voice saying "Game over!" and have it play when the game ends.
>
> 2. When showing “Game Over” add an SKLabelNode showing their final score.
>
> 3. Use SKEmitterNode to create a smoke-like effect when penguins are hit, and a separate mud-like effect when they go into or come out of a hole.

## :three:  [Review for project : Whack-a-penguin](https://www.hackingwithswift.com/review/hws/project-14-whack-a-penguin) 

### :boom: Quiz insights
* `SKCropNode` only crops nodes that are placed inside it.
  * If you want something to be cropped, it must be made a child of a crop node.
* We can create custom subclasses of `SKNode`.
  * It's lets us store additional properties and methods.
* SpriteKit actions sequences are made from arrays.
  * The actions are executed in order.
* Any part of the mask of an SKCropNode that has color is not cropped.
  * It doesn't matter what the color is, so make it nice and clear.
* ~~The .replace blend mode replaces all the pixel colors, but leaves transparency intact.~~
  * :red_circle: This blend mode ignores transparency, which is what makes it so fast.
* Objects are sorted by Z position, where higher numbers are placed on top of lower numbers.
  * The exact value of the Z position doesn't matter, only whether it's higher or lower than other Z positions.
* SpriteKit creates particles using `SKEmitterNode`.
  * You can use Xcode's built in particle editor to control how the particles look.
* Y:0 is the bottom of the screen in SpriteKit
  * SpriteKit measures the Y coordinate in the opposite way to UIKit.
* An `xScale` value of 1.0 means "100% of its reguar size".
  * Lower values shrink the sprite down, and higher values scale it up.
* SpriteKit nodes may or may not have a name property set.
  * It's an optional string, so it might not exist.
* Every `SKNode` has a `parent` property.
  * It might not be set, but the property definitely exists.
* GCD's `asyncAfter()` takes an absolute time rather than an offset relative to now.
  * We normally specify it as `.now()` plus some offset.
* SpriteKit has actions that move objects, wait for a period of time, play sounds, and more.
  * It has all those and many more.

7/12 :joy:

