# Day 15, Week 
:calendar: – Monday June 08, 2020

*At home* :house:

>...it’s time to put everything you’ve learned into practice by building real iOS projects in Swift.
>
>...Today you have three topics to work through, and you’ll meet view controllers, storyboards, and the FileManager class. As you progress through the projects in this series the pace will quicken, but for now we’re taking things slow so you have time to get comfortable.

## :one:  [Setting up](https://www.hackingwithswift.com/read/1/1/setting-up) 

>In this project you'll produce an application that lets users scroll through a list of images, then select one to view. It's deliberately simple, because there are many other things you'll need to learn along the way, so strap yourself in – this is going to be long!
>

### Launch Xcode

>...choose "**Create a new Xcode project**" from the welcome screen. *Choose **Single View App*** from the list and click Next. For Product Name enter *Project1*, then make sure you have Swift selected for the language.

1) Create new projet
2) Single view App
3) Project1

>One of the fields you'll be asked for is "**Organization Identifier**", which is a unique identifier usually made up of your personal web site domain name in reverse. For example, I would use *com.hackingwithswift* if I were making an app. You'll need to put something valid in there if you're deploying to devices, but otherwise you can just use *com.example*.

>**Important note**: some of Xcode's project templates have checkboxes saying "Use Core Data", "Include Unit Tests" and "Include UI Tests". 
>
>*Please ensure these boxes are unchecked for this project* and indeed almost all projects in this series – there’s only one project where this isn’t the case, and it’s made pretty clear there!

What's changed since this tutorial is that there's a choice between Storyboarding and SwiftUI – there's no 

>Now click *Next* again and you'll be asked where you want to save the project – your desktop is fine. Once that's done, you'll be presented with the example project that Xcode made for you. The first thing we need to do is make sure you have everything set up correctly, and that means running the project as-is.

### Simulators

>When you run a project, you get to choose what kind of device the *iOS Simulator* should pretend to be, or you can also select a physical device if you have one plugged in. These options are listed under the *Product > Destination menu*, and you should see iPad Air, iPhone 8, and so on.
>
>There's also a shortcut for this menu: at the top-left of Xcode's window is the play and stop button, but to the right of that it should say *Project1* then a device name. You can click on that device name to select a different device.
>
>**For now, please choose iPhone XR, and click the Play triangle button in the top-left corner.** This will compile your code, which is the process of converting it to instructions that iPhones can understand, then launch the simulator and run the app. As you'll see when you interact with the app, our “app” just shows a large white screen – it does nothing at all, at least not yet.

:white_check_mark: Simulators

>You'll be starting and stopping projects a lot as you learn, so there are three basic tips you need to know:
>
>* You can run your project by pressing Cmd+R. This is equivalent to clicking the play button.
>* You can stop a running project by pressing Cmd+. when Xcode is selected.
>* If you have made changes to a running project, just press Cmd+R again. Xcode will prompt you to stop the current run before starting another. Make sure you check the "Do not show this message again" box to avoid being bothered in the future.

**Shortcuts**
* `cmd` + `r` – run
* `cmd` + `+` – stop running

### Extra file sources

>This project is all about letting users select images to view, so you're going to need to import some pictures. 
>* Download the files for this project from GitHub (https://github.com/twostraws/HackingWithSwift), and look in the “project1-files” folder. You'll see another folder in there called Content, and I’d like you to drag that Content folder straight into your Xcode project, just under where it says "Info.plist".
>
>A window will appear asking how you want to add the files: make sure "Copy items if needed" is checked, and "Create groups" is selected. **Important: do not choose "Create folder references" otherwise your project will not work.**

:warning: :question: What would make this break?

## :two:  [Listing images with file manager](https://www.hackingwithswift.com/read/1/2/listing-images-with-filemanager) 

>Behind the scenes, an iOS app is actually a directory containing lots of files: 
>* the binary itself (that's the compiled version of your code, ready to run),
>* all the media assets your app uses,
>* any visual layout files you have,
>* plus a variety of other things such as metadata and security entitlements.
>
>These app directories are called **bundles**, and they have the file extension `.app`. 

**bundles** : *(Xcode)* file extension `.app`, directories in an Xcode project containing a compiled project
* does this have wider applications to CS outside of Swift?

>Because our *media files* are loose inside the folder, we can ask the system to tell us all the files that are in there then pull out the ones we want. 
>* You may have noticed that all the images start with the name "nssl" (short for National Severe Storms Laboratory), so our task is simple: list all the files in our app's directory, and pull out the ones that start with "nssl".
>
>*For now, we’ll load that list and just print it to Xcode’s built in **log viewer**, but soon we’ll make them appear in our app.*

### Step 1 

>Open `ViewController.swift`. 
>
>A **view controller** is best thought of as being one screen of information, and for us that’s just one big blank screen. 
>
>`ViewController.swift` is responsible for showing that blank screen, and right now it won’t contain much code. You should see something like this:

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
```

>That contains four interesting things I want to discuss before moving on.
>
>The file starts with `import UIKit`, which means “this file will reference the iOS user interface toolkit.”
>
>The `class ViewController`: 
>* `UIViewController` line means “I want to create a new screen of data called ViewController, based on UIViewController.” 
>>When you see a data type that starts with “UI”, it means it comes from UIKit. UIViewController is Apple’s default screen type, which is empty and white until we change it.
>
>The line `override func viewDidLoad()` starts a method. 
>* As you know, the `override keyword` is needed because it means “we want to change Apple’s default behavior from UIViewController.” viewDidLoad() is called by UIKit when the screen has loaded, and is ready for you to customize.
>
>The `viewDidLoad()` method contains one line of code saying `super.viewDidLoad()` and one line of comment (that’s the line starting with `//`). 
>* This super call means “tell Apple’s `UIViewController` to run its own code before I run mine,” and you’ll see this used a lot.

>No **line numbers**? While you’re reading code, it’s frequently helpful to have line numbers enabled so you can refer to specific code more easily. 
>>If your Xcode isn't showing line numbers by default, I suggest you turn them on now: go to the Xcode menu and choose Preferences, then choose the Text Editing tab and make sure "Line numbers" is checked.
>
>As I said before, the viewDidLoad() method is called when the screen has loaded and is ready for you to customize. We're going to put some more code into that method to load the NSSL images. 
>
>Add this beneath the line that says super.viewDidLoad():

```swift
let fm = FileManager.default
let path = Bundle.main.resourcePath!
let items = try! fm.contentsOfDirectory(atPath: path)

for item in items {
    if item.hasPrefix("nssl") {
        // this is a picture to load!
    }
}
```
>**Note**: Some experienced Swift developers will read that code, see try!, then write me an angry email. If you’re considering doing just that, please continue reading first.

:joy:

>That’s a big chunk of code, most of which is new. Let’s walk through what it does line by line:
>
>The line `let fm = FileManager.default` declares a constant called fm and assigns it the value returned by `FileManager.default`. 
>* This is a data type that lets us work with the filesystem, and in our case we'll be using it to look for files.
>
>The line `let path = Bundle.main.resourcePath!` declares a constant called `path` that is set to the **resource path** of our *app's bundle*. 
>* Remember, a **bundle** is a directory containing our **compiled program** and all our assets. So, this line says, "tell me where I can find all those images I added to my app."

:question: *Specifically the bundle will contain the compiled program? What do we call the directory that is the uncompiled code then?*

>The line `let items = try! fm.contentsOfDirectory(atPath: path)` declares a third constant called items that is set to the contents of the directory at a path.
>* Which path? Well, the one that was returned by the line before. As you can see, Apple's long method names really does make their code quite self-descriptive! The items constant will be an array of strings containing filenames.

:white_check_mark: Neato !

>The line if `item.hasPrefix("nssl") {` is the first line inside our loop. 
>* By this point, we'll have the first filename ready to work with, and it'll be called `item`. 
>
>To decide whether it's one we care about or not, we use the `hasPrefix()` method: it takes one parameter (the prefix to search for) and returns either true or false.
>* That "if" at the start means this line is a conditional statement: if the item has the prefix "nssl", then… that's right, another opening brace to mark another new code block. This time, the code will be executed only if `hasPrefix()` returned true.
>
>Finally, the line `// this is a picture to load!` is a comment – if we reach here, item contains the name of a picture to load from our bundle, so we need to store it somewhere.

Make total sense, except what is the `try!` of the `fm.contentsOfDirectory(atPath:path)`?

>In this instance it’s perfectly fine to use `Bundle.main.resourcePath!` and `try!`, because *if this code fails* **it means our app can't read its own data** so something must be seriously wrong. 
>* Some Swift developers attempt to write code to handle these catastrophic errors at runtime, but sadly all too often they just mask the actual problem that occurred.

:woman_shrugging:

>Right now our code:
>1) loads the list of files that are inside our app bundle,
>2) then loops over them all to find the ones with a name that begins with “nssl”.

:white_check_mark: :rocket:

>However, it doesn’t actually do anything with those files, so our next step is to create an array of all the “nssl” pictures so we can refer to them later rather than having to re-read the resources directory again and again.
>
>The three constants we already created – `fm`, `path`, and `items` – live inside the `viewDidLoad()` method, and will be destroyed as soon as that method finishes.
>* What we want is *a way to attach data* to the whole *ViewController* **type** so that *it will exist for as long as our screen exists.*

:question: *Would we really want it to be attached to the `type` ? Wouldn't it be the instance of the screen?*

>* So, this a perfect example of when to use a property – we can give our `ViewController` class as many of these properties as we want, then read and write them as often as needed while the screen exists.
>
>To create a property, you need to declare it outside of methods. We’ve been creating constants using let so far, but this array is going to be changed inside our loop so we need to make it variable. We also need to tell Swift exactly what kind of data it will hold – in our case that’s an array of strings, where each item will be the name of an “nssl” picture.
>
>Add this line of code before `viewDidLoad()`:

```swift
var pictures = [String]()
```

If you’ve placed it correctly, your code should look like this:

```swift
class ViewController: UIViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let fm = FileManager.default
```

>That `pictures` array will be created when the `ViewController` screen is created, and exist for as long as the screen exists. 

Just because it's within the class?

>It will be empty, because we haven’t actually filled it with anything, but at least it’s there ready for us to fill.
>
>What we really want is to add to the `pictures` array all the files we match inside our loop. To do that, we need to replace the existing `// this is a picture to load!` comment with code to add each picture to the `pictures` array.
>
>Helpfully, Swift’s arrays have a built-in method called `append` that we can use to add any items we want. So, replace the `// this is a picture to load!` comment with this:

```swift
pictures.append(item)
```
>That’s it! Annoyingly, after all that work our app won’t appear to do anything when you press play – you’ll see the same white screen as before. Did it work, or did things just silently fail?
>
>To find out, add this line of code at the end of `viewDidLoad()`, just before the closing brace:

```swift
print(pictures)
```

>That tells Swift to print the contents of `pictures` to the **Xcode debug console**. When you run the program now, you should see this text appear at the bottom of your Xcode window: “["nssl0033.jpg", "nssl0034.jpg", "nssl0041.jpg", "nssl0042.jpg", "nssl0043.jpg", "nssl0045.jpg", "nssl0046.jpg", "nssl0049.jpg", "nssl0051.jpg", "nssl0091.jpg”]”
>
>Note: iOS likes to print lots of uninteresting debug messages in the Xcode debug console. Don’t fret if you see lots of other text in there that you don’t recognize – just scroll around until you see the text above, and if you see that then you’re good to go.