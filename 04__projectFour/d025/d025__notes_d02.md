# *Day 25(2) • Thursday October 01, 2020*

_Continued_

## Adding an Observer

### Part I

> Apple's solution to this is huge. Apple's solution is powerful. And, best of all, Apple's solution is almost everywhere in its toolkits, so once you learn how it works you can apply it elsewhere. It's called **key-value observing (KVO)**, and it effectively lets you say, "please tell me when the property X of object Y gets changed by anyone at any time."
> 
> We're going to use KVO to watch the `estimatedProgress` property, and I hope you'll agree that it's useful. First, we add ourselves as an observer of the property on the web view by adding this to `viewDidLoad()`:

```swift
webView.addObserver(self, forKeyPath: #keyPath(`WKWebView`.estimatedProgress), options: .new, context: nil)
```

> The `addObserver()` method takes four parameters: 
> 1) **who the observer is** (we're the observer, so we use self), 
> 2) **what property we want to observe** (we want the `estimatedProgress` property of `WKWebView`), 
> 3) which **value we want** (we want the value that was just set, so we want the new one), 
> 4) and a **context value**.
> 
> `forKeyPath` and context bear a little more explanation. `forKeyPath` isn't named `forProperty` because it's not just about entering a property name.
> * You can actually specify a path: one property inside another, inside another, and so on. 
> 
> More advanced key paths can even add functionality, such as averaging all elements in an array!

So it's our relative pathway to the progress somewhere on a lower level?

> Swift has a special keyword, `#keyPath`, which works like the `#selector` keyword you saw previously: it allows the compiler to check that your code is correct – that the `WKWebView` class actually has an `estimatedProgress` property.
>
> context is easier: if you provide a unique value, that same **context value** gets sent back to you when you get your notification that the value has changed. 
> * This allows you to check the context to make sure it was your observer that was called.
> * There are some corner cases where specifying (and checking) a context is required to avoid bugs, but you won't reach them during any of this series.
> 
>> :warning: in more complex applications, all calls to `addObserver()` should be matched with a call to `removeObserver()` when you're finished observing – for example, when you're done with the view controller.

### Part II

> Once you have registered as an observer using KVO, you must implement a method called `observeValue()`. This tells you when an observed value has changed, so add this method now:

```swift
override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        progressView.progress = Float(webView.estimatedProgress)
    }
}
```

> As you can see _it's telling us which key path was changed,_ and it also **sends us back the context** we registered earlier so you can check whether this callback is for you or not.
> 
> In this project, all we care about is whether the keyPath parameter is set to `estimatedProgress` – that is, if the `estimatedProgress` value of the web view has changed. And if it has, we set the progress property of our progress view to the new `estimatedProgress` value.

### Optimisation

> Minor note: `estimatedProgress` is a `Double`, which as you should remember is one way of representing decimal numbers like 0.5 or 0.55555. Unhelpfully, `UIProgressView`'s progress property is a `Float`, which is another (lower-precision) way of representing decimal numbers. Swift doesn't let you put a `Double` into a `Float`, so we need to create a new `Float` from the `Double`.
> 
> If you run your project now, you'll see the progress view fills up with blue as the page loads.

## :two: [Refactoring for the win](https://www.hackingwithswift.com/read/4/5/refactoring-for-the-win)

>Our app has a fatal flaw, and there are two ways to fix it: double up on code, or refactor. Cunningly, the first option is nearly always the easiest, and yet counter-intuitively also the hardest.
>
>The flaw is this: we let users select from a list of websites, but once they are on that website they can get pretty much anywhere else they want just by following links. Wouldn't it be nice if we could check every link that was followed so that we can make sure it's on our safe list?
>
>One solution – doubling up on code – would have us writing the list of accessible websites twice: once in the `UIAlertController` and once when we're checking the link. This is extremely easy to write, but it can be a trap: you now have two lists of websites, and it's down to you to keep them both up to date. And if you find a bug in your duplicated code, will you remember to fix it in the other place too?
>
>The second solution is called refactoring, and it's effectively a rewrite of the code. The end result should do the same thing, though. The purpose of the rewrite is to make it more efficient, make it easier to read, reduce its complexity, and to make it more flexible. This last use is what we'll be shooting for: we want to refactor our code so there's a shared array of allowed websites.
>
>Up where we declared our two properties `webView` and `progressView`, add this:

```swift
var websites = ["apple.com", "hackingwithswift.com"]
```

>That's an array containing the websites we want the user to be able to visit.
>
>With that array, we can modify the web view's initial web page so that it's not hard-coded. In `viewDidLoad()`, change the initial web page to this:

```swift
let url = URL(string: "https://" + websites[0])!
webView.load(URLRequest(url: url))
```

>So far, so easy. The next change is to make our `UIAlertController` use the websites for its list of `UIAlertActions`. Go down to the `openTapped() `method and replace these two lines:

```swift
ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
```

>…with this loop:

```swift
for website in websites {
    ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
}
```