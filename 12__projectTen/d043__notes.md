# *Day 43 • Saturday January 30, 2021*

>Today we’re going to be doing something so simple, yet so fundamentally important to the app development experience: **we’re going to be adding user’s photos to our app.**
>
>I know, it’s simple, right? And UIKit does make it simple. But as you’ll see, adding user photos to your app does something important: it makes your app theirs. They have customized it with the faces and places they love, and it brings the whole thing to life.
>
>With this power comes an important proviso: when **they allow us to read their private life** like that, you need to take that privacy permission to heart and live by it. Some other platforms play fast and loose with user privacy, but in the iOS world you’d do well to live by the words of Valerie Plame: _“Privacy is precious – I think privacy is the last true luxury. To be able to live your life as you choose without having everyone comment on it or know about.”_

Privacy by design :metal: It's the law out here.

>So, don’t share it outside the app without the user’s express permission, don’t put it on your server, and don’t even send off analytics data unless its homogenized and anonymized. Please be a good iOS citizen!
>
>**Today you have three topics to work through, and you’ll learn about `UIImagePickerController`, `NSObject`, and more.**

- [*Day 43 • Saturday January 30, 2021*](#day-43--saturday-january-30-2021)
  - [:one:  Importing photos with `UIImagePickerController`](#one--importing-photos-with-uiimagepickercontroller)
    - [`didFinishPickingMediaWithInfo`](#didfinishpickingmediawithinfo)
  - [:two:  Custom Subclasses of `NSObject`](#two--custom-subclasses-of-nsobject)
  - [:three:  Connecting up the people](#three--connecting-up-the-people)

## :one:  [Importing photos with `UIImagePickerController`](https://www.hackingwithswift.com/read/10/4/importing-photos-with-uiimagepickercontroller) 

>There are lots of collection view events to handle when the user interacts with a cell, but we'll come back to that later. For now, let's look at how to import pictures using `UIImagePickerController`. 
>
>This new class is designed to **let users select an image from their camera to import into an app**. When you first create a `UIImagePickerController`, iOS will automatically ask the user whether the app can access their photos.

We're going to need to modify `plist.info` eventually right? :crystal_ball:
 
>First, we need to create a button that lets users add people to the app. This is as simple as putting the following into the `viewDidLoad()` method:

```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
```

:iphone: I needed to embed the CollectionView in the `storyboard` in a navigation controller.

>The `addNewPerson()` method is where we need to use the `UIImagePickerController`, but it's so easy to do I'm just going to show you the code:

```swift
@objc func addNewPerson() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
}
```

>There are three interesting things in there:
>
> 1. We set the `allowsEditing` property to be true, which _allows the user to crop the picture they select_.
>
> 2. When you set `self` as the delegate, you'll need to conform not only to the `UIImagePickerControllerDelegate` protocol, but also the `UINavigationControllerDelegate` protocol.
>
> 3. The whole method is being called from Objective-C code using `#selector,` so we need to use the `@objc` attribute. This is the last time I’ll be repeating this, but hopefully you’re mentally always expecting `#selector` to be paired with `@objc`.

:white_check_mark: Got it.

>In ViewController.swift, modify this line:

```swift
class ViewController: UICollectionViewController {
```

>To this:

```swift
class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
```

>That tells Swift **you promise your class supports all the functionality required by the two protocols** `UIImagePickerControllerDelegate` and `UINavigationControllerDelegate`. 
>
>The first of those protocols is useful, **telling us when the user either selected a picture or cancelled the picker**. 
>
>The second, `UINavigationControllerDelegate`, really is quite pointless here, so don't worry about it beyond just modifying your class declaration to include the protocol.
>
>When you conform to the `UIImagePickerControllerDelegate` protocol, you don't need to add any methods because both are optional. But they aren't really – they are marked optional for whatever reason, but your code isn't much good unless you implement at least one of them!

Okay, I can kind of remember things about conforming to different protocols and handling optionals. Navigation Controllers also seem to be really difficult to follow for me.
* :question: *Maybe read up in RW apprentice book?*

### `didFinishPickingMediaWithInfo`

>The delegate method we care about is `imagePickerController(_, didFinishPickingMediaWithInfo:)`, which **returns when the user selected an image and it's being returned to you**. This method needs to do several things:
>
>* Extract the image from the dictionary that is passed as a parameter.
>
>* Generate a unique filename for it.
>
>* Convert it to a JPEG, then write that JPEG to disk.
>
>* Dismiss the view controller.
>
>To make all this work you're going to need to learn a few new things.
>
> :one:  **First, it's very common for Apple to send you a dictionary of several pieces of information as a method parameter.** This can be hard to work with sometimes because you need to know the names of the keys in the dictionary in order to be able to pick out the values, but you'll get the hang of it over time.
>
>This dictionary parameter _will contain one of two keys_: 
>
>* `.editedImage` (the image that was edited) or `.originalImage`, 
>
>* but in our case it should only ever be the former unless you change the `allowsEditing` property.
>
>_The problem is, we don't know if this value exists as a `UIImage`, so we can't just extract it._ Instead, we need to use **an optional method of typecasting**, `as?`, along with `if let`. Using this method, we can be sure we always get the right thing out.
>
> :two: Second, **we need to generate a unique filename for every image we import**. This is so that we can copy it to our app's space on the disk without overwriting anything, and if the user ever deletes the picture from their photo library we still have our copy. **We're going to use a new type for this, called `UUID`,** which generates a _Universally Unique Identifier_ and is perfect for a random filename.
>
> :three: Third, once we have the image, **we need to write it to disk**. 
> 
> You're going to need to learn two new pieces of code: 
> * `UIImage` has a `jpegData()` to convert it to a Data object in JPEG image format, 
> * and there's a method on `Data` called `write(to:)` that, well, writes its data to disk. 
> 
> We used `Data` earlier, but as a reminder it’s a relatively simple data type that can hold any type of binary type – image data, zip file data, movie data, and so on.
>
>Writing information to disk is easy enough, but finding where to put it is tricky. 

This sounds tricky but logical.

**All apps that are installed have a directory called Documents where you can save private information for the app, and it's also automatically synchronized with iCloud.** 
>* The problem is, it's not obvious how to find that directory, so I have a method I use called `getDocumentsDirectory()` that does exactly that – you don't need to understand how it works, but you do need to copy it into your code.
>
>With all that in mind, here are the new methods:

```swift
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }

    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: imagePath)
    }

    dismiss(animated: true)
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
```

>Again, it doesn't matter how `getDocumentsDirectory()` works, but if you're curious: the first parameter of `FileManager.default.urls` asks for the documents directory, and its second parameter adds that **we want the path to be relative to the user's home directory**. This returns an array that nearly always contains only one thing: the user's documents directory. So, we pull out the first element and return it.
>
>Now onto the code that matters: as you can see I’ve used `guard` to pull out and typecast the image from the image picker, _because if that fails we want to exit the method immediately_. 
>
>We then create an `UUID` object, and use its `uuidString` property to extract the unique identifier as a string data type.
>
>The code then creates a new constant, `imagePath`, which takes the `URL` result of `getDocumentsDirectory()` and calls a new method on it: `appendingPathComponent()`. This is used when working with file paths, and adds one string (`imageName` in our case) to a path, including whatever path separator is used on the platform.
>
>Now that we have a `UIImage` containing an image and a path where we want to save it, we need to convert the `UIImage` to a `Data` object so it can be saved. To do that, we use the `jpegData()` method, which takes one parameter: a quality value between 0 and 1, where 1 is “maximum quality”.
>
>Once we have a `Data` object containing our JPEG data, we just need to unwrap it safely then write it to the file name we made earlier. That's done using the `write(to:)` method, which takes a filename as its parameter.
>
>So: users can pick an image, and we'll save it to disk. But this still doesn't do anything – you won't see the picture in the app, because we aren't doing anything with it beyond writing it to disk. To fix that, we need to create a custom class to hold custom data…


## :two:  [Custom Subclasses of `NSObject`](https://www.hackingwithswift.com/read/10/5/custom-subclasses-of-nsobject) 

>You already created your first custom class when you created the collection view cell. But this time we're going to do something very simple: we're going to create a class to hold some data for our app. So far you've seen how we can create arrays of strings by using `[String]`, but what if we want to hold an array of people?
>
>Well, the solution is to create a custom class. Create a new file and choose Cocoa Touch Class. Click Next and name the class “Person”, type “NSObject” for "Subclass of", then click Next and Create to create the file.
>
>`NSObject` is what's called a universal base class for all Cocoa Touch classes. That means all UIKit classes ultimately come from `NSObject`, including all of UIKit. You don't have to inherit from `NSObject` in Swift, but you did in Objective-C and in fact there are some behaviors you can only have if you do inherit from it. More on that in project 12, but for now just make sure you inherit from `NSObject`.
>
>We're going to add two properties to our class: a name and a photo for every person. So, add this inside the `Person` definition:

```swift
var name: String
var image: String
```

>When you do that, you'll see errors: "Class 'Person' has no initializers." Swift is telling us that we aren't satisfying one of its core rules: objects of type `String` can't be empty. Remember, `String!` and `String?` can both be `nil`, but plain old `String` can't – it must have a value. Without an initializer, it means the object will be created and these two variables won't have values, so you're breaking the rules.
>
>To fix this problem, we need to create an `init()` method that accepts two parameters, one for the name and one for the image. We'll then save that to the object so that both variables have a value, and Swift is happy.

```swift
init(name: String, image: String) {
    self.name = name
    self.image = image
}
```

>Our custom class is done; it's just a simple data store for now. If you're the curious type, you might wonder why I used a class here rather than a struct. This question is even more pressing once you know that structs have an automatic initializer method made for them that looks exactly like ours. Well, the answer is: you'll have to wait and see. All will become clear in project 12!
>
>With that custom class done, we can start to make our project much more useful: every time a picture is imported, we can create a `Person` object for it and add it to an array to be shown in the collection view.
>
>So, go back to ViewController.swift, and add this declaration for a new array:

```swift
var people = [Person]()
```

>Every time we add a new person, we need to create a new `Person` object with their details. This is as easy as modifying our initial image picker success method so that it creates a `Person` object, adds it to our `people` array, then reloads the collection view. Put this code before the call to `dismiss()`:

```swift
let person = Person(name: "Unknown", image: imageName)
people.append(person)
collectionView.reloadData()
```

>That stores the image name in the `Person` object and gives them a default name of "Unknown", before reloading the collection view.
>
>Can you spot the problem? If not, that's OK, but you should be able to spot it if you run the program.
>
>The problem is that although we've added the new person to our array and reloaded the collection view, we aren't actually using the `people` array with the collection view – we just return 10 for the number of items and create an empty collection view cell for each one! Let's fix that…

## :three:  [Connecting up the people](https://www.hackingwithswift.com/read/10/6/connecting-up-the-people) 


>We need to make three final changes to this project in order to finish: show the correct number of items, show the correct information inside each cell, then make it so that when users tap a picture they can set a person's name.
>
>Those methods are all increasingly difficult, so we'll start with the first one. Right now, your collection view's `numberOfItemsInSection` method just has `return 10` in there, so you'll see 10 items regardless of how many people are in your array. This is easily fixed:

```swift
override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return people.count
}
```

>Next, we need to update the collection view's `cellForItemAt` method so that it configures each `PersonCell` cell to have the correct name and image of the person in that position in the array. This takes a few steps:
>
>
>* Pull out the person from the `people` array at the correct position.
>
>* Set the `name` label to the person's name.
>
>* Create a `UIImage` from the person's image filename, adding it to the value from `getDocumentsDirectory()` so that we have a full path for the image.
>
>We're also going to use this opportunity to give the image views a border and slightly rounded corners, then give the whole cell matching rounded corners, to make it all look a bit more interesting. This is all done using `CALayer`, so that means we need to convert the `UIColor` to a `CGColor`. Anyway, here's the new code:

```swift
override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
        fatalError("Unable to dequeue PersonCell.")
    }

    let person = people[indexPath.item]

    cell.name.text = person.name

    let path = getDocumentsDirectory().appendingPathComponent(person.image)
    cell.imageView.image = UIImage(contentsOfFile: path.path)

    cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
    cell.imageView.layer.borderWidth = 2
    cell.imageView.layer.cornerRadius = 3
    cell.layer.cornerRadius = 7

    return cell
}
```

>There are three new things in there.
>
>First, notice how I’ve used `indexPath.item` rather than `indexPath.row`, because collection views don’t really think in terms of rows.
>
>Second, that code sets the `cornerRadius` property, which rounds the corners of a `CALayer` – or in our case the `UIView` being drawn by the `CALayer`.
>
>Third, I snuck in a new `UIColor` initializer: `UIColor(white:alpha:)`. This is useful when you only want grayscale colors.
>
>With that done, the app works: you can run it with Cmd+R, import photos, and admire the way they all appear correctly in the app. But don't get your hopes up, because we're not done yet – you still can't assign names to people!
>
>For this last part of the project, we're going to recap how to add text fields to a `UIAlertController`, just like you did in project 5. All of the code is old, but I'm going to go over it again to make sure you fully understand.
>
>First, the delegate method we're going to implement is the collection view’s `didSelectItemAt` method, which is triggered when the user taps a cell. This method needs to pull out the `Person` object at the array index that was tapped, then show a `UIAlertController` asking users to rename the person.
>
>Adding a text field to an alert controller is done with the `addTextField()` method. We'll also need to add two actions: one to cancel the alert, and one to save the change. To save the changes, we need to add a closure that pulls out the text field value and assigns it to the person's `name` property, then we'll also need to reload the collection view to reflect the change.
>
>That's it! The only thing that's new, and it's hardly new at all, is the setting of the `name` property. Put this new method into your class:

```swift
override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]

    let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
    ac.addTextField()

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
        guard let newName = ac?.textFields?[0].text else { return }
        person.name = newName

        self?.collectionView.reloadData()
    })

    present(ac, animated: true)
}
```

>Finally, the project is complete: you can import photos of people, then tap on them to rename. Well done!
