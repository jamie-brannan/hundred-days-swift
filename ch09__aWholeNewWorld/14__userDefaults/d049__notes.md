# *Day 49 • Thursday February 25, 2021*

>Alan Perlis once said _“fools ignore complexity; pragmatists suffer it; some can avoid it; geniuses remove it.”_ Today you’re going to see that in Swift code: _rather than_ try to simplify the code for `NSCoding`, the Swift team found a way to remove it entirely using the `Codable` protocol.
>
>Sometimes you won’t have a choice and need to use `NSCoding`, but where possible **`Codable` is both easier and safer to use**. 
>* You do need to know them both, though, and by seeing them both used to solve the same problem hopefully you’ll able to decide for yourself which you prefer.
>
>Before you get down to work, here’s another fun **Swift in-joke** for you: sometimes you might see T-shirts with _a picture of a fish followed by “able”_, but before you scratch your head wondering what “fishable” might mean please remember that “COD” is a type of fish!
>
>**Today you should work through the `Codable` chapter and wrap up for project 12, complete its review, then work through all three of its challenges.**

- [*Day 49 • Thursday February 25, 2021*](#day-49--thursday-february-25-2021)
  - [:one: Fixing Project 10 `Codable`](#one-fixing-project-10-codable)
    - [Add `Codable` to Person](#add-codable-to-person)
    - [Create `save()`](#create-save)
  - [:two: Wrap up](#two-wrap-up)
    - [Review what you learned](#review-what-you-learned)
    - [Challenge](#challenge)
  - [:three:  Review for Project 12: `UserDefaults`](#three--review-for-project-12-userdefaults)
    - [:boom: Quiz insights](#boom-quiz-insights)

## :one: [Fixing Project 10 `Codable`](https://www.hackingwithswift.com/read/12/4/fixing-project-10-codable) 

>`NSCoding` is a great way to read and write data when using `UserDefaults`, and is the most common option when you must write Swift code that lives alongside Objective-C code.
>
>However, **if you’re only writing Swift**, _the `Codable` protocol is much easier_. 
>* We already used it to load petition JSON back in project 7, but now we’ll be loading and saving JSON.

I've used it lots, but not yet with `UserDefaults` because it's been a bit abstract since working on the live stream reminders at work.

>There are three primary differences between the two solutions:
>
>1. The `Codable` system **works on both `class`es and `struct`s**. 
>    * We made `Person` a class because `NSCoding` only works with classes, but if you didn’t care about Objective-C compatibility you could make it a struct and use `Codable` instead.
>
>2. When we implemented `NSCoding` in the previous chapter we had to write `encode()` and `init()` calls ourself. **With Codable this isn’t needed** _unless you need more precise control_ - it does the work for you.
>
>3. When you encode data using `Codable` you _can save to the same format_ that `NSCoding` uses if you want, but a much **more pleasant option is JSON – `Codable` reads and writes JSON natively.**
>
>All three of those combined means that you can define a `struct` to hold data, and have Swift create instances of that `struct` directly from JSON with no extra work from you.

Sounds great!

### Add `Codable` to Person

>Anyway, to demonstrate more of `Codable` in action I’d like you to close project12a and open **project12b** – this should be identical to project 10, because it doesn’t contain any of the NSCoding changes.

Are you sure? Cause we haven't gone over how to delete a UserDefault yet if I'm not mistaken? :thinking: 

>First, let’s modify the Person class so that it conforms to Codable:

```swift
class Person: NSObject, Codable {
```

>…and that’s it. **Yes, just adding Codable to the class definition is enough to tell Swift we want to read and write this thing.** 
>
>So, now we can go back to ViewController.swift and add code to load and save the people array.

### Create `save()`

>As with `NSCoding` we’re going to create a single `save()` method we can use anywhere that's needed. This time it’s going to use the `JSONEncoder` class to convert our people array into a Data object, which can then be saved to UserDefaults. This conversion might fail, so we’re going to use if let and try? so that we save data only when the JSON conversion was successful.
>
>Add this method to ViewController.swift now:

```swift
func save() {
    let jsonEncoder = JSONEncoder()
    if let savedData = try? jsonEncoder.encode(people) {
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    } else {
        print("Failed to save people.")
    }
}
```
>Just like with the NSCoding example you need to modify our collection view's didSelectItemAt method so that you call `self?.save()` just after calling `self.collectionView.reloadData()`. 
>
>Again, remember that **adding self is required because we're inside a closure**. You then need to modify the image picker's `didFinishPickingMediaWithInfo` method so that it calls `save()` just before the end of the method.

:white_check_mark: Added

>Finally, we need to load the array back from disk when the app runs, so add this code to `viewDidLoad()`:

```swift
let defaults = UserDefaults.standard

if let savedPeople = defaults.object(forKey: "people") as? Data {
    let jsonDecoder = JSONDecoder()

    do {
        people = try jsonDecoder.decode([Person].self, from: savedPeople)
    } catch {
        print("Failed to load people")
    }
}
```

>This code is effectively the `save()` method in reverse: we use the object(forKey:) method to pull out an optional Data, using if let and `as?` to unwrap it. We then give that to an instance of `JSONDecoder` to convert it back to an object graph – i.e., our array of Person objects.

:white_check_mark: Added and saves correctly

>Once again, note the interesting syntax for `decode()` method: its first parameter is `[Person].self`, which is Swift’s way of saying _“attempt to create an array of Person objects.”_ 
>* This is why _we don’t need a typecast_ when assigning to people – that method will automatically return `[People]`, or if the conversion fails then the catch block will be executed instead.

:+1:

## :two: [Wrap up](https://www.hackingwithswift.com/read/12/5/wrap-up) 

>You _will_ use `UserDefaults` in your projects. That isn't some sort of command, just **a statement of inevitability**. 
>
>If you want to save any **user settings**, or if you want to save **program settings**, it's just the _best place for it_. 
>* And I hope you'll agree it is (continuing a trend!) easy to use and flexible, particularly when your own classes conform to `Codable`.
>
>As you saw, the `NSCoding` protocol is also available. 
>* Yes, it takes extra work to use, and **_can be quite annoying_ when your data types have lots of properties you need to save**, 
>* but it does have the added benefit of Objective-C compatibility if you have a mixed codebase.

I wonder how much this will be the case as SwiftUI becomes more mainstream?

>One proviso you ought to be aware of: **please don't consider `UserDefaults` to be safe**, because **it isn't**. 
>* If you have user information that is private, you should consider writing to the keychain instead – something we'll look at in project 28.

:cop: Of course, clear warning.

### Review what you learned

>Anyone can sit through a tutorial, but it takes actual work to remember what was taught. It’s my job to make sure you take as much from these tutorials as possible, so I’ve prepared a short review to help you check your learning.

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
> 1. Modify project 1 so that it remembers how many times each storm image was shown – you don’t need to show it anywhere, but you’re welcome to try modifying your original copy of project 1 to show the view count as a subtitle below each image name in the table view.

  - [x]  Add a UserDefault counter
  - [x]  Display it in the subtitle

Make a `Codable` `NSObject` refactoring because it'll separate the data from the view.

> 2. Modify project 2 so that it saves the player’s highest score, and shows a special message if their new score beat the previous high score.

- [x]  Add a UserDefault of score (*when?*)
- [x]  Have an alert trigger when current score beats the previous UserDefault

:question: *How do we establish a high score in the first place?*
* There's a round limit already set in place
  
Logic was a bit messy since it was so old, but I straightened it out as simply as I could.

Addeded simple `integer(forKey:)`

```swift
  func saveHighScore() {
    defaults.set(score, forKey: "highScore")
  }
```

Then to load:

```swift
    highScore == defaults.integer(forKey: "highScore")
```


> 3. Modify project 5 so that it saves the current word and all the player’s entries to `UserDefaults`, then loads them back when the app launches.

This is the anagram game with table view cells of guesses of words that can be identified within the given letter.

- [x]  Add a UserDefault object of targetWord and guesses
- [x]  check if there's a userDefault saved, and if so reload it.

:question: *How do I want to structure my `UserDefault`?*


## :three:  [Review for Project 12: `UserDefaults`](https://www.hackingwithswift.com/review/hws/project-12-userdefaults) 

### :boom: Quiz insights

* UserDefaults lets us store program settings and user settings in one place.
  * All apps have access to their own `UserDefaults`.
* Using `Codable` is preferred when you have an app that's written only in Swift.
  * `Codable` takes much less work than `NSCoding`, and is safer too.
* Nil coalescing (`??`) lets us provide a default value to use if an optional is nil.
  * As much as I love optionals, I'd much rather have real types to work with, and nil coalescing helps provide just that.
* Your app's default `UserDefaults` settings get loaded when the app launches.
  * This ensures your data is immediately available for reading.
* `NSCoding` uses string names for the keys it writes out.
  * This makes it easy to think about, but also easy to break with typos.
* A type that conforms to `NSCoding` must be a class that inherits from `NSObject`.
  * This is because `NSCoding` comes from Objective-C and doesn't understand Swift's structs.
* You shouldn't save too much information in `UserDefaults`, because it might slow down your app launch.
  * If you save too much information your app will actually be killed by the system because of its slow launch.
* :red_circle: ~~We need to ask the user's permission to read from `UserDefaults`.~~
  * We can write to `UserDefaults` without the user knowing. ( :warning: eek :o isn't this kind of sketchy? Can apps look at other apps UserDefalts? Are they sanboxed somehow :question:  )
* Types that conform to NSCoding can be written to UserDefaults.
  * Lots of built-in types conform to NSCoding already, such as UIColor and SKSpriteNode.
* The Codable protocol can convert Swift types to and from JSON.
  * It can also write to XML, but JSON is more common.
* It's the job of NSKeyedArchiver to convert NSCoding objects into Data
  * To go the other way – to convert from Data to custom types – you should use NSKeyedUnarchiver.
* Most built-in Swift types are compatible with NSCoding, including strings, integers, Booleans, and more.
  * These can all be written to both NSCoding and Codable without extra work.
* ~~You can encode any Codable object using the NSCoding class.~~
  * :red_circle: _NSCoding is a `protocol`, not a class_, and has its own set of rules separate from Codable.