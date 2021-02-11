# *Day 47 • Thursday February 11, 2021*

>Today we reach the end of project 11, which means it’s time for some more challenges. I know the clue is right there in the name, but these are challenges are designed to be challenging – you need to think about previous problems you’ve solved across other projects, then apply that knowledge in a new and different way here.
>
>These challenges are designed to help you learn, because it’s one thing to follow my instructions and quite another to apply your knowledge to new problems. However, if you find them tricky don’t get worried if you see folks online solving them quickly – they are here to help you learn, not as some sort of way for you to measure yourself against others. As Shakuntala Devi once said, “nobody challenges me – I challenge myself.”
>
>**Today you should work through the `SKEmitterNode` and wrap up chapters for project 11, complete its review, then work through all three of its challenges.**

## :one:  [Special effects `SKEmitterNode`]([](https://www.hackingwithswift.com/read/11/7/specialeo-effects-skemitternode) ) 

>Our current `destroy()` method does nothing much, it just removes the ball from the game. But I made it a method for a reason, and that's so that we can add some special effects now, in one place, so that however a ball gets destroyed the same special effects are used.
>
>Perhaps unsurprisingly, it's remarkably easy to create special effects with SpriteKit. In fact, it has a built-in particle editor to help you create effects like fire, snow, rain and smoke almost entirely through a graphical editor. I already created an example particle effect for you (which you can customize soon, don't worry!) so let's take a look at the code first.
>
>Modify your `destroy(`) method to this:

```swift
func destroy(ball: SKNode) {
    if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
        fireParticles.position = ball.position
        addChild(fireParticles)
    }

    ball.removeFromParent()
}
```

>The SKEmitterNode class is new and powerful: it's designed to create high-performance particle effects in SpriteKit games, and all you need to do is provide it with the filename of the particles you designed and it will do the rest. Once we have an SKEmitterNode object to work with, we position it where the ball was then use addChild() to add it to the scene.
>
>If you run the app now, you'll see the balls explode in a fireball when they touch a slot – a pretty darn amazing effect given how little code was written!
>
>But the real fun is yet to come, because the code for this project is now all done and you get to play with the particle editor. In Xcode, look in the Content folder you dragged in and select the FireParticles.sks file to load the particle editor.
>
>The particle editor is split in two: the center area shows how the current particle effect looks, and the right pane shows one of three inspectors. Of those three inspectors, only the third is useful because that's where you'll see all the options you can use to change the way your particles look.
>
>At the time of writing, Xcode's particle editor is a little buggy, so I suggest you change the Maximum value to 0 before beginning otherwise you might see nothing at all.
>
>Confused by all the options? Here's what they do:
>
>
>* Particle Texture: what image to use for your particles.
>
>* Particles Birthrate: how fast to create new particles.
>
>* Particles Maximum: the maximum number of particles this emitter should create before finishing.
>
>* Lifetime Start: the basic value for how many seconds each particle should live for.
>
>* Lifetime Range: how much, plus or minus, to vary lifetime.
>
>* Position Range X/Y: how much to vary the creation position of particles from the emitter node's position.
>
>* Angle Start: which angle you want to fire particles, in degrees, where 0 is to the right and 90 is straight up.
>
>* Angle Range: how many degrees to randomly vary particle angle.
>
>* Speed Start: how fast each particle should move in its direction.
>
>* Speed Range: how much to randomly vary particle speed.
>
>* Acceleration X/Y: how much to affect particle speed over time. This can be used to simulate gravity or wind.
>
>* Alpha Start: how transparent particles are when created.
>
>* Alpha Range: how much to randomly vary particle transparency.
>
>* Alpha Speed: how much to change particle transparency over time. A negative value means "fade out."
>
>* Scale Start / Range / Speed: how big particles should be when created, how much to vary it, and how much it should change over time. A negative value means "shrink slowly."
>
>* Rotation Start / Range / Speed: what Z rotation particles should have, how much to vary it, and how much they should spin over time.
>
>* Color Blend Factor / Range / Speed: how much to color each particle, how much to vary it, and how much it should change over time.

>Note: Once you've finished editing your particles, make sure you put a maximum value back on them otherwise they'll never go away!
>
>It's worth adding that you can create particles from one of Xcode's built-in particle template. Add a new file, but this time choose "Resource" under the iOS heading, then choose "SpriteKit Particle File" to see the list of options.

## :two:  [Wrap up](https://www.hackingwithswift.com/read/11/8/wrap-up) 

>This project is done, and it's been a long one, but I hope you look at the results and think it was all worth it. Plus, you've once again learned a lot: SpriteKit, physics, blend modes, radians and CGFloat.
>
>You’ve got the firm foundations of a real game here, but there's lots more you can do to make it even better.
>
### Review what you learned
>Anyone can sit through a tutorial, but it takes actual work to remember what was taught. It’s my job to make sure you take as much from these tutorials as possible, so I’ve prepared a short review to help you check your learning.
>
>Click here to review what you learned in project 11.
>
### Challenge
>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
>The pictures we’re using in have other ball pictures rather than just “ballRed”. Try writing code to use a random ball color each time they tap the screen.
>Right now, users can tap anywhere to have a ball created there, which makes the game too easy. Try to force the Y value of new balls so they are near the top of the screen.
>Give players a limit of five balls, then remove obstacle boxes when they are hit. Can they clear all the pins with just five balls? You could make it so that landing on a green slot gets them an extra ball.


## :three:  [Review for Project 11 : Pachinko](https://www.hackingwithswift.com/review/hws/project-11-pachinko) 