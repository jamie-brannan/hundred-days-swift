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

### Dynamic list

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

### Decide policy

>That will add one `UIAlertAction` object for each item in our array. Again, not too complicated.
>
>The final change is something new, and it belongs to the `WKNavigationDelegate` protocol. If you find space for a new method and start typing "web" you'll see the list of `WKWebView`-related code completion options. Look for the one called `decidePolicyFor` and let Xcode fill in the method for you.
>
>**This delegate callback allows us to decide whether we want to allow navigation to happen or not every time something happens.** 
> * We can check which part of the page started the navigation, we can see whether it was triggered by a link being clicked or a form being submitted, or, in our case, we can check the URL to see whether we like it.
>
>Now that we've implemented this method, it expects a response: **_should we load the page or should we not?_**

It'll deny it before any request is sent?

>When this method is called, you get passed in a parameter called `decisionHandler`. This actually holds a function, ::arrow_right: which means if you "call" the parameter, you're actually calling the function.

:question: *When you get a function as a parameter what is it called in CS?*
* JS "double arrow"?
* "a magic function?

>In project 2 I talked about **closures**: chunks of code that _you can pass into a function like a variable and have executed at a later date._

**closures** : *(swift)* chunks of code you can pass into a function like a variable and have executed at a later date.

>
>This `decisionHandler` is also a closure, except it's the other way around – rather than giving someone else a chunk of code to execute, you're being given it and are required to execute it.
>
>And make no mistake: you are required to do something with that `decisionHandler` closure. That might make sound an extremely complicated way of returning a value from a method, and that's true – but it's also underestimating the power a little! 
>* Having this `decisionHandler` variable/function means you can show some user interface to the user "Do you really want to load this page?" and call the closure when you have an answer.
>
>You might think that already sounds complicated, but I’m afraid there’s one more thing that might hurt your head. Because you might call the `decisionHandler` closure _straight away, or you might call it later on_ (perhaps after asking the user what they want to do), Swift considers it to be an escaping closure. 
>* That is, the closure has the potential to escape the current method, and be used at a later date. We won’t be using it that way, but it has the potential and that’s what matters.
>
>Because of this, Swift wants us to add the special keyword `@escaping` when specifying this method, so we’re acknowledging that the closure might be used later. You don’t need to do anything else – just add that one keyword, as you’ll see in the code below.
>
>So, we need to evaluate the `URL` to see whether it's in our safe list, then call the `decisionHandler` with a negative or positive answer. Here's the code for the method:

```swift
func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url

    if let host = url?.host {
        for website in websites {
            if host.contains(website) {
                decisionHandler(.allow)
                return
            }
        }
    }

    decisionHandler(.cancel)
}
```

>There are some easy bits, but they are outweighed by the hard bits so let's go through every line in detail to make sure:
>
>* **First**, we set the constant `url` to be equal to the `URL` of the navigation. This is just to make the code clearer.
>* **Second**, we use `if let` syntax to unwrap the value of the optional `url.host`. Remember I said that `URL` does a lot of work for you in parsing URLs properly? Well, here's a good example: this line says, "if there is a host for this URL, pull it out" – and by "host" it means "website domain" like apple.com. Note: we need to unwrap this carefully because not all URLs have hosts.
>* **Third**, we loop through all sites in our safe list, placing the name of the site in the `website` variable.
>* **Fourth**, we use the `contains() `String method to see whether each safe website exists somewhere in the host name.
>* **Fifth**, if the website was found then we call the decision handler with a positive response - we want to allow loading.
>* **Sixth**, if the website was found, after calling the `decisionHandler` we use the `return` statement. This means "exit the method now."
>* **Last**, if there is no host set, or if we've gone through all the loop and found nothing, we call the decision handler with a negative response: cancel loading.
>
>You give the `contains() `method a string to check, and it will return true if it is found inside whichever string you used with `contains()`. You've already met the `hasPrefix()` method in project 1, but `hasPrefix() `isn't suitable here because our safe site name could appear anywhere in the URL. For example, slashdot.org redirects to m.slashdot.org for mobile devices, and `hasPrefix()` would fail that test.
>
>The `return` statement is new, but it's one you'll be using a lot from now on. It exits the method immediately, executing no further code. If you said your method `returns` a value, you'll use the return statement to return that value.
>
>Your project is complete: press Cmd+R to run the finished app, and enjoy!

## :three: [Wrap up](https://www.hackingwithswift.com/read/4/6/wrap-up)

### Review of what you learned

#### :boom: Quiz insights

* `loadView()` is called first, and it's where you create your view; `viewDidLoad()` is called second, and it's where you configure the view that was loaded.
* Calling `sizeToFit()` on a view makes it take up the correct amount of space for its content.
  * UIKit will measure the contents of the view, then adjust its size so that all the content is visible.
* We can use #selector to point to a specific method in a different object.
  * You can use #selector to point to a method in any object, as long as that method is marked @objc.
* Delegation allows one object to respond on behalf of another.
  * Delegation is what allows us to customize the behavior of built-in types without having to sub-class them.
* If you want to, you can provide a context value for your key-value observers.
  * This context is just a value that's sent back to you when your observer code is triggered.
* Conforming to a protocol means adding the properties and methods required by that protocol.
  * Protocol conformance allows Swift to check at compile time that you have implemented the properties and methods you said you would.
* A web view's navigation delegate can control which pages should be loaded.
  * Navigation delegates can decide whether to allow or deny individual requests.
* You can conform to as many protocols as you want.
  * Although it's not a good idea, you can make one type conform to 10, 50, or even more protocols if you wanted.
* Flexible spaces automatically take up all available remaining space.
  * Flexible spaces allow us to space buttons out neatly, either by pushing them to one side or by adding margin between them.
* All view controllers have a toolbarItems property.
  * This property is used to show buttons in a toolbar when the view controller is inside a navigation controller.
* Progress views show a colored bar indicating how much of a task is complete.
  * Progress views help us show users approximately how far through a task is.
* ~~URLs always have a host.~~
  * URLs can also point to local files, which don't have a host.

9/12 score :woman_shrugging:

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:
>
  - [x]  If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked.

:pushpin: [**Dillon MCE**](https://dillon-mce.com/100-Days-026/) : *100 Days of Swift, 25*

```swift
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url
    
    if let host = url?.host {
      for website in approvedWebsites {
        if host.contains(website) {
          decisionHandler(.allow)
          return
        }
      }
      siteDeniedAlert(for: host)
    }
    
    decisionHandler(.cancel)
  }

  func siteDeniedAlert(for host: String) {
    let ac = UIAlertController(title: "Sorry", message: "\(host) site is not currently approved", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(ac, animated: true)
  }
```

- [x]  Try making two new toolbar items with the titles **Back** and **Forward**. You should make them use `webView.goBack` and `webView.goForward`.

```swift
    let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(webView.goBack))
    let forward = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(webView.goForward))

    toolbarItems = [back, forward, spacer, progressButton, spacer, refresh]
```

>   - [ ]  For more of a challenge, try changing the initial view controller to a table view like in project 1, where users can choose their website from a list rather than just having the first in the array loaded up front.
>
>Tip: Once you have completed project 5, you might like to return here to add in the option to load the list of websites from a file, rather than having them hard-coded in an array.