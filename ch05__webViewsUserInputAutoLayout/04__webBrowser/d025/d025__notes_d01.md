# *Day 25(1) • Thursday October 01, 2020*

- [*Day 25(1) • Thursday October 01, 2020*](#day-251--thursday-october-01-2020)
  - [:one: Monitoring page loads `UIToolbar` and ``UIProgressView``](#one-monitoring-page-loads-uitoolbar-and-uiprogressview)
    - [Flexible Space](#flexible-space)
    - [Progress bar](#progress-bar)
  - [Adding an Observer](#adding-an-observer)
  - [:two: Refactoring for the win](#two-refactoring-for-the-win)

>If there’s one Martin Fowler quote that I love, it’s this: “I'm not a great programmer; I'm just a good programmer with great habits.” Today we need to add some more functionality to our project, but we’re faced with a choice: do we take the easy route or take the harder route?

Habits habits habits.

>As you’ll see, sometimes the “easy” route ends up being hard in the long term, because we need to maintain that code for a long time. The harder route takes a little rewriting of our code, but it’s one of many steps you’ll take towards having better coding habits – an important skill to have!
>
>Today you have two topics to work through, and you’ll meet `UIProgressView`, key-value observing, and more.

* [Monitoring page loads `UIToolbar` and `UIProgressView`](https://www.hackingwithswift.com/read/4/4/monitoring-page-loads-uitoolbar-and-`uiprogressview`)
* [Refactoring for the win](https://www.hackingwithswift.com/read/4/5/refactoring-for-the-win)

## :one: [Monitoring page loads `UIToolbar` and ``UIProgressView``](https://www.hackingwithswift.com/read/4/4/monitoring-page-loads-uitoolbar-and-`uiprogressview`)

>Now is a great time to meet two new `UIView` subclasses: `UIToolbar` and `UIProgressView`. `UIToolbar` holds and shows a collection of `UIBarButtonItem` objects that the user can tap on. 
>
>We already saw how each view controller has a `rightBarButton` item, so a `UIToolbar` is like having a whole bar of these items. 
>
>`UIProgressView` is a colored bar that shows how far a task is through its work, sometimes called a "progress bar."
>
>The way we're going to use `UIToolbar` is quite simple: all view controllers automatically come with a `toolbarItems` array that automatically gets read in when the view controller is active inside a `UINavigationController`.
>
>This is very similar to the way `rightBarButtonItem` is shown only when the view controller is active. 
>
>**All we need to do is set the array**, _then tell our navigation controller to show its toolbar, and it will do the rest of the work for us._
>
>**We're going to create two `UIBarButtonItem`s at first**, although one is special because it's a flexible space. This is a unique `UIBarButtonItem` type that acts like a spring, pushing other buttons to one side until all the space is used.

Okay so we're creating...
* a flexible/springy pushing buttons `UIBarButtonItem` to slide until all space is use
* another `UIBarButtonItem` ?

>In `viewDidLoad()`, put this new code directly below where we set the `rightBarButtonItem`:

```swift
let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

toolbarItems = [spacer, refresh]
navigationController?.isToolbarHidden = false
```

### Flexible Space

>The **first line**is new, or at least part of it is: we're creating a new bar button item using the special system item type `.flexibleSpace`, which creates a flexible space. 
>* It doesn't need a target or action because it can't be tapped. 
>
>The **second line** you've seen before, although now it's calling the `reload()` method on the web view rather than using a method of our own.
>
>The **last two lines are new**: the first creates an array containing the flexible space and the refresh button, then sets it to be our view controller's `toolbarItems` array. The second sets the navigation controller's `isToolbarHidden` property to be false, _so the toolbar will be shown_ – and its items will be loaded from our current view.

So we're revealing the Toolbar in the webview, and are making sure that the reload button appears and space is flexible.

>That code will compile and run, and you'll see the refresh button neatly aligned to the right – that's the effect of the flexible space automatically taking up as much room as it can on the left.

:white_check_mark: 

### Progress bar

>The next step is going to be to add a `UIProgressView` to our toolbar, which will show how far the page is through loading. However, this requires two new pieces of information:
>
>* You can't just add random `UIView` subclasses to a `UIToolbar`, or to the `rightBarButtonItem` property. Instead, you need to **_wrap them_** in a special `UIBarButtonItem`, and use that instead.

Does wrapping them always mean that it "englobes" them.

>* Although `WKWebView` tells us how much of the page has loaded using its `estimatedProgress` property, the `WKNavigationDelegate` system doesn't tell us when this value has changed. So, we're going to ask iOS to tell us using a powerful technique called **key-value observing**, or KVO.

**key-value observing** : *(iOS)* mechanism that allows objects to be notified of changes to specified properties of other objects
* :pushpin: [**Apple Docs**](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html) : *Introduction to Key-Value Observing Programming Guide*

>First, **let's create the progress view and place it** inside the bar button item. Begin by declaring the property at the top of the ViewController class next to the existing `WKWebView` property:

```swift
var progressView: UIProgressView!
```

> Now place this code directly before the let spacer = line in `viewDidLoad()`:

```swift
progressView = UIProgressView(progressViewStyle: .default)
progressView.sizeToFit()
let progressButton = UIBarButtonItem(customView: progressView)
```

> All three of those lines are new, so let's go over them:

> 1) The **first line** creates a new `UIProgressView` _instance_, giving it the default style. 
>> There is an alternative style called `.bar`, which doesn't draw an unfilled line to show the extent of the progress view, but the default style looks best here.
> 2) The **second line** tells the progress view to set its layout size so that it fits its contents fully.
> 3) The **last line** creates a new `UIBarButtonItem` using the `customView` parameter, which is where we wrap up our `UIProgressView` in a `UIBarButtonItem` so that it can go into our toolbar.

:white_check_mark: pretty straight forward.

> With the new `progressButton` item created, we can put it into our toolbar items anywhere we want it. The _existing spacer will automatically make itself smaller_ to give space to the progress button, so I'm going to modify my `toolbarItems` array to this:

```swift
toolbarItems = [progressButton, spacer, refresh]
```

> That is, progress view first, then a space in the center, then the refresh button on the right.

So it'll respect the order that the appear in the array.

> If you run the app now, you'll just see a thin gray line for our progress view – that's because it's default value is 0, so there's nothing colored in. Ideally we want to set this to match our webView's `estimatedProgress` value, which is a number from 0 to 1, but `WKNavigationDelegate` doesn't tell us when this value has changed.

## Adding an Observer

> Apple's solution to this is huge. Apple's solution is powerful. And, best of all, Apple's solution is almost everywhere in its toolkits, so once you learn how it works you can apply it elsewhere. It's called **key-value observing (KVO)**, and it effectively lets you say, "please tell me when the property X of object Y gets changed by anyone at any time."
> 
> We're going to use KVO to watch the `estimatedProgress` property, and I hope you'll agree that it's useful. First, we add ourselves as an observer of the property on the web view by adding this to `viewDidLoad()`:

```swift
webView.addObserver(self, forKeyPath: #keyPath(`WKWebView`.estimatedProgress), options: .new, context: nil)
```

> The `addObserver()` method takes four parameters: who the observer is (we're the observer, so we use self), what property we want to observe (we want the `estimatedProgress` property of `WKWebView`), which value we want (we want the value that was just set, so we want the new one), and a context value.
> 
> `forKeyPath` and context bear a little more explanation. `forKeyPath` isn't named forProperty because it's not just about entering a property name. You can actually specify a path: one property inside another, inside another, and so on. More advanced key paths can even add functionality, such as averaging all elements in an array! Swift has a special keyword, #keyPath, which works like the #selector keyword you saw previously: it allows the compiler to check that your code is correct – that the `WKWebView` class actually has an `estimatedProgress` property.
> 
> context is easier: if you provide a unique value, that same context value gets sent back to you when you get your notification that the value has changed. This allows you to check the context to make sure it was your observer that was called. There are some corner cases where specifying (and checking) a context is required to avoid bugs, but you won't reach them during any of this series.
> 
> Warning: in more complex applications, all calls to `addObserver()` should be matched with a call to `removeObserver()` when you're finished observing – for example, when you're done with the view controller.
> 
> Once you have registered as an observer using KVO, you must implement a method called `observeValue()`. This tells you when an observed value has changed, so add this method now:

```swift
override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        progressView.progress = Float(webView.estimatedProgress)
    }
}
```

> As you can see it's telling us which key path was changed, and it also sends us back the context we registered earlier so you can check whether this callback is for you or not.
> 
> In this project, all we care about is whether the keyPath parameter is set to `estimatedProgress` – that is, if the `estimatedProgress` value of the web view has changed. And if it has, we set the progress property of our progress view to the new `estimatedProgress` value.
> 
> Minor note: `estimatedProgress` is a Double, which as you should remember is one way of representing decimal numbers like 0.5 or 0.55555. Unhelpfully, `UIProgressView`'s progress property is a Float, which is another (lower-precision) way of representing decimal numbers. Swift doesn't let you put a Double into a Float, so we need to create a new Float from the Double.
> 
> If you run your project now, you'll see the progress view fills up with blue as the page loads.

## :two: [Refactoring for the win](https://www.hackingwithswift.com/read/4/5/refactoring-for-the-win)