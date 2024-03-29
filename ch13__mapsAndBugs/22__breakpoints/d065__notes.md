# *Day 65 • Friday June 25, 26, 2021*

> When I first took up cycling there was a particular long, steep hill I used to practice on, and it was so hard for me – I remember getting off half way up and walking the remainder! I asked one of the team at my local bike shop about it, and his response really stuck with me: “it doesn’t get much easier, but you do get faster.”
>
> Today is another challenge day, and hopefully these challenges are getting a little easier to follow over time. I say “easier to follow” rather than just “easier” because it’s an important distinction – I don’t expect you’ll ever find these challenges easy but you will at least feel more able to tackle them. As the bike shop person said: it doesn’t get much easier, but you do get faster.
>
> **Today you should work through the wrap up chapter for project 18, complete its review, then work through all three of its challenges.**
>
>Extra credit: If you have the time and would like to take your debugging skills further, try watching my video [How to Debug Like a Pro](https://appdevcon.nl/session/how-to-debug-like-a-pro/). It was delivered at Appdevcon in Amsterdam, in 2018, but the tips you’ll find there will help take your debugging skills further.
>
>That’s another project finished, and a useful one too – make sure and tell others about your continued progress!

## :one:  [Wrap up](https://www.hackingwithswift.com/read/18/6/wrap-up) 

>Debugging is a unique and essential skill that’s similar but different to regular coding. As you’ve just seen, there are lots of options to choose from, and you will – I promise! – use all of them at some point. Yes, even print().
>
>There's more to learn about debugging, such as the Step Into and Step Out commands, but realistically you need to start with what you have before you venture any further. I would much rather you mastered three of the debugging tools available to you rather than having a weak grasp of all of them.

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
>  - [x]  Temporarily try adding an exception breakpoint to **project 1**, then changing the call to `instantiateViewController()` so that it uses the storyboard identifier “Bad” – this will fail, but your exception breakpoint should catch it.

Interesting! So it stops just before the crash! Wow.

>  - [x]  In **project 1**, add a call to `assert()` in the `viewDidLoad()` method of DetailViewController.swift, checking that `selectedImage` always has a value.

```swift
    assert(selectedImage != nil, "There must always be a value for selected image")
```
Easy peasy.

>  - [x]  Go back to **project 5**, and try adding a conditional breakpoint to the start of the `submit()` method that pauses only if the user submits a word with six or more letters.

This is really pretty fun :)

## :two:  [Review for Project 18 : Debugging](https://www.hackingwithswift.com/review/hws/project-18-debugging) 

### :boom: Quiz insights

* print() is a variadic function.
  * This means it can accepts lots of parameters to be printed.
* If you pass a separator to print() it will be used between each value that gets printed.
  * This lets you format its output more cleanly.
* The p command in LLDB is short for "print".
  * It's an easy way to read the value of a particular variable.
* It's a good idea to make liberal use of assertions.
  * These can help catch errors in your program state.
* Variadic functions accept zero or more values of the same type
  * Inside the function they get grouped into an array.
* View debugging renders your UI in 3D so you can see how views are layered.
  * It's a great way to find out why a specific view isn't visible.
* The print() function accepts any kind of value.
  * It's really flexible – you can send it whatever you need.
* Assertions are removed when we build our apps for the App Store.
  * This means you can run slow functionality and it doesn't matter – it never happens on users' devices.
* Assertions must be provided with a condition to check.
  * You can provide a message to print if that check fails, but the message is optional.
* Breakpoints can have conditions attached.
   *  These let you pause only when specific conditions are true.
*  Breakpoints pause execution of your code.
   *  When your code is paused you can read the values of any properties and variables.
*  Back traces only show you all the functions that were called into the lead up to the current location, not all the code run.
*  Exception breakpoints automatically get triggered when some code throws an error.
*  This commonly happens when system APIs hit problems.