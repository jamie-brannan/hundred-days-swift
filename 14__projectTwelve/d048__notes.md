# *Day 48 • Saturday February 13, 2021*

>Douglas Adams once said, _“most of the time spent wrestling with technologies that don't quite work yet is just not worth the effort for end users, however much fun it is for nerds like us.”_ 
>
>And of course he was right: when software doesn’t quite work we sometimes see it as a challenge to find a workaround, whereas everyone else in the world just gets annoyed or gives up.
>
>**Think about how often you see a Save button in iOS**. Hardly ever, right? This isn’t an accident: iOS makes it look like all apps are running all the time _when really they get backgrounded or even terminated all the time_, but u**sers don’t want to have to think about saving files before** a program is quit.
>
>This behavior is a great example of how Apple takes away the annoyance for end users – **they don’t have to expend the effort of managing data or worrying about programs**, which means they can instead focus on **just using their device for the things** they actually care about.

This is so true and I cannot believe I never realized this until now. Pretty awesome.

>Now it falls to us. Project 10 worked great, _except that it doesn’t save the pictures users add_. Today you’re going to learn one of the ways we can fix that, and we’ll look at a different option tomorrow.
>
>**Today you have three topics to work through, and you’ll learn about `UserDefaults`, `NSCoding` and more.**

- [*Day 48 • Saturday February 13, 2021*](#day-48--saturday-february-13-2021)
  - [:one:  Setting up](#one--setting-up)
  - [:two:  Reading and writing basics `UserDefaults`](#two--reading-and-writing-basics-userdefaults)
  - [:three:  Fixing project 10: `NSCoding`](#three--fixing-project-10-nscoding)

## :one:  [Setting up](https://www.hackingwithswift.com/read/12/1/setting-up) 

>This is our fourth technique project, and we're going to go back to project 10 and fix its glaring bug: **all the names and faces you add to the app don't get saved**, which makes the app rather pointless!
>
>We're going to fix this using a new class called `UserDefaults` and a new protocol `NSCoding` – it’s similar in intent to the `Codable` protocol we used when working with JSON, but the former is available only to Swift developers whereas the latter is also available to Objective-C developers.

I actually have been working on this for the past two weeks, but had a difficult time grasping it so I'm excited to actually have a better grip on this.

>Along the way you’ll also use the classes `NSKeyedArchiver` and `NSKeyedUnarchiver` (for use with `NSCoding`), and `JSONEncoder` and `JSONDecoder` (for use with `Codable`), all of which are there to convert custom objects into data that can be written to disk.

I know encode and decoding but "key archiving" doesn't ring a bell.

>Putting all that together, we're going to update project 10 so that it saves its `people` array whenever anything is changed, then loads when the app runs.
>
>We're going to be modifying project 10 twice over, once for each method of solving the problem, so I suggest you take **a copy of the project 10 folder twice** – call the copies _project12a_ and _project12b_.

Copies made :white_check_mark: 

## :two:  [Reading and writing basics `UserDefaults`](https://www.hackingwithswift.com/read/12/2/reading-and-writing-basics-userdefaults) 

>You can use `UserDefaults` to store any basic data type for as long as the app is installed. You can write basic types such as `Bool`, `Float`, `Double`, `Int`, `String`, or `URL`, but you can also write more complex types such as arrays, dictionaries and `Date` – and even `Data` values.
>
>When you write data to `UserDefaults`, _it automatically gets loaded when your app runs so that you can read it back again._ 
>* **This makes using it really easy, but you need to know that it's a bad idea to store lots of data in there because it will slow loading of your app. **
>
>If you think your saved data would take up **more than say 100KB, `UserDefaults` is almost certainly the wrong choice.**

Understood :+1: there's limits

>Before we get into modifying project 10, we're going to do a little bit of test coding first to try out what `UserDefaults` lets us do. You might find it useful to _create a fresh Single View App project_ just so you can test out the code.
>
>To get started with `UserDefaults`, you create a new instance of the class like this:
 
```swift
let defaults = UserDefaults.standard
```

>Once that's done, it's easy to set a variety of values – you just need to give each one a unique key so you can reference it later. These values nearly always have no meaning outside of what you use them for, so just make sure the key names are memorable.
>
>Here are some examples:

```swift
let defaults = UserDefaults.standard
defaults.set(25, forKey: "Age")
defaults.set(true, forKey: "UseTouchID")
defaults.set(CGFloat.pi, forKey: "Pi")
```

>You can also use the `set()` to store strings, arrays, dictionaries and dates. Now, here's a curiosity that's worth explaining briefly: in Swift, strings, arrays and dictionaries are all structs, not objects. But `UserDefaults` was written for `NSString` and friends – all of which are 100% interchangeable with Swift their equivalents – which is why this code works.
>
>Using `set()` for these advanced types is just the same as using the other data types:

```swift
defaults.set("Paul Hudson", forKey: "Name")
defaults.set(Date(), forKey: "LastRun")
```

>Even if you're trying to save complex types such as arrays and dictionaries, `UserDefaults` laps it up:

```swift
let array = ["Hello", "World"]
defaults.set(array, forKey: "SavedArray")

let dict = ["Name": "Paul", "Country": "UK"]
defaults.set(dict, forKey: "SavedDict")
```

>That's enough about writing for now; let's take a look at reading.
>
>When you're reading values from `UserDefaults` you need to check the return type carefully to ensure you know what you're getting. Here's what you need to know:
>
>* `integer(forKey:)` returns an integer if the key existed, or 0 if not.
>* `bool(forKey:)` returns a boolean if the key existed, or false if not.
>* `float(forKey:)` returns a float if the key existed, or 0.0 if not.
>* `double(forKey:)` returns a double if the key existed, or 0.0 if not.
>* `object(forKey:)` returns Any? so you need to conditionally typecast it to your data type.
>
>Knowing the return values are important, because if you use bool(forKey:) and get back "false", does that mean the key didn't exist, or did it perhaps exist and you just set it to be false?
>
>It's object(forKey:) that will cause you the most bother, because you get an optional object back. You're faced with two options, one of which isn't smart so you realistically have only one option!
>
>Your options:
> 
> * Use `as!` to force typecast your object to the data type it should be.
> * Use `as?` to optionally typecast your object to the type it should be.
>
>If you use as! and object(forKey:) returned nil, you'll get a crash, so I really don't recommend it unless you're absolutely sure. But equally, using as? is annoying because you then have to unwrap the optional or create a default value.
>
>There is a solution here, and it has the catchy name of the nil coalescing operator, and it looks like this: ??. This does two things at once: if the object on the left is optional and exists, it gets unwrapped into a non-optional value; if it does not exist, it uses the value on the right instead.
>
>This means we can use object(forKey:) and as? to get an optional object, then use ?? to either unwrap the object or set a default value, all in one line.
>
>For example, let's say we want to read the array we saved earlier with the key name SavedArray. Here's how to do that with the nil coalescing operator:

```swift
let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()

```

>So, if SavedArray exists and is a string array, it will be placed into the array constant. If it doesn't exist (or if it does exist and isn't a string array), then array gets set to be a new string array.
>
>This technique also works for dictionaries, but obviously you need to typecast it correctly. To read the dictionary we saved earlier, we'd use this:

```swift
let dict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
```


## :three:  [Fixing project 10: `NSCoding`](https://www.hackingwithswift.com/read/12/3/fixing-project-10-nscoding) 

>You've just learned all the core basics of working with `UserDefaults`, but we're just getting started. You see, above and beyond integers, dates, strings, arrays and so on, you can also save any kind of data inside `UserDefaults` as long as you follow some rules.
>
>What happens is simple: you use the `archivedData()` method of `NSKeyedArchiver`, which turns an object graph into a `Data` object, then write that to `UserDefaults` as if it were any other object. If you were wondering, “object graph” means “your object, plus any objects it refers to, plus any objects those objects refer to, and so on.”
>
>The rules are very simple:
>
>
>1. All your data types must be one of the following: boolean, integer, float, double, string, array, dictionary, `Date`, or a class that fits rule 2.
>
>2. If your data type is a class, it must conform to the NSCoding protocol, which is used for archiving object graphs.
>
>3. If your data type is an array or dictionary, all the keys and values must match rule 1 or rule 2.
>
>Many of Apple's own classes support NSCoding, including but not limited to: `UIColor`, `UIImage`, `UIView`, `UILabel`, `UIImageView`, `UITableView`, `SKSpriteNode` and many more. But your own classes do not, at least not by default. If we want to save the people array to `UserDefaults` we'll need to conform to the `NSCoding` protocol.
>
>The first step is to modify your `Person` class to this:

```swift
class Person: NSObject, NSCoding {
```

>When we were working on this code in project 10, there were two outstanding questions:
>
>* Why do we need a class here when a struct will do just as well? (And in fact better, because structs come with a default initializer!)
>
>* Why do we need to inherit from `NSObject`?
>
>It's time for the answers to become clear. You see, working with `NSCoding` requires you to use objects, or, in the case of strings, arrays and dictionaries, structs that are interchangeable with objects. If we made the Person class into a struct, we couldn't use it with `NSCoding`.
>
>The reason we inherit from `NSObject` is again because it's required to use `NSCoding` – although cunningly Swift won't mention that to you, your app will just crash.
>
>Once you conform to the `NSCoding` protocol, you'll get compiler errors because the protocol requires you to implement two methods: a new initializer and `encode()`.
>
>We need to write some more code to fix the problems, and although the code is very similar to what you've already seen in `UserDefaults`, it has two new things you need to know about.
>
>First, you'll be using a new class called `NSCoder`. This is responsible for both encoding (writing) and decoding (reading) your data so that it can be used with `UserDefaults`.
>
>Second, the new initializer must be declared with the `required` keyword. This means "if anyone tries to subclass this class, they are required to implement this method." An alternative to using `required` is to declare that your class can never be subclassed, known as a final class, in which case you don't need `required` because subclassing isn't possible. We'll be using `required` here.
>
>Add these two methods to the `Person` class:

```swift
required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
}

func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(image, forKey: "image")
}
```

>The initializer is used when loading objects of this class, and `encode()` is used when saving. The code is very similar to using `UserDefaults`, but here we’re adding `as?` typecasting and nil coalescing just in case we get invalid data back.
>
>With those changes, the `Person` class now conforms to `NSCoding`, so we can go back to ViewController.swift and add code to load and save the people array.
>
>Let's start with writing, because once you understand that the reading code will make much more sense. As I said earlier, you can write Data objects to `UserDefaults`, but we don't currently have a Data object – we just have an array.
>
>Fortunately, the `archivedData()` method of `NSKeyedArchiver` turns an object graph into a Data object using those `NSCoding` methods we just added to our class. Because we make changes to the array by adding people or by renaming them, let's create a single `save()` method we can use anywhere that's needed:

```swift
func save() {
    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    }
}
```

>So: line 1 is what converts our array into a Data object, then lines 2 and 3 save that data object to `UserDefaults`. You now just need to call that `save()` method when we change a person's name or when we import a new picture.
>
>You need to modify our collection view's didSelectItemAt method so that you call `self.save()` just after calling `self.collectionView.reloadData()`. Remember, the self is required because we're inside a closure. You then need to modify the image picker's `didFinishPickingMediaWithInfo` method so that it calls `save()` just before the end of the method.
>
>And that's it – we only change the data in two places, and both now have a call to `save()`.
>
>Finally, we need to load the array back from disk when the app runs, so add this code to `viewDidLoad()`:

```swift
let defaults = UserDefaults.standard

if let savedPeople = defaults.object(forKey: "people") as? Data {
    if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
        people = decodedPeople
    }
}
```

>This code is effectively the save() method in reverse: we use the object(forKey:) method to pull out an optional Data, using if let and as? to unwrap it. We then give that to the unarchiveTopLevelObjectWithData() method of NSKeyedUnarchiver to convert it back to an object graph – i.e., our array of Person objects.

