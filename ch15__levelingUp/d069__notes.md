# *Day 69 • Tuesday November 09, 2021*

> You’ve modified Safari! Apple’s web browser has been there since the very first iPhone, and now you’ve hooked your own code directly into it. You’ll be taking on a few challenges today to encourage you to think of ways to use your new-found power, but I hope you can immediately realize the potential here – even a small improvement can make a difference to millions of people.

> I know this project was hard, but I have some bad news for you: tomorrow’s game is also hard. But as Kimberly Guilfoyle said, “through determination and self-focus and discipline, you can accomplish anything.”

> Stick with it! Things get easier after the next game, but your skillset continues to expand rapidly.

> Today you should work through the wrap up chapter for project 19, complete its review, then work through all three of its challenges.

> That’s another project finished, and one that gives you the foundations for some major new projects of your own – share your progress with the world!

## :one:  [Wrap up](https://www.hackingwithswift.com/read/19/8/wrap-up)

> I'll tell you what: I'm feeling tired and I didn't even have to learn anything to write this project – I can't imagine how tired you are! But please don't be too disheartened: this project builds the the bridge between JavaScript and Swift, and now that bridge is built you can add your own Swift functionality on top.
> 
> Some of the code isn't pleasant to work with, and certainly I wish iOS would just figure out text view insets automatically for keyboards, but you're through it now so your project is done. Even though this was a hard project, I did cut quite a few corners to make the code as easy as possible, so again I want to encourage you to try creating another extension and see how Apple's example code is different from mine.

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
> 1. Add a bar button item that lets users select from a handful of prewritten example scripts, shown using a UIAlertController – at the very least your list should include the example we used in this project.
>
> 2. You're already receiving the URL of the site the user is on, so use UserDefaults to save the user's JavaScript for each site. You should convert the URL to a URL object in order to use its host property.
>
> 3. For something bigger, let users name their scripts, then select one to load using a UITableView.

## :two: [Review - Project 19](https://www.hackingwithswift.com/review/hws/project-19-javascript-injection) 

### :boom: Quiz insights

> Action extensions appear inside Safari's UI.
> This makes it easy for users to discover them.
> 
> The keyboard frame can change many times while our app is running.
> The user can hide and show the QuickType bar as often as they want.
> 
> When loadItem(forTypeIdentifier:) completes it will call a closure so we can act on its data.
> This runs asynchronously so our code doesn't lock up Safari.
> 
> Our own preprocessing JavaScript runs before our Swift code.
> This is where we can send in any data about the page.
> 
> If a device has a home indicator at the bottom rather than a home button, we need to adjust its keyboard frame.
> We need to adjust our keyboard calculation by the safe area's bottom value.
> 
> NSValue exists because Objective-C couldn't put values like CGRect into arrays and dictionaries.
> It's a bit of a relic, but it's a relic we're stuck with for the time being.
> 
> When our Swift extension finishes we can send values back to JavaScript.
> Anything we send back is then made available to our action file.
> 
> The addObserver() method of NotificationCenter lets us watch for a particular notification.
> This lets us attach some code to run when a notification comes in.
> 
> Every iOS app has an Info.plist file.
> This contains fixed information like our language, version, and more.
> 
> NSDictionary is an Objective-C dictionary.
> The action APIs require this rather than a Swift-native dictionary.
> 
> You must ship an app if you want to ship an extension.
Extensions are shipped inside the parent app.

:question: *Is this still true with Safari extensions?* 

>The contentInset property of a UITextView determines how text is placed inside the view.
