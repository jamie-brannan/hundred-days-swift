# *Day 32 • Thursday November 05, 2020*

- [*Day 32 • Thursday November 05, 2020*](#day-32--thursday-november-05-2020)
  - [:one:  What you learned](#one--what-you-learned)
  - [:two:  Key Points](#two--key-points)
  - [:three:  Challenge](#three--challenge)

>It’s time for another consolidation day, because we’ve covered a lot of ground in the first three topics and it’s important you review them if you want them to stick in your head.
>
>I know I’ve said it before, but I just want to re-iterate the importance of going over what you learned. Chris Bosh, an NBA All-Star basketball player, said _“every athlete knows that you get good by practicing, by repeating the same moves until you achieve your goal”_– apparently when he was in high school he wouldn’t leave practice until he scored ten free throws in a row.
>
>The value of repetition is that it forces you to go back to something and look at it with fresh eyes – to decide for yourself whether you really understand it, while also transferring short-term knowledge into long-term muscle memory. You’re retraining your brain so you know to instinctively reach for a table view controller or an alert controller to solve specific problems you face in the future.
>
>**You’ll also be creating another complete app from scratch today.** Once again this is about giving you free rein to solve problems however you see fit, to help you combat blank page paralysis.

:tada:

>Today you have three topics to work through, one of which of is your challenge.
>
>* What you learned
>* Key points
>* Challenge
>
>**Note**: Don’t worry if you don’t complete challenges in the day they were assigned – in future days you’ll find you have some time to spare here and there, so challenges are something you can return back to in the future.

## :one:  [What you learned](https://www.hackingwithswift.com/guide/3/1/what-you-learned) 

>Project 4 showed how easy it is to build complex apps: **Apple’s WebKit framework** contains a complete web browser you can embed into any app that needs HTML to be displayed. That might be a small snippet you’ve generated yourself, or it might be a complete website as seen in project 4.
>
>After that, project 5 showed you how to build your second game, while also sneaking in a little more practice with `UITableViewController`. Starting from project 11 we’ll be switching to SpriteKit for games, but there are lots of games you can make in `UIKit` too.
>
>WebKit is the second **exteral framework** we’ve nused, after the Social framework in project 3. These frameworks always deliver lots of complex functionality grouped together for one purpose, but you also learned lots of other things too:
>
>* Delegation. We used this in project 4 so that WebKit events get sent to our `ViewController` class so that we can act on them.
>
>* We used `UIAlertController` with its `.actionSheet` style to present the user with options to choose from. We gave it a `.cancel` button without a handler, which dismisses the options.
>
>* You saw you can place `UIBarButtonItems` into the `toolbarItems` property, then have a `UIToolbar` shown by the navigation controller. We also used the `.flexibleSpace` button type to make the layout look better.
>
>* You met Key-Value Observing, or KVO, which we used to update the loading progress in our web browser. This lets you monitor any property in all of iOS and be notified when it changes.
>
>* You learned how to load text files from disk using `contentsOf`.
>
>* We added a text field to `UIAlertController` for the first time, then read it back using `ac?.textFields?[0]`. We’ll be doing this in several other projects in this series.
>
>* You dipped your toes into the world of closures once again. These are complicated beasts when you’re learning, but at this point in your Swift career just think of them as functions you can pass around in variables or as parameters to other functions.
>
>* You worked with some methods for string and array manipulation: `contains()`, `remove(at:)`, `firstIndex(of:)`.
>
>On top of that, we also took a deep-dive into the world of Auto Layout. We used this briefly in projects 1 and 2, but you’ve now learned more ways to organize your designs: Visual Format Language and anchors. There are other ways yet to come, and soon you’ll start to find you prefer one method over another – and that’s OK. I’m showing you them all so you can find what works best for you, and we all have our own preferences!

## :two:  [Key Points](https://www.hackingwithswift.com/guide/3/2/key-points) 

>There are three pieces of code I’d like to revisit because they carry special significance.
>
>First, let’s consider the `WKWebView` from project 4. We added this property to the view controller:

```swift
var webView: WKWebView!

override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
}
```

>The `loadView()` method is often not needed, because most view layouts are loaded from a storyboard. However, it’s common to write part or all of your user interface in code, and for those times you’re likely to want to replace `loadView()` with your own implementation.
>
>If you wanted a more complex layout – perhaps if you wanted the web view to occupy only part of the screen – then this approach wouldn’t have worked. Instead, you would need to load the normal storyboard view then use `viewDidLoad()` to place the web view where you wanted it.
>
>As well as overriding the `loadView()` method, project 4 also had a `webView` property. This was important, because as far as Swift is concerned the regular `view` property is just a `UIView`.
>
>Yes, we know it’s actually a `WKWebView`, but Swift doesn’t. So, when you want to call any methods on it like reload the page, 
>* Swift won’t let you say `view.reload()` because as far as it’s concerned `UIView` doesn’t have a `reload()` method.

:bulb: but there must be a refresh button of somekind

>That’s what the property solves: it’s like a permanent typecast for the `view`, so that whenever we need to manipulate the web view we can use that property and Swift will let us.
>
>The second interesting piece of code is this, taken from project 5:

```swift
if let startWords = try? String(contentsOf: startWordsURL) {
    allWords = startWords.components(separatedBy: "\n")
}
```

>This combines `if let` and `try?` in the same expression, which is something you’ll come across a lot. **The `contentsOf` initializer for strings lets you load some text from disk.** 
>* If it succeeds you’ll get the text back, but if it fails Swift will complain loudly by throwing an exception.
>
>You learned about `try`, `try!`, and `try?` some time ago, but I hope now you can see why it’s helpful to have all three around. 
>
>What `try?` does is say, “instead of throwing an exception, just return `nil` if the operation failed.” 
>
>And so, rather than `contentsOf` returning a `String` it will actually return a `String?` – it might be some text, or it might be `nil`. That’s where `if let` comes in: it checks the return value from `contentsOf` and, if it finds valid text, executes the code inside the braces.
>
>The last piece of code I’d like to review is this:

```swift
view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
```

>I think that – in just one line of code – demonstrates the **advantages** of using **Visual Format Language**: :arrow_right: _it lines up five labels, one above the other, each with equal height, with a small amount of space between them, and 10 or more points of space at the end._

:heavy_plus_sign:

>That line also demonstrates the **disadvantage** of Visual Format Language: it has a tendency to look like line noise! 
>* You need to read it very carefully, sometimes jumping back and forward, in order to unpick what it’s trying to do. 

:heavy_minus_sign:

>* VFL is the quickest and easiest way to solve many Auto Layout problems in an expressive way, but as you progress through this course you’ll **learn alternatives** such as `UIStackView` that can do the same thing without the complex syntax.

Looking forward to it!

## :three:  [Challenge](https://www.hackingwithswift.com/guide/3/3/challenge) 

>It’s time to put your skills to the test by making your own complete app from scratch. This time your job is to **create an app that lets people create a shopping list** by adding items to a table view.

Nice easy concept!

:hammer: Going to name is **Shopping List** app.

>The best way to tackle this app is to think about how you build project 5: it was **a table view** that showed items from an array, and we used a `UIAlertController` with a text field to let users enter free text that got appended to the array. 

  - [x]  make a table view
  - [x]  alert controller with text field
  - [x]  append submit to the table view

>That forms the foundation of this app, except this _time you don’t need to validate items that get added_ – if users enter some text, assume it’s a real product and add it to their list.
>
>For **bonus points**, **add a left bar button item that clears the shopping list** 
>* – _what method should be used afterwards to make the table view reload all its data?_

  - [x]  add a clear bar button item

>Here are some hints in case you hit problems:
>
>
>* Remember to change `ViewController` to build on `UITableViewController`, then change the storyboard to match.
>
>* Create a `shoppingList` property of type `[String]` to hold all the items the user wants to buy.
>
>* Create your `UIAlertController` with the style `.alert`, then call `addTextField()` to let the user enter text.
>
>* When you have a new shopping list item, make sure you `insert()` it into your `shoppingList` array before you call the `insertRows(at:) `method of your table view – your app will crash if you do this the wrong way around.

>You might be tempted to try to use `UIActivityViewController` to **share the finished shopping list by email,** but if you do that you’ll hit a problem: you have an array of strings, not a single string.
>
>There’s _a special method that can create one string from an array, by stitching each part together using a separator you provide_. I’ll be going into it in project 8, but if you’re keen to try it now here’s some code to get you started:

```swift
let list = shoppingList.joined(separator: "\n")
```

>That will create a new list constant that is a regular string, with each shopping list item separated by “`\n`” – that’s Swift’s way of representing a new line.

  - [x]  make a share list by email bottom button action

Did it! :tada: