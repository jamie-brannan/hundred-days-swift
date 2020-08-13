# Day 22 (3), Week 17 
:calendar: – Thursday August 06, 2020

### :boom: Quiz insights

:question: *Which of these statements are true?*

* :white_check_mark: The **target** of an action refers to where that method will be run.
>The target refers to where the code will be run, and the **action** refers to what code will be run.
* :white_check_mark: Our app's `Info.plist` file contains settings that won't change.
> This file is there to describe things like the name going under our icon, any special URLs we want to handle, or system messages we want to show to users.
* :question: Activity view controllers must be presented from something on iPad.
>On iPad, iOS wants to connect activity view controllers to whatever triggered them, so that users have some extra context.
* :white_check_mark: `#selector` allows Swift to check that a method exists while building our code
>Selectors are a simple way of saying "here's the function I want you to run". They pre-date Swift.
* :white_check_mark: Activity view controllers can have custom application items.
>You can attach custom actions to run inside your application if you want to.
* :white_check_mark: `@IBAction` automatically implies `@objc`
>Because `@IBAction` means you're connecting storyboards (Objective-C code) to Swift code, it always implies `@objc` as well.

:tada: Only one wrong ! Yay ! :)

## :gift: Wrap-up Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you can apply your knowledge to make sure you fully understand what’s going on:
>
> 1) Try adding the image name to the list of items that are shared. The `activityItems` parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will.
>
> 2) Go back to **project 1** and add a bar button item to the main view controller that recommends the app to other people.
>
> 3) Go back to **project 2** and add a bar button item that shows their score when tapped.

### :one: Adding the _image name_ to the list of items that are shared

>The `activityItems` parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will.

```swift
  @objc func shareTapped() {
    // Just one of the things that's in the array that'll be shared
      guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
          print("No image found")
          return
      }

    // So just need to add image name here??

    // Array here
      let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
      vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
      present(vc, animated: true)
  }
```

### :two: **Project 1** and add a bar button item to the main view controller

:pushpin: [**HackingSwifth**](https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example) : *UIActivityViewController by example*

:pushpin: [**StackOverflow**](https://stackoverflow.com/questions/35861962/share-app-link-to-by-activityviewcontroller-ios-swift) : *Share app link by Activity View controller iOS Swift*

```swift
if let name = URL(string: "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8"), !name.absoluteString.isEmpty {
        let objectsToShare = [name]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

        self.present(activityVC, animated: true, completion: nil)
    }else  {
        // show alert for not available
    }
```

:pushpin: [**NSHipster**](https://nshipster.com/uiactivityviewcontroller/) : *Adding Custom UIActivityViewController*

:pushpin: [**Ray Wenderlich**](https://www.raywenderlich.com/813044-uiactivityviewcontroller-tutorial-sharing-data#toc-anchor-002) : *UIActivityController*

>#### UTIs and Your Plist
>The first thing you need to do is set up your Info.plist to let iOS know your app can handle Book Tracker Documents.
>
>To do this, you need to register your app as being able to handle certain Uniform Type Identifiers, or UTIs, exporting any UTIs that are not already known by the system.
>
>In summary, UTIs are unique identifiers that represent documents. There are UTIs already built into iOS for handling common document types such as public.jpeg or public.html.
>
>##### Defining Your UTIs
>You’re going to register your app to handle documents with the com.raywenderlich.BookTracker.btkr UTI representing the description of a book.
>
>You’ll give iOS information about the UTI, such as what file name extension it uses, what mime type it’s encoded as when sharing and, finally, the file’s icon.
>
>So now it’s time to see it in action! Open Info.plist and add the following entries under the Information Property List key:
>
>You can read up on what each of these values mean in Apple’s UTI guide, but here are the important things to note:
>
>The Document types entry defines what UTIs your app supports — in your case, the com.raywenderlich.BookTracker.btkr UTI, as an Owner/Editor.
>
>Document types is also where you set the names of the icons that iOS should use when displaying your file type. You’ll need to make sure you have an icon for each of the sizes listed in the plist.
>
>The Exported Type UTIs entry gives some information about com.raywenderlich.BookTracker.btkr, since it isn’t a public UTI. Here you define that your app can handle files ending in .btkr or files that have a mime type of application/booktracker.