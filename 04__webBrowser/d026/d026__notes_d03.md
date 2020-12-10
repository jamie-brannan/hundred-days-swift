# Day 26 • Thursday October 15, 2020

- [Day 26 • Thursday October 15, 2020](#day-26--thursday-october-15-2020)
  - [:one: Wrap up](#one-wrap-up)
  - [:two:  Project 4 review](#two--project-4-review)
    - [:boom: Quiz insights](#boom-quiz-insights)

>And he’s right: I want you to succeed, but I also want to set you free a little to so you can try (and fail a little!) on your own. Sometimes figuring out all the wrong paths is as important as figuring out the right paths.
>
>Today you should work through the wrap up chapter for project 4, complete its review, then work through all three of its challenges.

Wait – this is already complete! :tada:

## :one: [Wrap up](https://www.hackingwithswift.com/read/4/6/wrap-up) 

:sunglasses: Already done in the previous day.

## :two:  [Project 4 review](https://www.hackingwithswift.com/review/hws/project-4-easy-browser) 

### :boom: Quiz insights

* loadView() is called before viewDidLoad()
  * loadView() is called first, and it's where you create your view; viewDidLoad() is called second, and it's where you configure the view that was loaded.
* Calling sizeToFit() on a view makes it take up the correct amount of space for its content.
  * UIKit will measure the contents of the view, then adjust its size so that all the content is visible.
* We can use #selector to point to a specific method in a different object.
  * You can use #selector to point to a method in any object, as long as that method is marked @objc.
* Delegation allows one object to respond on behalf of another.
  * Delegation is what allows us to customize the behavior of built-in types without having to sub-class them.
* ~~App Transport Security means apps are installed safely from the App Store.~~
  * :red_circle: App Transport Security means that we can transfer data over the internet using secure connections only.
* If you want to, you can provide a context value for your key-value observers.
  * This context is just a value that's sent back to you when your observer code is triggered.
* Conforming to a protocol means adding the properties and methods required by that protocol.
  * Protocol conformance allows Swift to check at compile time that you have implemented the properties and methods you said you would.

... I think I've actually done this quiz before?

* A web view's navigation delegate can control which pages should be loaded.
  * Navigation delegates can decide whether to allow or deny individual requests.
* Flexible spaces automatically take up all available remaining space.
  * Flexible spaces allow us to space buttons out neatly, either by pushing them to one side or by adding margin between them.
* All view controllers have a toolbarItems property.
  * This property is used to show buttons in a toolbar when the view controller is inside a navigation controller.