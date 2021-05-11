# *Day 57 • Tuesday May 11, 2021*

>Today we’re going to be looking at a fundamentally important part of iOS development: animation.

:tada:

>Years ago animation was often considered inconsequential – it was there to make something look nice, rather than adding real value. **But today we recognize that animation helps guide users through state changes in our app**: when they delete an email it moved into the trash can, so they can see that it’s gone and know where to go if they want it back.
>
>**John Maeda**, design lead at Automattic (the company behind Wordpress), put this rather succinctly: _“Design used to be the seasoning you’d sprinkle on for taste; now it’s the flour you need at the start of the recipe.”_ 
>* That means we need to be thinking about animation at the early stages of our app – deciding how the user should interact with everything we show them needs to be at the core of our design.
>
>Today is all about **bringing your user interfaces to life** with movement, scaling, rotation, and more. We’ll be working in a **sandbox**, but you can use these principles anywhere!
>
>**Today you have three topics to work through, and you’ll learn about `animate(withDuration:)`, `CGAffineTransform`, `alpha`, and more.**

- [*Day 57 • Tuesday May 11, 2021*](#day-57--tuesday-may-11-2021)
  - [:one:  Setting up](#1️⃣-setting-up)
  - [:two:  Preparing for action](#2️⃣-preparing-for-action)
  - [:three:  Switch, case, animate, animate(withDuration:)](#3️⃣-switch-case-animate-animatewithduration)
  - [:four:  Transform CGAffineTransform](#4️⃣-transform-cgaffinetransform)

## :one:  [Setting up](https://www.hackingwithswift.com/read/15/1/setting-up) 

>It's time to introduce one of the most important techniques in iOS development: animation. Sadly, many people don't consider animation important at all, which makes for some thoroughly awful user interface design.
>
>Animation – making things move, scale, and so on – of your views is not only about making things pretty, although that's certainly a large part. **Its main purpose is to give users a sense of what's changing and why, and it helps them make sense of a state change in your program.**
>
>When we use a navigation controller to show a new view controller, we don't just want it to appear. _Instead, we want it to slide in, making it clear that the old screen hasn't gone away, it's just to the left of where we were._
>
>You're almost certainly tired of hearing me say this, but iOS has _a ridiculously powerful_ **animation toolkit **that's also easy to use. I know, I'm a broken record, right?
>
>Well, don't just take my word for it – let's try out some animation together so you can see exactly how it works. So, create a new Single View App project in Xcode, naming it Project15.
>
>Please download the files for this project from GitHub (https://github.com/twostraws/HackingWithSwift) and copy its Content folder into your Xcode project. Finally, set it to work on landscape iPads only. Animation of course works on all devices and in all orientations, but it's easier to work with a fixed size for now.

## :two:  [Preparing for action](https://www.hackingwithswift.com/read/15/2/preparing-for-action) 

## :three:  [Switch, case, animate, animate(withDuration:)](https://www.hackingwithswift.com/read/15/3/switch-case-animate-animatewithduration) 

## :four:  [Transform CGAffineTransform](https://www.hackingwithswift.com/read/15/4/transform-cgaffinetransform) 