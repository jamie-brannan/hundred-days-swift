# Day 24 (1) • Thursday September 24, 2020

>Alexis Ohanian, the founder of Reddit, once said “to join in the industrial revolution, you needed to open a factory; in the Internet revolution, you need to open a laptop.” Well, thanks to iOS we have something even easier: you just need to tap a button on your iPhone.
>
>Apple gives us the ability to render any kind of web content just like Safari does, all powered through its open source WebKit framework. This is cross-platform, meaning that we can use it on macOS and iOS just the same, and it’s also blazingly fast as you’ll see in a moment.
>
>In this project we’re going to build a simple web browser using WebKit. The whole thing takes only about 60 lines of code once you remove comments and empty lines, which shows you just how easy to use WebKit is.
>
>Today you have three topics to work through, and you’ll meet `WKWebView`, action sheets, and more.
>
>* Setting up
>* Creating a simple browser with `WKWebView`
>* Choosing a website: `UIAlertController` action sheets
>
>Remember to tell others about your progress – it keeps you engaged in learning, and you’ll be back for more tomorrow!

## :one:  [Setting up](https://www.hackingwithswift.com/read/4/1/setting-up) 

>In this project you're going to build on your new knowledge of `UIBarButtonItem` and `UIAlertController` by producing a simple web browser app. Yes, I realize this is another easy project, but learning is as much about tackling new challenges as going over what you've already learned.
>
>To sweeten the deal, I'm going to use this opportunity to teach you lots of new things: `WKWebView` (Apple's extraordinary web widget), `UIToolbar` (a toolbar component that holds `UIBarButtonItem`s), `UIProgressView`, delegation, key-value observing, and how to create your views in code. Plus, this is the last easy app project, so enjoy it while it lasts!
>
>To get started, create a new Xcode project using the Single View App template, and call it **Project4**. Make sure Swift is selected for the language, then save the project on your desktop.
>
>Open up `Main.storyboard`, select the view controller, and choose Editor > Embed In > Navigation Controller – that's our storyboard finished. Nice!