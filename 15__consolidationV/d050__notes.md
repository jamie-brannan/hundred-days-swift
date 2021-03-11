# *Day 50 • Tuesday March 09, 2021*

>It’s time for another consolidation day, which means you have lots to review, lots to dig into, and a fresh programming challenge too. I’ve mentioned before the importance of repetition, so I hope you’re able to seize this opportunity to try your hand at something new that helps you apply your new knowledge practically.
>
>**Aristotle** once said, _“it is frequent repetition that produces a natural tendency.”_ And that’s our goal with this repetition: to **bake knowledge of Swift and iOS so deep into your head and hands that you can start to build things without second guessing yourself**. 
>* So, when it comes to writing code for your own projects, or even writing code during an iOS interview, you know for sure that you’ve got it in hand – you can do it, because you’ve done it 20 times before.

:muscle:

>So, make sure you work through today’s challenge fully: experiment and see what you can make!
>
>**Today you have three topics to work through, one of which of is your challenge.**
>
>Note: Don’t worry if you don’t complete challenges in the day they were assigned – in future days you’ll find you have some time to spare here and there, so challenges are something you can return back to in the future.

## :one:  [What you learned](https://www.hackingwithswift.com/guide/5/1/what-you-learned) 

>You probably haven’t realized it yet, but the projects you just completed were some of the most important in the series. The end results are nice enough, but what they teach is more important – you **made your first class completely from scratch**, which is how you’ll tackle many, many problems in the future:
>
>* You met `UICollectionView` and saw how similar it is to `UITableView`. Sure, it displays things in columns as well as rows, but the method names are so similar I hope you felt comfortable using it.
>
>* You also designed a custom `UICollectionViewCell`, first in the `storyboard` and then in code. Table views come with several useful cell types built in, but collection views don’t so you’ll always need to design your own.
>
>* We used `UIImagePickerController` for the first time in this project. It’s not that easy to use, particularly in the way it returns its selected to you, but we’ll be coming back to it again in the future so you’ll have more chance to practice.
>
>* The `UUID` data type is used to generate **universally unique identifiers**, which is the easiest way to generate filenames that are guaranteed to be unique. We used them to save images in project 10 by converting each `UIImage` to a `Data` that could be written to disk, using `jpegData()`.

I wonder if this has changed much with iOS 14, but seeing that it's all locally done it might not be as much of a thing.

>* You met Apple’s `appendingPathComponent()` method, as well as my own `getDocumentsDirectory()` helper method. Combined, these two **let us create filenames that are saved to the user’s documents directory**. You could, in theory, create the filename by hand, but using `appendingPathComponent()` is _safer because it means your code won’t break if things change in the future_.
>
>Project 11 was the first game we’ve made using `SpriteKit`, which is Apple’s high-performance 2D games framework. It introduced a huge range of new things:
>
>The `SKSpriteNode` class is responsible for loading and drawing images on the screen.
>* You can draw sprites using a selection of blend modes. We used .replace for drawing the background image, which causes `SpriteKit` to ignore transparency. This is faster, and perfect for our solid background image.
>
>* You add physics to sprite nodes using `SKPhysicsBody`, which has rectangleOf and `circleWithRadius` initializers that create different shapes of physics bodies.
>* Adding actions to things, such as spinning around or removing from the game, is done using `SKAction`.
>
>* Angles are usually measured in radians using `CGFloat`.
>
>Lastly, you also met `UserDefaults`, which lets you read and write user preferences, and gets backed up to iCloud automatically. You shouldn’t abuse it, though: try to store only the absolute essentials in `UserDefaults` to avoid causing performance issues. In fact, tvOS limits you to just 500KB of `UserDefaults` storage, so you have no choice!
>
>For the times when your storage needs are bigger, you should either use the `Codable` protocol to convert your objects to `JSON`, or use `NSKeyedArchiver` and `NSKeyedUnarchiver`. These convert your custom data types into a Data object that you can read and write to disk.

## :two:  [Key points](https://www.hackingwithswift.com/guide/5/2/key-points) 

>There are **three pieces of code worth looking at again** before you continue on to project 13.

### Initialiser for `Person`

>First, lets review the initializer for our custom `Person` class from project 10:

```swift
init(name: String, image: String) {
    self.name = name
    self.image = image
}
```

>There are two interesting things in that code. First, we need to use `self.name = name` to make our intention clear: the class had a property called `name`, and the method had a parameter called `name`, so if we had just written `name = name` Swift wouldn’t know what we meant.
>
>Second, notice that we wrote `init` rather than `func init`. This is because `init()`, although it looks like a regular method, is special: technically it’s an initializer rather than a method. Initializers are things that create objects, rather than being methods you call on them later on.

### First touch trigger

>The second piece of code I’d like to review is this, taken from project 11:

```swift
if let touch = touches.first {
    let location = touch.location(in: self)
    let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
    box.position = location
    addChild(box)
}
```

>We placed that inside the `touchesBegan()` method, which is triggered when the user touches the screen. This method gets passed a set of touches that represent the user’s fingers on the screen, but in the game we don’t really care about multi-touch support we just say `touches.first`.
>
>Now, obviously the `touchesBegan()` method only gets triggered when a touch has actually started, but `touches.first` is still optional. This is because the set of touches that gets passed in doesn’t have any special way of saying “I contain at least one thing”. So, even though we know there’s going to be at least one touch in there, we still need to unwrap the optional. **This is one of those times when the force unwrap operator would be justified**:

```swift
let touch = touches.first!
```

### User defaults from project 12

>The last piece of code I’d like to review in this milestone is from project 12, where we had these three lines:

```swift
let defaults = UserDefaults.standard
defaults.set(25, forKey: "Age")
let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
```

>The first one gets access to the app’s built-in `UserDefaults` store. **If you were wondering, there are alternatives: it’s possible to request access to a shared `UserDefaults` that more than one app can read and write to, which is helpful if you ship multiple apps with related functionality.**

How is this done securely?

>
>The second line writes the integer 25 next to the key “Age”. `UserDefaults` is a key-value store, like a dictionary, which means every value must be read and written using a key name like “Age”. In my own code, I always use the same name for my `UserDefaults` keys as I do for my properties, which makes your code easier to maintain.
>
>The third line is the most interesting: it retrieves the object at the key “SavedArray” then tries to typecast it as a string array. If it succeeds – if an object was found at “SavedArray” and if it could be converted to a string array – then it gets assigned to the `array` constant. _But if either of those fail, then the nil coalescing operator (the `??` part) ensures that `array` gets set to an empty string array._

Is that how things are deleted? Why hasn't deleting user defaults been adressed (or maybe I haven't been paying attention). :sweat_smile:

## :three: [Challenge](https://www.hackingwithswift.com/guide/5/3/challenge) 

>Your challenge is to put two different projects into one: **I’d like you to let users take photos of things that interest them, add captions to them, then show those photos in a table view.** 
>
>Tapping the caption should show the picture in a new view controller, like we did with project 1. So, your finished project needs to use elements from both project 1 and project 12, which should give you ample chance to practice.
>
>This will require you to use the `picker.sourceType = .camera` setting for your image picker controller, create a custom type that stores a filename and a caption, then show the list of saved pictures in a table view. Remember: using the camera is only possible on a physical device.
>
>It might sound counter-intuitive, but trust me: one of the best ways to learn things deeply is to learn them, forget them, then learn them again. _So, don’t be worried if there are some things you don’t recall straight away_: straining your brain for them, or perhaps re-reading an older chapter just briefly, is a great way to help your iOS knowledge sink in a bit more.
>
>Here are some hints in case you hit problems:
>
>* You’ll need to make `ViewController` build on `UITableViewController` rather than just `UIViewController`.

:thinking: Is there much difference?

>* Just like in project 10, you should create a custom type that stores an image filename and a caption string, then use either `Codable` or `NSCoding` to load and save that.
>
>* Use a `UIAlertController` to get the user’s caption for their image – a single text field is enough.
>
>* You’ll need to design your detail view controller using Interface Builder, then call `instantiateViewController` to load it when a table view row is tapped.

:construction: This seems to be pretty free form!

So key criteria includes...
  - [ ]  table view menu
  - [ ]  adding an item by taking a photo
  - [ ]  associating text with photo (immediately after taking it)
  - [ ]  add a detail controller