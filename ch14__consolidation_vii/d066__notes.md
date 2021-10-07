# *Day 66 • Thursday July 01, 2021*

> **Of all the 100 days, this period you’re in right now is probably the hardest.** At this point you’ve passed the half-way mark, but the end is still far enough away that you know there’s still a lot of work to do. Worse, the difficulty of the projects starts to ramp up a little – **we’ll be tackling a couple of longer projects next, which will really test your staying power.**

:sweat_smile: Oh dear, bring it.

> Maybe you’re feeling tired; maybe you’re not sure you can make it to the end; or maybe you’re just running out of steam. And if you’re feeling that way, don’t be too hard on yourself – this is a hard course, and doing an hour every day for all this time is tiring.
> 
> Well, I hope you can take some strength from knowing that today marks the 2/3rd point for the course – you’ve made it through 66% of the days, and you’ve come a really long way. As Dan Millman said, _“willpower is the key to success – successful people strive no matter what they feel by applying their will to overcome apathy, doubt or fear.”_
> 
> So, now is the time you need to dig deep and find the willpower to continue, because by the time the next consolidation day rolls around you’ll be three-quarters of the way through and the end will really be in sight!
> 
> Today you have three topics to work through, one of which of is your challenge.

- [*Day 66 • Thursday July 01, 2021*](#day-66--thursday-july-01-2021)
  - [:one:  What you learned](#one--what-you-learned)
  - [:two:  Key points](#two--key-points)
    - [Assertions](#assertions)
    - [Timer](#timer)
  - [:three:  Challenge](#three--challenge)
    - [References](#references)
    - [Trying to get TargetRow right](#trying-to-get-targetrow-right)
    - [Source files](#source-files)
    - [Assign targets to rows?](#assign-targets-to-rows)

## :one:  [What you learned](https://www.hackingwithswift.com/guide/7/1/what-you-learned) 

> Although these projects shouldn’t have been too difficult for someone at your level, they definitely covered some important skills that you’ll come back to time and time again.
> 
> You also completed the _technique project_ all about **debugging**. Although I covered the main techniques in that chapter, debugging isn’t really something that can be taught – it’s a skill you acquire over time with experience. As you progress, you’ll learn to recognize certain kinds of errors as ones you’ve solved before, so over time you get faster and spotting - and fixing – mistakes.
> 
> Some other things you learned in this milestone are:

>
> * **MapKit**, Apple’s incredible, free map framework that lets you add maps, satellite maps, route directions, and more.
>
> * How to use `Timer` to trigger a repeating method every few seconds. Remember to call `invalidate()` on your time when you want it to stop!
>
> * In **SpriteKit**, you learned to use the `advanceSimulationTime()` method to force a particle system to move forward a set number of seconds so that it looks like it has existed for a while.
>
> * We used the `SKPhysicsBody(texture:)` initializer to get pixel-perfect physics. This is computationally expensive, so you should use it only when strictly needed.
>
> * We used the `linearDamping` and `angularDamping` properties of `SKPhysicsBody` to force sprites to retain their speed and spin, rather than slowing down over time – project 23 was set in outer space, after all!
>
> * You learned how the `assert()` function lets you ensure your app’s state is exactly what you thought it was.
>
> * You set your first **breakpoints**, and even attached a condition to it. Trust me on this: you will use breakpoints thousands – if not hundreds of thousands! - of times in your Swift career, so this is a great skill to have under your belt.

## :two:  [Key points](https://www.hackingwithswift.com/guide/7/2/key-points) 

> There are two pieces of code I’d like to review before you continue, because both are hugely unappreciated.

### Assertions

> First, the `assert()` function. If you remember, you place calls to `assert()` in your code whenever you want to say, “I believe X must be the case.” What X is depends on you: “this array will contain 10 items,” or “the user must be logged in,” or “the in-app purchase content was unlocked” are all good examples.
> 
> When the `assert()` line hits, iOS validates that your statement is true. If the array doesn’t contain 10 items, or the in-app purchase wasn’t unlocked, the assertion will fail and your app will crash immediately. Xcode will print the location of the crash – e.g. `ViewController.swift` line 492 – along with any custom message you attached, such as “The in-app purchase failed to unlock content.”

:+1:

> Obviously crashing your app sounds bad on the surface, but remember: _assertions are automatically removed when you build your app in release mode – i.e., for the App Store_. This means not only will your app not crash because an assertion failed, but also that those assertions aren’t even checked in the first place – Xcode won’t even run them. This means you can – and should! – add assertions liberally throughout your code, because they have zero performance impact on your finished, shipping app.
> 
> **Think of assertions as “hard-core mode” for your app**: if your app runs perfectly even with assertions in every method, it will definitely work when users get hold of it. And if your assertions do make your app crash while in development, that’s perfect: it means your app’s state wasn’t what you thought, so either your logic is wrong or your assertion was.

### Timer

> The second piece of code to review is the Timer class, which we used like this:

```swift
gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)

```

> Timers are _rudimentary things_, but perfectly fit many games – that code will cause the `createEnemy()` method to be called approximately every 0.35 seconds until it’s cancelled.
> 
> In this case, the `gameTimer` value was actually a property that belong to the game scene. Cunningly, Timer maintains **a strong reference to its target** – i.e., _it stores it and won’t let it be destroyed while the timer is still active_ – which means this forms **a strong reference cycle**. That is, _the game scene owns the timer, and the timer owns the game scene,_ which means neither of them will be ever destroyed unless you manually call invalidate().
> 
> In **project 17** this isn’t a problem, but we’ll be returning to this theme in project 30 when it is a problem – watch out for it!

30 feels a long way away!

> By the way: the Timer class really does offer only approximate accuracy, meaning that the `createEnemy()` method will be called roughly every 0.35 seconds, but it might take 0.4 seconds one time or 0.5 seconds another. In the context of Space Race this isn’t a problem, but remember: _iOS wants you to draw at 60 or 120 frames per second_, which gives you between 8 and 16 milliseconds to do all your calculation and rendering – a small delay from Timer might cause problems in more advanced games.
> 
> The iOS solution to this is called `CADisplayLink`, and it causes a method of yours to be **called every time drawing has just finished**, _ensuring you always get the maximum allotment of time for your calculations_. This isn’t covered in Hacking with Swift, but you’ll find an explanation and code example in this article in my Swift Knowledge Base: How to synchronize code to drawing using CADisplayLink.

Oh cool! Interesting to look at sometime

## :three:  [Challenge](https://www.hackingwithswift.com/guide/7/3/challenge) 

> _It’s time to put your skills to the test and make your own app, starting from a blank canvas._ 
> 
> This time your challenge is to make a shooting gallery game using SpriteKit: 
> * create three rows on the screen, 
> * then have targets slide across from one side to the other. 
> * If the user taps a target, make it fade out and award them points.
> 
> How you implement _this game really depends on what kind of shooting gallery games you’ve played in the past_, but here are some suggestions to get you started:
>
>   - [ ]  Make some targets big and slow, and others small and fast. The small targets should be worth more points.
>
>   - [ ]  Add “bad” targets – things that cost the user points if they get shot accidentally.
>
>   - [ ]  Make the top and bottom rows move left to right, but the middle row move right to left.
>
>   - [ ]  Add a timer that ticks down from 60 seconds. When it hits zero, show a Game Over message.
>
>   - [ ]  Try going to https://openclipart.org/ to see what free artwork you can find.
>
>   - [ ]  Give the user six bullets per clip. Make them tap a different part of the screen to reload.
>
> Those are just suggestions – it’s your game, so do what you like!


  - [x]  start new project
  - [x]  reset game scenes as usual
  - [x]  add good and bad target assets to project
  - [x]  add three rows (with different bg colors)
  - [ ]  add random number of targets to the rows
  - [ ]  make targets disappear on touch
  - [ ]  add points on good target touch
  - [ ]  remove points on bad target touch
  - [ ]  display points in label somewhere on the screen
  - [ ]  make top and bottom row targets move left to right
  - [ ]  make middle row targets move right to left
  - [ ]  limit user to six tries

> Tip: I made a SpriteKit shooting gallery game in my book Hacking with macOS – the SpriteKit code for that project is compatible with iOS, but rather than just reading my code you might prefer to just take my assets and use them to build your own project.
> 
> As always, please try to code the challenge yourself before reading any of the hints below.
>
> Moving the targets in your shooting gallery is a perfect job for the `moveBy()` action. Use a sequence so that targets move across the screen smoothly, then remove themselves when they are off screen.
>
> You can create a timer using an `SKLabelNode`, a `secondsRemaining` integer, and a `Timer` that takes 1 away from `secondsRemaining` every 1 second.
>
> Make sure you call `invalidate()` when the time runs out.
>
> Use `nodes(at:)` to see what was tapped. If you don’t find a node named “Target” in the returned array, you could subtract points for the player missing a shot.
>
> You should be able to use a property observer for both player score and number of bullets remaining in clip. Changing the score or bullets would update the appropriate `SKLabelNode` on the screen.

### References

:pencil: Getting the background and rows set right isn't easy but seems it would be wisest to do it in different classes :

* https://github.com/clarknt/100-days-of-swift/blob/main/24-Milestone-Projects16-18/Milestone-Projects16-18/GameScene.swift
* https://github.com/nocto7/Day66/blob/master/Day66/GameScene.swift
* https://github.com/leoidiaz/100DaysOfSwift/blob/master/MilestoneProject16-18/MilestoneProject16-18/GameScene.swift
* https://github.com/robbaldwin/100DaysOfSwift/tree/master/C06%20ShootingGallery
* https://github.com/roblack/100DaysOfSwift_challenges/blob/master/Day66_challenge/Day66_challenge/GameScene.swift
* https://github.com/thomaskellough/tutorialsSwift/blob/master/Milestone%20Projects%2016-18/Milestone%20Projects%2016-18/GameScene.swift
* https://github.com/clarknt/100-days-of-swift/blob/main/24-Milestone-Projects16-18/Milestone-Projects16-18/WaveNode.swift

:question: *When do I use a `struct` versus using a `protocol` ?* 

### Trying to get TargetRow right

`ch14__consolidation_vii/ConsolidationVii/ConsolidationVii/RowNode.swift`

```swift
//
//  RowNode.swift
//  ConsolidationVii
//
//  Created by Jamie Brannan on 08/07/2021.
//

import SpriteKit

enum FlowDirection {
  case right
  case left
}

enum VerticalPosition {
  case top
  case middle
  case bottom
}

class TargetRow: SKShapeNode {
  
  // MARK: Props
  let duration = Double.random(in: 0.2...0.6)
  lazy var goLeft = SKAction.moveBy(x: -20, y: 0, duration: duration)
  lazy var goRight = SKAction.moveBy(x: 20, y: 0, duration: duration)
  lazy var sequenceLeft = SKAction.sequence([goLeft, goRight])
  lazy var sequenceRight = SKAction.sequence([goRight, goLeft])

  var direction : FlowDirection = .right
  var rowName: VerticalPosition = .top
//  var fill: UIColor
//  var point: CGPoint

  // MARK: Configuration
  override init() {
    super.init()
  }

  convenience init(direction: FlowDirection, fill: UIColor, point: CGPoint, named name: VerticalPosition) {
    self.init()
    self.direction = direction
    self.fillColor = fill
    self.position = point
    self.name = "\(name)Row"
  }
//  init(direction: FlowDirection, fill: UIColor, point: CGPoint, named name: VerticalPosition) {
//    super.init(rect: CGRect(x: point.x, y: point.y, width: 300, height: 100))
//    self.direction = direction
//    self.fillColor = fill
//    self.position = point
//    self.name = "\(name)Row"
//  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func animate() {
    switch direction {
    case .right:
      let forever = SKAction.repeatForever(sequenceRight)
      self.run(forever)
    default:
      let forever = SKAction.repeatForever(sequenceLeft)
      self.run(forever)
    }
  }
}

```

`ch14__consolidation_vii/ConsolidationVii/ConsolidationVii/GameScene.swift`

```swift
//
//  GameScene.swift
//  ConsolidationVii
//
//  Created by Jamie Brannan on 05/07/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

  override func didMove(to view: SKView) {
    backgroundColor = .yellow
    let topRow = TargetRow(direction: .left, fill: .cyan, point: CGPoint(x: frame.midX, y: frame.midY + frame.height/3 ), named: .top)
    let middleRow = TargetRow(direction: .right, fill: .brown, point: CGPoint(x: frame.midX, y: frame.midY), named: .middle)
    let bottomRow = TargetRow(direction: .right, fill: .cyan, point: CGPoint(x: frame.midX, y: frame.midY - frame.height/3 ), named: .bottom)
    addChild(topRow)
    addChild(middleRow)
    addChild(bottomRow)
  }
}

```

### Source files

* https://openclipart.org/detail/240684/Zika-Virus

* https://openclipart.org/download/261819/Monarch-Butterfly-2.svg

* https://openclipart.org/download/9255/lalolalo-ladybug.svg

Resized some of them in Affinity Designer :pushpin: [**Affinity Forums**](https://forum.affinity.serif.com/index.php?/topic/33847-cropping-canvas-to-selected-objects-size/) : *Cropping canvas to selected objects size*

How can I shift the scale of a node?

### Assign targets to rows?

If I can calculate all positions according to spaces of rows, and assign targets to rows randomly.