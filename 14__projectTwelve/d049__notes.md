# *Day 49 • Thursday February 25, 2021*

>Alan Perlis once said _“fools ignore complexity; pragmatists suffer it; some can avoid it; geniuses remove it.”_ Today you’re going to see that in Swift code: _rather than_ try to simplify the code for `NSCoding`, the Swift team found a way to remove it entirely using the `Codable` protocol.
>
>Sometimes you won’t have a choice and need to use `NSCoding`, but where possible **`Codable` is both easier and safer to use**. 
>* You do need to know them both, though, and by seeing them both used to solve the same problem hopefully you’ll able to decide for yourself which you prefer.
>
>Before you get down to work, here’s another fun **Swift in-joke** for you: sometimes you might see T-shirts with _a picture of a fish followed by “able”_, but before you scratch your head wondering what “fishable” might mean please remember that “COD” is a type of fish!
>
>**Today you should work through the `Codable` chapter and wrap up for project 12, complete its review, then work through all three of its challenges.**

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

## :three:  [Review for Project 12: `UserDefaults`](https://www.hackingwithswift.com/review/hws/project-12-userdefaults) 