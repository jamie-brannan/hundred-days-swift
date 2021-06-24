# *Day 64 • Monday June 21, 24 2021*

>Thomas Fuchs once said, **“the best error message is the one that never shows up.”** Of course, getting to that point is easier said than done – even in just your progress in this course so far you’ve almost certainly hit 50 or more bugs in your code, and had to figure out the problem then resolve it.
>
>In this small but important technique project we’re going to look at a few different ways of helping you identify problems in your code. Even though this is an important skill, I waited until now to show it to you because it’s important you first feel the problem acutely – you’ve hit bugs, and you’ve had to work hard to solve them. But now you’ve done that, you should be able to appreciate these debugging tips all the more!

Oh cool, looking forward to focusing on a skills outside of API knowledge :) 

>**Today you have five short topics to work through, and you’ll learn about `assert()`, breakpoints, view debugging, and more.**

## :one:  [Setting up](https://www.hackingwithswift.com/read/18/1/setting-up) 

>Debugging is the act of removing mistakes from your apps, so in some respects programming is the act of putting bugs into your apps. What’s more, there’s a famous quote that should strike terror into your heart: _“Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.”_
>
>Of course, the truth is that we’re not able to write code “as cleverly as possible” – we all just muddle through and do our best. Debugging, then, is inevitable: even the best of us writes software with mistakes in, and **it’s a hugely important skill to be able to find and fix those mistakes as efficiently as possible.**
>
>In this project we’ll be looking at several different debugging techniques, all of which are useful. _I’ve arranged them easy to hard_, so you can get started immediately and work your way forward as your skills improve.
>
>Remember: **there is no learning without struggle**. Every time you make a mistake coding, you’ll be forced to debug it, and in doing so your coding skills will improve as will your debugging skills. So: don’t be annoyed when you screw up – it benefits you in the long term!
>
>To follow along, please create a new Single View App project named Project18.

:white_check_mark: created.

## :two:  [Basic Swift Debugging using print](https://www.hackingwithswift.com/read/18/2/basic-swift-debugging-using-print) 

>We're going to start with the absolute easiest debugging technique, which is the `print()` function. This prints a message into the Xcode debug console that can say anything you want, because users won't see it in the UI. 
>
>**The "scattershot" approach** to bug fixing is to _litter your code with calls to `print()`_ then follow the messages to see what's going on.
>
>You'll meet lots of people telling you how bad this is, but the truth is **it's the debugging method everyone starts with** – it's easy, it's natural, and it often gives you enough information to solve your problem. Use it with Swift's string interpolation to see the contents of your variables when your app is running.
>
>We’ve used `print()` several times already, always in its most basic form:

```swift
print("I'm inside the viewDidLoad() method!")
```

>By adding calls like that to your various methods, **you can see exactly how your program flowed**.
>
>However, `print()` is actually a bit more complicated behind the scenes. For example, you can actually pass it lots of values at the same time, and it will print them all:

```swift
print(1, 2, 3, 4, 5)
```

>That makes print() a **variadic function**, which you learned about previously. Here, though, it’s worth adding that print()’s variadic nature becomes much more useful when you use its optional extra parameters: separator and terminator.
>
>The first of these, separator, lets you provide a string that should be placed between every item in the print() call. Try running this code:

```swift
print(1, 2, 3, 4, 5, separator: "-")
```

>That should print “1-2-3-4-5”, because the separator parameter is used to split up each item passed into print().

Cool, this reminds me of what can be set up with all the different prints in Go.

>The second optional parameter, terminator, is what should be placed after the final item. It’s \n by default, which you should remember means “line break”. If you don’t want print() to insert a line break after every call, just write this:

```swift
print("Some message", terminator: "")
```

>Notice how you don’t need to specify separator if you don’t want to.


## :three:  [Debugging with assert](https://www.hackingwithswift.com/read/18/3/debugging-with-assert) 

>One level up from `print() `are assertions, which are debug-only checks that will force your app to crash if a specific condition isn't true.
>
>On the surface, that sounds terrible: **why would you want your app to crash?** 
>
>There are two reasons. 
>
>_First_, sometimes making your app crash is the Least Bad Option: if something has gone catastrophically wrong – if some fundamentally important file is not where it should be – then **it may be the case that continuing your app will cause irreparable harm to user data**, in which case crashing, while a bad result, is better than losing data.
>
>Second, **these assertion crashes only happen while you’re debugging**. When you build a release version of your app – i.e., when you ship your app to the App Store – _Xcode automatically disables your assertions so they won’t reach your users_. This means you can set up an extremely strict environment while you’re developing, ensuring that all values are present and correct, without causing problems for real users.

I've never seen asserts outside of Unit tests, would this really be something left in the main `.swift` files rather than unit tests? :thinking:

>Here's a very basic example:

```swift
assert(1 == 1, "Maths failure!")
assert(1 == 2, "Maths failure!")
```
>As you can see `assert()` takes two parameters: something to check, and a message to print out of the check fails. If the check evaluates to false, your app will be forced to crash because you know it's not in a safe state, and you'll see the error message in the debug console. You can – and should! – add these assertions liberally to your code, because they help guarantee that your code’s state is what you think it is.
>
>The advantage to assertions is that their check code is never executed in a live app, so your users are never aware of their presence. This is different from `print()`, which would remain in your code if you shipped it, albeit mostly invisible. In fact, because calls to `assert()` are ignored in release builds of your app, you can do complex checks:

```swift
assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")
```
>That `myReallySlowMethod()` call will execute only while you’re running test builds – that code will be removed entirely when you build for the App Store.
>
>So: **assertions are like running your code in strict mode**. If your app works great with assertions on – things that literally make your app crash if things are wrong – then it will work even better in release mode.

More useful than print but I'm not sure I'd use it unless I'm really plugging around as I go. I'd like to invest in doing more TDD with unit test files than throw random asserts. Still a new point of reference for me. 

## :four:  [Debugging with breakpoints](https://www.hackingwithswift.com/read/18/4/debugging-with-breakpoints) 

>It’s time to start using that Project18 project you made, because we’re about to look at breakpoints. These are easy to use initially, but _have a lot of hidden complexity_ if you want to get more advanced.
>
>Let's start small, with a simple loop that prints numbers from 1 to 100. Add this to viewDidLoad():

```swift
for i in 1 ... 100 {
    print("Got number \(i)")
}
```

Classic.

>If we wanted to see exactly what our **program state** was at the time we call the `print()` function, look to the left of where you've been typing and you'll see the line number markers. _Click on the line number where `print() `is, and a blue marker will appear to signal that a **breakpoint** has been placed._ 
>* This means that execution of your code will stop when that line is reached, and you have the opportunity to inspect your app’s internal state to see what values everything has.

Yup, good old friend.

>If you click on a breakpoint again, the blue arrow will become faint to show that the breakpoint exists but is **disabled**. This is useful when you want to keep your place, but don’t want execution to stop right now. You can click again to make it active, or right-click and choose Delete Breakpoint to remove it entirely.
>
>No line numbers? If your Xcode isn't showing line numbers by default, I suggest you turn them on. Go to the Xcode menu and choose Preferences, then choose the Text Editing tab and make sure "Line numbers" is checked.

:+1:

>With that breakpoint in place, Xcode will pause execution when it's reached and show you the values of all your variables. Try running it now, and you should see your app paused, with a light green marker on the line of code that is about to be executed. At the bottom of the Xcode window you should see Xcode telling you that i currently has a value of 1. That's because it paused as soon as this line is reached, which is the very first iteration of our loop.
>
>From here, you _can carry on execution_ by **pressing F6**, but you may need to use Fn+F6 because the function keys are often mapped to actions on Macs. This shortcut is called **Step Over** and will tell Xcode to advance code execution by one line. You can walk through the loop in its entirety by pressing F6 again and again, but there's another command called **Continue (Ctrl+Cmd+Y)** that means "continue executing my program until you hit another breakpoint."

I didn't know this short cut.

>When your program is paused, you'll see something useful on the left of Xcode's window: a back trace that shows you all the threads in your program and what they are executing. So if you find a bug somewhere in method `d()`, this back trace will show you that `d()` was called by `c()`, which was called by `b()`, which in turn was called by `a()` – **it effectively shows you the events leading up to your problem, which is invaluable when trying to spot bugs.**
>
>Xcode also gives you an interactive **LLDB debugger window**, where you can type commands to query values and run methods. If it’s visible, you’ll see “(lldb)” in the bottom of your Xcode window. If you don’t see that, go to View > Debug Area > Activate Console, at which point focus will move to the LLDB window. Try typing `p i` to ask Xcode to print the value of the `i` variable.

:heart_eyes_cat: Looove lldb, something to play with more.

>While your app is paused, here’s one more neat trick that few people know about: _that light green arrow that shows your current execution position can be moved_. **Just click and drag it somewhere else to have execution pick up from there** – although Xcode will warn you that it might have unexpected results, so tread carefully!

Oh cool, this arrow is known as the **instruction pointer**.

>Breakpoints can do two more clever things, but for some reason both of them aren't used nearly enough. 
>
>The first is that **you can make breakpoints conditional**, meaning that they will pause execution of your program _only if the condition is matched_. Right now, our breakpoint will stop execution every time our loop goes around, but **what if we wanted it to stop only every 10 times?**
>
>Right-click on the breakpoint (the blue arrow marker) and choose **Edit Breakpoint**. In the popup that appears, set the condition value to be `i % 10 == 0` – this uses modulo, as seen in project 8. With that in place, execution will now pause only when i is 10, 20, 30 and so on, up to 100. You can use conditional breakpoints to execute debugger commands automatically – the "Automatically continue" checkbox is perfect for making your program continue uninterrupted while breakpoints silently trigger actions.

So in the condition I can write whatever sort of swiftly worded bool expression using variable names? But is this limited to the variables that are present in the file or can it be ones from anywhere in the project?

>The second clever thing that breakpoints can do is be a_utomatically triggered when an exception is thrown_. **Exceptions**_ are errors that aren't handled, and will cause your code to crash._ With breakpoints, you can say _"pause execution as soon as an exception is thrown,"_ so that you can examine your program state and see what the problem is.

And **exception is still a type of error – it's just _handled_**.

>To make this happen, press Cmd+8 to choose the breakpoint navigator – it's on the left of your screen, where the project navigator normally sits. Now click the + button in the bottom-left corner and choose "Exception Breakpoint." That's it! The next time your code hits a fatal problem, the exception breakpoint will trigger and you can take action.

:scream: WOAHHHHH so many different types, I never thought to look for a + button, just thinking that was for adding files.

:question: _Do all the numbers + `cmd` handle the different pannels? Is it from left to right?_

## :five:  [View debugging](https://www.hackingwithswift.com/read/18/5/view-debugging) 

>The last debugging technique I want to look at is view debugging, Xcode comes with a marvelous feature called **Capture View Hierarchy**, and when it's used your see your current view layout inside Xcode with thin gray lines around all the views.
>
>First, launch a project with some interesting UI. Project 13, for example, has enough in there to be interesting. Now run the program as normal, then in Xcode go to the Debug menu and choose View Debugging > Capture View Hierarchy. After a few seconds of thinking, Xcode will show you a screenshot of your app’s UI.
>
>Here’s the clever part: if you click and drag inside the hierarchy display, you'll see you're actually viewing a 3D representation of your view, which means you can look behind the layers to see what else is there. The hierarchy automatically puts some depth between each of its views, so they appear to pop off the canvas as you rotate them.
>
>This debug mode is perfect for times when you know you've placed your view but for some reason can't see it – often you'll find the view is behind something else by accident.

This is an old friend <3

## :arrow_right_hook: :gift: Wrap up the day

:scissors: **New shortcut**
* **`F6`** – Step Over, breakpoint continuation
* **`ctrl` + `cmd` + `Y`** – Continue on to another breakpoint
* **`cmd` + `8`** – Open breakpoint pannel