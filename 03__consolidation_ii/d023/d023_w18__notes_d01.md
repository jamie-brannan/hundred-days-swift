# Day 23, Week 18
:calendar: – Thursday August 13, 2020

- [Day 23, Week 18](#day-23-week-18)
  - [:one: What you learned](#one-what-you-learned)
  - [:two:  Key points](#two--key-points)

>It’s time for another consolidation day, because we’ve covered a lot of ground in the first three topics and it’s important you review them if you want them to stick in your head.
>
>However, this will also be the first day you’re asked to create a complete app from scratch. Don’t worry: I outline all the components required to make it work, and also provide hints to give you a head start.
>
>As you’ll see, creating an app from scratch is a very different experience to adding modifications to an existing app: you get blank page paralysis, which is where your brain knows where you want to get to but you’re just not sure how to start.
>
>A common reason to get stuck is that folks try to write flawless code first time. As Margaret Atwood once said, “if I waited for perfection, I would never write a word.” So, dive in and see where you get – these milestone challenges will help you learn to get comfortable starting fresh projects, and to get real functionality up and running quickly.
>
>Today you have three topics to work through, one of which of is your challenge.
>
>* What you learned
>* Key points
>* Challenge
>
>**Note**: Don’t worry if you don’t complete challenges in the day they were assigned – in future days you’ll find you have some time to spare here and there, so challenges are something you can return back to in the future.

## :one: [What you learned](https://www.hackingwithswift.com/guide/2/1/what-you-learned) 

>You’ve made your first two projects now, and completed a technique project too – this same cadence of app, game, technique is used all the way up to project 30, and you’ll start to settle into it as time goes by.

:white_check_mark: 

>Both the app and the game were built with `UIKit` – something we’ll continue for two more milestones – so that you can really start to _understand how the basics of view controllers work_. These really are a fundamental part of any iOS app, so the more experience I can give you with them the better.
>
>At this point you’re starting to put your Swift knowledge into practice with real context: actual, hands-on projects. Because most iOS apps are visual, that means you’ve started to use lots of things from `UIKit`, not least:
>
>* Table views using `UITableView`. These are used everywhere in iOS, and are one of the most important components on the entire platform.

This was the landing page of the _Storm Viewer_

>* Image views using `UIImageView`, as well as the data inside them, `UIImage`. Remember: a `UIImage` contains the pixels, but a `UIImageView` displays them – i.e., positions and sizes them. You also saw how iOS handles retina and retina HD screens using @2x and @3x filenames.

These were the detail image views

>* Buttons using `UIButton`. These don’t have any special design in iOS by default – they just look like labels, really. But they do respond when tapped, so you can take some action.

Both apps (post challenge), in navigation bar. One was system, one was a text button and both actions were attached with `#selector(@objc)`

>* View controllers using `UIViewController`. These give you all the fundamental display technology required to show one screen, including things like rotation and multi-tasking on iPad.

Pretty standard on both apps and other things I've made, although, have not yet managed special landscape mode settings

>* System alerts using `UIAlertController`. We used this to show a score in project 2, but it’s helpful for any time you need the user to confirm something or make a choice.

This was the score alerts and checker in the flag game

>* Navigation bar buttons using `UIBarButtonItem`. We used the built-in action icon, but there are lots of others to choose from, and you can use your own custom text if you prefer.

:white_check_mark: already mentioned above

>* Colors using `UIColor`, which we used to outline the flags with a black border. There are lots of built-in system colors to choose from, but you can also create your own.

 :white_check_mark: May have still even left a random orange one from experimenting before?

>* Sharing content to Facebook and Twitter using `UIActivityViewController`. This same class also handles printing, saving images to the photo library, and more.

 :white_check_mark: Definitely did this, however _remember_ this has to be check out with a build on a real phone because of security stuff.

>One thing that might be confusing for you is the relationship between `CALayer` and `UIView`, and `CGColor` and `UIColor`. I’ve tried to describe them as being _“lower level” and “higher level”,_ which may or may not help. Put simply, you’ve seen how you can create apps by building on top of Apple’s APIs, and that’s exactly how Apple works too: their most advanced things like `UIView` are built on top of lower-level things like `CALayer`. Some times you need to reach down to these lower-level concept, but most of the time you’ll stay in `UIKit`.

:question: *And memory concerns?*

Would be cool to hear the cases of when to use _low level_ stuff.

>If you’re concerned that you won’t know when to use `UIKit` or when to use one of the lower-level alternatives, don’t worry: if you try to use a `UIColor` when Xcode expects a `CGColor`, it will tell you!

:woman_shrugging: _In Xcode we trust?_

>Both projects 1 and 2 worked extensively in Interface Builder, which is a running theme in this series: although you can do things in code, it’s generally preferable not to. 

Preferable because? I'm not sure there less memory consumed when you use _IB_

>Not only does this mean you can see exactly how your layout will look when previewed across various device types, but you also open the opportunity for *specialized designers* to come in and adjust your layouts without touching your code. Trust me on this: keeping your UI and code separate is A Good Thing.

:unicorn: Specialised designers, like who?

>Three important Interface Builder things you’ve met so far are:
>
>1) Storyboards, edited using Interface Builder, but used in code too by setting storyboard identifiers.
>2) Outlets and action from Interface Builder. Outlets connect views to named properties (e.g. `imageView`), and actions connect them to methods that get run, e.g. `buttonTapped()`.
>3) Auto Layout to create rules for how elements of your interface should be positioned relative to each other.
>_You’ll be using Interface Builder a lot throughout this series. Sometimes we’ll make interfaces in code, but only when needed and always with good reason._

:white_check_mark: Okay, but this is interesting. It feels contradictory to what I've learned before, but this makes sense for learners to keep things simple and watch what you're doing?

>There are three other things I want to touch on briefly, because they are important.
>
>First, you met the `Bundle` class, which lets you use any assets you build into your projects, like images and text files. We used that to get the list of `NSSL JPEGs` in project 1, but we’ll use it again in future projects.

:star: This wasn't quite clear to me that it's part of the `bundle` class, but makes sense since it's the file paths.

:question: *What does NSSL stand for?*

>Second, loading those NSSL JPEGs was done by scanning the app bundle using the `FileManager` class, which lets you read and write to the iOS filesystem. We used it to scan directories, but it can also check if a file exists, delete things, copy things, and more.

`FileManager` is a CRUD then? 
* Or at least the pattern? learning terms

>Finally, you learned how to generate truly random numbers using Swift’s `Int.random(in:)` method. Swift has lots of other functionality for randomness that we’ll be looking at in future projects.

:exclamation: They're not **truly** random still because they're is a seed involved though?
> I'm not convinced.


## :two:  [Key points](https://www.hackingwithswift.com/guide/ios-classic/2/2/key-points) 

>There are five important pieces of code that are important enough they warrant some revision. First, this line:

```swift
let items = try! fm.contentsOfDirectory(atPath: path)
```
>The `fm` was a reference to `FileManager` and path was a reference to the resource path from `Bundle`, so that line pulled out an array of files at the directory where our app’s resources lived. But do you remember why the `try!` was needed?

A force unwrap because we're locally holding the files

>When you ask for the contents of a directory, **it’s possible** – although hopefully unlikely! – _that the directory doesn’t actually exist_. 
>* Maybe you meant to look in a directory called “files” but accidentally wrote “file”. 
>
>In this situation, the `contentsOfDirectory()` call will **fail**, and Swift will throw an exception – it will literally refuse to continue running your code until you handle the error.

And crash :fire:

>This is important, because _handling the error_ allows your app to behave well even when things go wrong. 
>* But in this case we got the path straight from iOS – we didn’t type it in by hand, so if reading from our own app’s bundle doesn’t work then clearly something is very wrong indeed.

True

>Swift requires any calls that might fail to be called using the `try` keyword, which _forces you to add code to catch any errors_ that might result. 
>
>However, because we know this code will work – it can’t possibly be mistyped – we can use the `try!` keyword, which means _“don’t make me catch errors, because they won’t happen."_ 
>* Of course, if you’re wrong – if errors do happen – then your app will crash, so be careful!

:white_check_mark: Totally. It would be cool to look at some alternatives though it does make sense to trust an Apple native method

>The second piece of code I’d like to look at is this method:

```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
}
```

>That was used in project 1 to make the **table view** show as many rows as necessary for the pictures array, but it packs a lot into a small amount of space.
>
>To recap, we used the Single View App template when creating project 1, which gave us a single UIViewController subclass called simply `ViewController`. To make it use a table instead, we changed `ViewController` so that it was based on `UITableViewController`, which provides default answers to lots of questions: _how many sections are there? How many rows? What’s in each row? What happens when a row is tapped?_ And so on.
>
>Clearly we don’t want the default answers to each of those questions, because our app needs to specify _how many rows it wants based on its own data_. 
>
>And that’s where the `override` keyword comes in: it means _“I know there’s a default answer to this question, but I want to provide a new one.”_ 
>
>The “question” in this case is “numberOfRowsInSection”, which expects to receive an `Int` back: `how many rows should there be?`

This was a class exercise.

>The last two pieces of code I want to look at again are these:

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)

if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
}
```

>Both of these are responsible for linking code to storyboard information using an identifier string. In the former case, it’s **a cell reuse identifier**; in the latter, it’s a view controller’s **storyboard identifier**. You always need to use the same name in Interface Builder and your code – if you don’t, you’ll get a crash because iOS doesn’t know what to do.

:question: *Two different names to refer to the same object, but for different reasons – right?*
* based on what was written on the Interface Builder view of the Storyboard

>The second of those pieces of code is particularly interesting, because of the `if let` and `as?` `DetailViewController`. When we dequeued the table view cell, we used the built-in “Basic” style – we didn’t need to use a custom class to work with it, so we could just crack on and set its text.
>
>However, the detail view controller has its own custom thing we need to work with: the `selectedImage` string. That doesn’t exist on a regular `UIViewController`, and that’s what the `instantiateViewController()` method returns – it doesn’t know (or care) what’s inside the storyboard, after all. That’s where the `if let` and `as?` **typecast** comes in: it means “I want to treat this is a `DetailViewController` so _please try and **convert it**_ to one.”
>
>Only if that conversion works will the code inside the braces execute – and that’s why we can access the `selectedImage` property safely.

:white_check_mark: Makes sense, we've done this to make custom views in the FTS app.