*Day 36 • Friday January 01, 2021*

>Linus Torvalds, the creator of the massively popular Linux operating system, once said “talk is cheap; show me the code.” What he was trying to say in his inimitable way is that seeing code that solves a problem well is often the most important thing in our industry – it’s important to talk about problems and to explore them thoroughly on a conceptual level, but ultimately writing code that solves the problem is what makes products ship.
>
>I use storyboards for most projects I teach – they are easier for beginners to learn, they give us the ability to see how a design looks as we’re building it, and they can even show you previews across multiple devices and orientations at the same time.
>
>**However, in this project we’re going to build the user interface entirely in code.** There will still be a storyboard, but we’re not going to touch it – we’ll create our labels, buttons, and Auto Layout constraints entirely in Swift.
>
>This is our “show me the code” moment: we’re going to look at exactly how to build complex iOS layouts programmatically so that everything is entirely under your control. It’s not hard to do, but it does take a lot of time – we need to create, configure, and place every view by hand. However, I think you’ll learn a lot from the experience, because after today I think you’ll know for sure whether you prefer using storyboards or creating UI in code!
>
>Today you have two topics to work through, and you’ll learn about text alignment, layout margins, UIFont, and more.
>
>Once you’re done, there’s something I’d like you to keep in mind: whether you prefer making user interfaces in storyboards or programmatically, it’s important you know how to do both. It’s one thing having your preference, but when you join a company you need to be able to solve problems as a team.


## :one: [Setting up](https://www.hackingwithswift.com/read/8/1/setting-up)

> This is one of the last games you'll be making with UIKit; almost every game after this one will use Apple's SpriteKit framework for high-performance 2D drawing.
> 
> We’re going to be making a word game based on the popular indie game 7 Little Words. Users are going to see a list of hints and an array of buttons with different letters on, and need to use those buttons to enter words matching the hints.
> 
> Of course I’ll also be using this project to teach lots of important concepts, in particular how to use Auto Layout to create user interfaces entirely in code – no storyboard needed. Being able to use storyboards is a great skill, and being able to create user interfaces in code is also a great skill. Best of all, though, is knowing how to do both, so you can pick whichever works best on a case-by-case basis.
> 
> I should warn you ahead of time: although creating UI in code isn’t hard, it does take a lot of time. As you’ll see I encourage you to run your code regularly so you can see the parts come together, because otherwise this can feel endless!
> 
> Anyway, enough chat: go ahead and create a new Single View App project in Xcode, name it Project8, then save it somewhere. Now go to the project editor and change its device from Universal to iPad, because we’re going to need all the space we can get!
> 
> What's that? You don't know where the project editor is? I'm sure I told you to remember where the project editor was! OK, here's how to find it, one last time, quoted from project 6:
> 
> Press Cmd+1 to show the project navigator on the left of your Xcode window, select your project (it's the first item in the pane), then to the right of where you just clicked will appear another pane showing "PROJECT" and "TARGETS", along with some more information in the center. The left pane can be hidden by clicking the disclosure button in the top-left of the project editor, but hiding it will only make things harder to find, so please make sure it's visible!
> 
> This view is called the project editor, and contains a huge number of options that affect the way your app works. You'll be using this a lot in the future, so remember how to get here! Select Project 6 under TARGETS, then choose the General tab, and scroll down until you see four checkboxes called Device Orientation. You can select only the ones you want to support.
> 
> Obviously now that we’re in project 8, you should look for Project 8 under “TARGETS”, otherwise all that still applies.

## :two:  [Building a UIkit user interface programmatically](https://www.hackingwithswift.com/read/8/2/building-a-uikit-user-interface-programmatically) 
