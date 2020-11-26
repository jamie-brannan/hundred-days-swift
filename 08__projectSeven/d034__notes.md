# *Day 34 • Thursday November 26, 2020*

- [*Day 34 • Thursday November 26, 2020*](#day-34--thursday-november-26-2020)
  - [:one: Rendering a petition loadHTMLString](#one-rendering-a-petition-loadhtmlstring)
  - [:two: Finishing touches didFinishLaunchingWithOptions](#two-finishing-touches-didfinishlaunchingwithoptions)

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
>That was the easy bit. The hard bit is that we can't just drop the petition text into the web view, because it will probably look tiny. Instead, we need to wrap it in some HTML, which is a whole other language with its own rules and its own complexities.
>
>Now, this series isn't called "Hacking with HTML," so I don't intend to go into much detail here. However, I will say that the HTML we're going to use tells iOS that the page fits mobile devices, and that we want the font size to be 150% of the standard font size. All that HTML will be combined with the `body` value from our petition, then sent to the web view.
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
>Note: It’s very common to unwrap variables using the same name, rather than create slight variations. In this case we could have used `guard let unwrappedItem = detailItem`, but that isn’t any better.
>
>I've tried to make the HTML as clear as possible, but if you don't care for HTML don't worry about it. What matters is that there's a Swift string called `    ` that contains everything needed to show the page, and that's passed in to the web view's `loadHTMLString()` method so that it gets loaded. This is different to the way we were loading HTML before, because we aren't using a website here, just some custom HTML.
>
>That's it for the detail view controller, it really is that simple. However, we still need to connect it to the table view controller by implementing the `didSelectRowAt` method.
>
>Previously we used the `instantiateViewController()` method to load a view controller from `Main.storyboard`, but in this project `DetailViewController` isn’t in the storyboard – it’s just a free-floating class. This makes `didSelectRowAt` easier, because it can load the class directly rather than loading the user interface from a storyboard.
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



## :two: [Finishing touches didFinishLaunchingWithOptions](https://www.hackingwithswift.com/read/7/5/finishing-touches-didfinishlaunchingwithoptions) 