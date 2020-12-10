# *Day 34 • Thursday November 26, 2020*

- [*Day 34 • Thursday November 26, 2020*](#day-34--thursday-november-26-2020)
  - [:one: Rendering a petition loadHTMLString](#one-rendering-a-petition-loadhtmlstring)
  - [:two: Finishing touches didFinishLaunchingWithOptions](#two-finishing-touches-didfinishlaunchingwithoptions)
  - [:arrow_right_hook: :gift: Wrap up the day](#arrow_right_hook-gift-wrap-up-the-day)

>Although I love writing Swift, you’ll never hear me say stuff like “it’s the One True Language.” Programming is a massive landscape of ideas, and there’s lots to learn and enjoy outside of Swift.

:rainbow: yup!

>One practice that makes me particularly sad is sneering at web development languages like HTML and JavaScript. You’ll see folks saying that HTML isn’t really a language, or brag about removing all traces of JavaScript from their site as if it’s somehow a pollutant.
>
>The simple truth is that having a working knowledge of these web languages can benefit most developers, and today you’ll see that in action because we’re going to be using a little bit of HTML inside Swift.
>
>Now, as you’ll see I’m not really in a position to teach HTML as part of this course, so we’re going to do the least required to make our formatting work. Trust me, this is a good thing – Mike Davidson, the ex-VP of design at Twitter once said that “writing old-school HTML code was never very much fun but now it's getting downright tedious for most people.”
>
>**This goes double for putting HTML code directly inside Swift strings**, _which is why server-side Swift frameworks usually have separate systems for generating HTML_. 
>* Here, though, we’ll keep it nice and short so we can focus on learning new iOS techniques!
>
>Today you have two topics to work through, and you’ll learn about injecting HTML into a web view, `UIStoryboard`, adding tabs to a tab bar controller in code, and more.
>
>If you’re keen to learn more about the way web views scale pages down to fit small screens, check out this article: [Using the viewport meta tag to control layout on mobile browsers](https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag   ).

## :one: [Rendering a petition loadHTMLString](https://www.hackingwithswift.com/read/7/4/rendering-a-petition-loadhtmlstring) 

>After all the JSON parsing, it's time for something easy: we need to create a detail view controller class so that it can draw the petition content in an attractive way.
>
>The easiest way for rendering complex content from the web is nearly always to use a `WKWebView`, and we're going to use the same technique from project 4 to create a `DetailViewController` that contains a web view.
>
>Go to the File menu and choose New > File, then choose iOS > Source > Cocoa Touch Class. Click Next, name it “DetailViewController”, make it a subclass of “UIViewController”, then click Next and Create.
>
>Replace all the `DetailViewController` code with this:

```swift
import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```


>This is almost identical to the code from project 4, but you'll notice I've added a `detailItem` property that will contain our `Petition` instance.
>
:white_check_mark: added

>That was the easy bit. The hard bit is that **we can't just drop the petition text into the web view**, because it will probably look tiny. 
>* Instead, we need to wrap it in some HTML, which is a whole other language with its own rules and its own complexities.
>
>Now, this series isn't called "Hacking with HTML," so I don't intend to go into much detail here. However, I will say that the HTML we're going to use tells iOS that
>* the page fits mobile devices, 
>* and that we want the font size to be 150% of the standard font size. 
> 
>All that HTML will be combined with the `body` value from our petition, then sent to the web view.
>
>Place this in `viewDidLoad()`, directly beneath the call to `super.viewDidLoad()`:

```swift
guard let detailItem = detailItem else { return }

let html = """
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style> body { font-size: 150%; } </style>
</head>
<body>
\(detailItem.body)
</body>
</html>
"""

webView.loadHTMLString(html, baseURL: nil)
```

>That guard at the beginning unwraps `detailItem` into itself if it has a value, which makes sure we exit the method if for some reason we didn’t get any data passed into the detail view controller.
>
>Note: **It’s very common to unwrap variables using the same name**, rather than create slight variations. In this case we could have used `guard let unwrappedItem = detailItem`, but that isn’t any better.

yup this is what we do often in our code but not always

>I've tried to make the HTML as clear as possible, but if you don't care for HTML don't worry about it. What matters is that there's a Swift string called `html` that contains everything needed to show the page, and that's passed in to the web view's `loadHTMLString()` method so that it gets loaded. This is different to the way we were loading HTML before, because we aren't using a website here, just some custom HTML.
>
>That's it for the detail view controller, it really is that simple. However, we still need to connect it to the table view controller by implementing the `didSelectRowAt` method.
>
>Previously we used the `instantiateViewController()` method to load a view controller from `Main.storyboard`, **but in this project `DetailViewController` isn’t in the storyboard** – it’s just a free-floating class. 
>* This makes `didSelectRowAt` easier, because _it can load the class directly rather than loading the user interface from a storyboard._
>
>So, add this new method to your `ViewController` class now:

```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
}
```
>Go ahead and run the project now by pressing Cmd+R or clicking play, then tap on a row to see more detail about each petition. Some petitions don’t have detail text, but most do – try a few and see what you can find.

Omg some of these are so wacky. Great API choice! :rocket:

## :two: [Finishing touches didFinishLaunchingWithOptions](https://www.hackingwithswift.com/read/7/5/finishing-touches-didfinishlaunchingwithoptions) 

>Before this project is finished, we're going to make two changes. First, we're going to add another tab to the `UITabBarController` that will show popular petitions, and second we're going to make our loading code a little more resilient by _adding error messages_.
>
>As I said previously, **we can't really put the second tab into our storyboard** because both tabs will host a `ViewController` and doing so would require us to duplicate the view controllers in the storyboard. You can do that if you really want, but please don't – it's a maintenance nightmare!
>
>Instead, we're going to leave our current storyboard configuration alone, then create the second view controller using code. This isn't something you've done before, but it's not hard and we already took the first step, as you'll see.
>
>Open the file AppDelegate.swift. This has been in all our projects so far, but it's not one we've had to work with until now. Look for the `didFinishLaunchingWithOptions` method, which should be at the top of the file. This gets called by iOS when the app has finished loading and is ready to be used, and we're going to hijack it to insert a second `ViewController` into our tab bar.

:white_check_mark: Found

>It should already have some default Apple code in there, but we're going to add some more just before the `return true` line:

```swift
if let tabBarController = window?.rootViewController as? UITabBarController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
    vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
    tabBarController.viewControllers?.append(vc)
}
```

>Every line of that is new, so let's dig in deeper:
>
>* Our storyboard automatically creates a window in which all our view controllers are shown. **This window needs to know what its initial view controller is, and that gets set to its `rootViewController` property.** This is all handled by our storyboard.

uhhhh but :red_circle: `Cannot find 'window' in scope`?
* added `var window: UIWindow?`

>* In the Single View App template, the root view controller is the `ViewController`, but we embedded ours inside a navigation controller, then embedded that inside a tab bar controller. So, for us the root view controller is a `UITabBarController`.
>
>* We need to **create a new `ViewController` by hand**, which first means **getting a reference** to our `Main.storyboard` file. This is done using the `UIStoryboard` class, as shown. You don't need to provide a bundle, because **`nil` means "use my current app bundle."**

I guess there's "pointers" back to this making it possible?

>* We create our view controller using the `instantiateViewController()` method, passing in the storyboard ID of the view controller we want. Earlier we set our navigation controller to have the storyboard ID of "NavController", so we pass that in.

Ouups I didn't seem to have done this before.

>* We create a `UITabBarItem` object for the new view controller, giving it the "Top Rated" icon and the tag 1. That tag will be important in a moment.
>
>* We add the new view controller to our tab bar controller's `viewControllers` array, which will cause it to appear in the tab bar.
>
>So, the code creates a duplicate `ViewController` wrapped inside a navigation controller, gives it a new tab bar item to distinguish it from the existing tab, then adds it to the list of visible tabs. This lets us use the same class for both tabs without having to duplicate things in the storyboard.
>
>The reason we gave a tag of 1 to the new `UITabBarItem` is because it's an easy way to identify it. Remember, both tabs contain a `ViewController`, which means the same code is executed. Right now that means both will download the same JSON feed, which makes having two tabs pointless. But if you modify `urlString` in ViewController.swift’s `viewDidLoad()` method to this, it will work much better:

```swift
let urlString: String

if navigationController?.tabBarItem.tag == 0 {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
} else {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
}
```
>That adjusts the code so that the first instance of `ViewController` loads the original JSON, and the second loads only petitions that have at least 10,000 signatures. Once again I’ve provided cached copies of the Whitehouse API data in case it changes or goes away in the future – use whichever one you prefer.
>
>The project is almost done, but we're going to make one last change. Our current loading code isn't very resilient: we have a couple of `if` statements checking that things are working correctly, but no `else` statements showing an error message if there's a problem.
>
>This is easily fixed by adding a new `showError()` method that creates a `UIAlertController` showing a general failure message:

```swift
func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```

>You can now adjust the JSON downloading and parsing code to call this error method everywhere a condition fails, like this:

```swift
if let url = URL(string: urlString) {
    if let data = try? Data(contentsOf: url) {
        parse(json: data)
    } else {
        showError()
    }
} else {
    showError()
}
```

>Alternatively we could rewrite this to be a little cleaner by inserting `return` after the call to `parse()`. This means that the method would exit if parsing was reached, so we get to the end of the method it means parsing wasn’t reached and we can show the error. Try this instead:

```swift
if let url = URL(string: urlString) {
    if let data = try? Data(contentsOf: url) {
        parse(json: data)
        return
    }
}

showError()
```

>Both approaches are perfectly valid – do whichever you prefer.
>
>Regardless of which you opt for, now that error messages are shown when the app hits problems we’re done – good job!

It runs but there is not a second tab? :thinking:

## :arrow_right_hook: :gift: Wrap up the day

Huge issue on going because there's Scene Deleguate now : :pushpin: [**StackOverFlow**](https://stackoverflow.com/questions/58084127/ios-13-swift-set-application-root-view-controller-programmatically-does-not) : *iOS 13 Swift set application root view controller programmatically does not work*

* delete `SceneDelegate.swift`
* delete blocks concerning it within `AppDelegate`
* remove `ApplicationSceneManifest` node within `Info.plist` 