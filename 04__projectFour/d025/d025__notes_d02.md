# *Day 25(2) • Thursday October 01, 2020*

_Continued_

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