*Day 35 • Monday November 30, 2020*

>In this project we built the kind of app you’ll see in thousands of different iOS job interviews around the world: here’s a JSON feed, please parse it and show in a table view. Sure, our specific version was about one feed, but the concepts – fetching data, using `Codable`, rendering things into a web view, etc – are applicable anywhere.
>
>But you’ve done more than just learn some new coding techniques. Michelle Obama once said “through my education, I didn't just develop skills, _I didn't just develop the ability to learn, but I developed confidence_.” And that’s true of you, too: 
>* each time you complete these projects you add another completed project to your résumé and you add another load of skills to your toolkit, but you’re also building the confidence that when you face a similar problem in the future you’ll realize you can look back on your work these last few days and have an instant refresher.

:star: this included asking help form other devs with things that have changed between versions of Swift.
* this is also something that a `diff` should've picked up but clearly I didn't read the terminal that well... (linux skills to be improved)


>And it is a refresher. You see, you won’t remember the precise code you wrote today, and you might even forget class names like `JSONDecoder`. But that’s OK: being a skilled developer _isn’t about memorizing_ classes or methods – **it’s about knowing concepts**. _And if you’re able to apply the concepts from this project with some concepts from projects 2, 4, and 5 to make something entirely new, then you’re doing a great job._

:white_check_mark: Connecting the dots

>Today you should work through the wrap up chapter for project 7, complete its review, then work through all three of its challenges.

- [:two:  Wrap up](#two--wrap-up)
  - [:boom: Quiz insights](#boom-quiz-insights)
- [:two:  Review for Project 7: Whitehouse Petitions](#two--review-for-project-7-whitehouse-petitions)

>Once you’re done, tell other people: you’ve built another great app for iOS, and you’ve learned more about parsing JSON, tab bar controllers, and more.
>
>You should be proud of what you’ve accomplished – keep going!

## :two:  [Wrap up](https://www.hackingwithswift.com/read/7/6/wrap-up) 

>As your Swift skill increases, I hope you're starting to feel the balance of these projects move away from explaining the basics and toward presenting and dissecting code.
>
>In this project you learned how to download JSON using Swift’s Data type, then use the `Codable` protocol to convert that data into Swift objects we defined. Working with JSON is something you're going to be doing time and time again in your Swift career, and you've cracked it in about an hour of work – while also learning about `UITabBarController`, `UIStoryboard`, and more.
>
>Good job!
>
### :boom: Quiz insights

* Table view cells with subtitles show two different text labels.
  * The default table view cell has a single label, but the subtitle style has two.
* UIStoryboard can load storyboards from our bundle and create view controllers from there.
  * Just provide it the storyboard name as its first parameter and it will do the rest.
* AppDelegate is there to respond to system notifications such as the user exiting the app.
* :red_circle: ~~It's OK to name Swift properties different from JSON, because Codable will automatically figure out what you mean.~~
  * **Unless you want to do a lot of extra work yourself, your property names should match what's in your JSON.** (_this is what we have done in the FTS project I believe_)
* Storyboard identifiers allow us to create storyboard view controllers in code
  * These work similarly to table view cell reuse identifiers.
* JSON is a lightweight way to store and send data.
  * JSON (JavaScript Object Notation) is commonly used across many languages for just this purpose.
* `UITabBarController` is able to store multiple view controllers for the user to select from.
  * Just like a `UINavigationController`, `UITabBarController` provides both logic to handle view controllers and also a view that lets the user interact with it.
* The JSONDecoder type does the hard work of converting JSON to Swift values.
  * It has a counterpart called JSONEncoder that works in the opposite direction.
* The Codable protocol can convert Swift types to and from JSON.
  * Codable converts to and from JSON and other popular formats.
* Apple provides a handful of built-in UITabBarItem types for common uses.
  * If you use these you must use both their icon and text; you can't have custom text.
* String, Int, [String], and more all conform to Codable.
  * Swift's built-in types conform to Codable, as do arrays, sets, and dictionaries of those types.
* Swift's Data type can hold any kind of binary data.
  * You can use it to store images, zip files, strings, or anything you like.
* :red_circle: ~~It's a good idea to set the tag property of a UITabBarItem to something memorable like "Home" or "Latest".~~
  * **Tags are integers, not strings.**
* :red_circle: ~~View controllers in storyboards must always have a storyboard identifier.~~
  * **They only need one if you intend to reference them in code.**
* Creating a `URL` from a string might fail.
  * The `URL(string:)` initializer is a failable one because _you might type an invalid URL_ by accident.
* We can create a `Data` instance directly from a `URL`.
  * `Data` has a `contentsOf` initializer for just this purpose. 

>Anyone can sit through a tutorial, but it takes actual work to remember what was taught. It’s my job to make sure you take as much from these tutorials as possible, so I’ve prepared a short review to help you check your learning.
>
>### Challenge
>
>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:
>
> :one:  Add a Credits button to the top-right corner using `UIBarButtonItem`. When this is tapped, show **an alert** telling users the data comes from the We The People API of the Whitehouse.

  - [x]  add upper right nav button
  - [x]  selector to present an alert
  - [x]  enter proper text

> :two: Let users filter the petitions they see. This involves creating a **second array of filtered items** that contains only **petitions matching a string the user entered**. Use a `UIAlertController` with a text field to let them enter that string. This is a tough one, so I’ve included some hints below if you get stuck.

  - [x]  filtered items array init
  - [x]  alert to enter the string
  - [x]  filter triggered backed on the string
  - [x]  reload data based on filter
  - [ ]  add a reset button?

:pushpin: [**learnappmaking**](https://learnappmaking.com/map-reduce-filter-swift-programming/) : *Map reduce filter swift programming*

> :three: Experiment with the HTML – this isn’t a HTML or CSS tutorial, but you can find lots of resources online to give you enough knowledge to tinker with the layout a little.

  - [ ]  Html customized

>### Hints
>It is vital to your learning that you try the challenges above yourself, and not just for a handful of minutes before you give up.
>
>Every time you try something wrong, you learn that it’s wrong and you’ll remember that it’s wrong. By the time you find the correct solution, you’ll remember it much more thoroughly, while also remembering a lot of the wrong turns you took.
>
>This is what I mean by “there is no learning without struggle”: if something comes easily to you, it can go just as easily. But when you have to really mentally fight for something, it will stick much longer.
>
>But if you’ve already worked hard at the challenges above and are still struggling to implement them, I’m going to write some hints below that should guide you to the correct answer.
>
>**If you ignore me and read these hints without having spent at least 30 minutes trying the challenges above, the only person you’re cheating is yourself.**
>
>Still here? OK. The second challenge here is to let users filter the petitions they see. To solve this you need to do a number of things:
>
>1. Have one property to store all petitions, and one to store filtered petitions. This means the user can filter the petitions several times and you don’t have to keep redownloading your JSON.
> 1. At first your filtered petitions array will be the same as the main petitions array, so just assign one to the other when your data is ready.
> 1. Your table view should load all its data from the filtered petitions array.
> 1. You’ll need a bar button item to show an alert controller that the user can type into.
> 1. Once that’s done, go through all the items in your petitions array, adding any you want to the filtered petition.
>
>The important part here is the last one: how do you decide whether a petition matches the user’s search? One option is to use `contains()` to check whether the petition title or body text contains the user’s search string – try it and see how you get on!

## :two:  [Review for Project 7: Whitehouse Petitions](https://www.hackingwithswift.com/review/hws/project-7-whitehouse-petitions)


