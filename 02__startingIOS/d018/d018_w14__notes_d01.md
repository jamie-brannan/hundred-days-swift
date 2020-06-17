# Day 18, Week 14
:calendar: – Wednesday June 17, 2020

*At home* :house:

>Now that our app is complete, it’s time for a quick recap what you learned, a short test to make sure you’ve understood what was taught, then your first challenges – exercises designed to get you writing your own code as quickly as possible.

>I do not provide the answers to these challenges. This is intentional: *I want you to figure it out by yourself rather than just looking at someone else’s work*. Trying things out for yourself, making mistakes, and finding solutions is key to learning – as Maya Angelou once said, “nothing will work unless you do.”

>Today you should work through the wrap up chapter for project 1, complete its review, then work through all three of its challenges.

## :arrow_right_hook: [Project 1, Storm Viewer: Wrap up](https://www.hackingwithswift.com/read/1/7/wrap-up) 

>This has been a very simple project in terms of what it can do, but you've also learned a huge amount about Swift, Xcode and storyboards. I know it's not easy, but trust me: you've made it this far, so you're through the hardest part.
>
>To give you an idea of how far you've come, here are just some of the things we've covered: 
>* table views and image views,
>* app bundles,
>* FileManager,
>* typecasting,
>* view controllers,
>* storyboards,
>* outlets,
>* Auto Layout,
>* UIImage,
>* and more.

>Yes, that's a huge amount, and to **be brutally honest chances are you'll forget half of it.** 

:100: truth.

>But that's OK, because we all learn through *repetition*, and if you continue to follow the rest of this series you'll be using all these and more again and again until you know them like the back of your hand.

### Review what you learned

>Anyone can sit through a tutorial, but it takes actual work to remember what was taught. It’s my job to make sure you take as much from these tutorials as possible, so I’ve prepared a short review to help you check your learning.

[Link to quiz](https://www.hackingwithswift.com/review/hws/project-1-storm-viewer)

### :boom: Quiz insights

>1) Auto Layout constraints must always be complete and non-conflicting.
>> These are Auto Layouts two rules, and you must always obey them if you want your layouts to work.
>
>2) Storyboards contain the user interface layouts for our app.
>> This is the job of storyboards: to contain the user interface for our view controllers.
>
>3) Interface Builder creates outlets as implicitly unwrapped optionals.
>> This is required because the view won't exist when the view controller is first created, but it will exist shortly afterwards and then continue to exist for the life of the view controller.
>
>4) viewDidLoad() is called after our view has been created.
>>The clue is in the name here – the view did load, so it's completed.
>
>5)  iOS reuses table view cells that have moved off the screen.
>>This table view cell reuse is important for performance.
>
>6) Navigation bars are the gray bar across the top of our user interface.
>>That bar at the top is where you show your view controller's title and any buttons it needs.
>
>7) All iOS apps are built into a single bundle.
>>:burrito: App bundles have the extension .app and contain all your code and resources.
>
>8) @IBOutlet marks a property that is connected to something in IB.
>> Remember, @IBOutlet has no special meaning other than "this is connected to something in Interface Builder."
>
>9) UITableViewController inherits from UIViewController.
>>All screens in iOS are represented using UIViewController or one of its subclasses.
>
>10) iOS automatically looks for an initial view controller to show when launching an app.
>>The initial view controller is what gets shown when your app launches.
>
>11) Interface Builder's document outline shows all view controllers in a storyboard.
>>The document outline is a great way to get an overview of all your view controllers and their contents.
>
>12) Navigation controllers manage _a stack_ of view controllers that can be pushed by us.
>>This view controller stack is what gives us the smooth sliding in and out animation.

But why do we say a *stack of view controllers* ? Is this something that makes us think of FIFO and what not?

11/12 :star: – one wrong because I didn't get the meaning, I thought "in IB" was a trap rather than really refering to Interface builder.

### Challenge
This has the beginnings of a useful app, but if you really want your new knowledge to sink in you need to start writing some new code yourself – without following a tutorial, or having an answer you can just look up online.

So, each time you complete a project I’ll be setting you a challenge to modify it somehow. Yes, this will take some work, but there is no learning without struggle – all the challenges are completely within your grasp based on what you’ve learned so far.

For this project, your challenges are:

1) Use Interface Builder to select the text label inside your table view cell and adjust its font size to something larger – experiment and see what looks good.
2) In your main table view, show the image names in sorted order, so “nssl0033.jpg” comes before “nssl0034.jpg”.
3) Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.