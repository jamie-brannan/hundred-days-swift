# *Day 44 • Thursday February 04, 2021*

>That’s another app completed, and several more important components learned: collection views for grids, image pickers for browsing in the photo library, UUID for making unique identifiers, and more.
>
>None of those are small things: I hope you can really see your progress, and all being well you’re already mentally preparing for the end-of-project challenges we always have.
>
>I realize these challenges can be tough, but I want to encourage you to keep on going. When you get results you’re learning, but when you make mistakes you’re learning almost as much – it all counts, and as Denis Waitley said, “the results you achieve will be in direct proportion to the effort you apply.”
>
>**Today you should work through the wrap up chapter for project 10, complete its review, then work through all three of its challenges.**

- [*Day 44 • Thursday February 04, 2021*](#day-44--thursday-february-04-2021)
  - [:one:  Wrap up](#one--wrap-up)
    - [Challenge](#challenge)
  - [:two:  Review for Project 10: Names to Faces](#two--review-for-project-10-names-to-faces)
    - [:boom: Quiz insights](#boom-quiz-insights)

## :one:  [Wrap up](https://www.hackingwithswift.com/read/10/7/wrap-up) 

>`UICollectionView` and `UITableView` are the most common ways of showing lots of information in iOS, and you now know how to use both. You should be able to go back to project 1 and recognize a lot of very similar code, and that's by intention – Apple has made it easy to learn both view types by learning either one.
>
>You've also learned another batch of iOS development, this time `UIImagePickerController`, `UUID`, custom classes and more. You might not realize it yet, but you have enough knowledge now to make a huge range of apps!
>
>Before we finish, you may have spotted one problem with this app: **if you quit the app and relaunch, it hasn't remembered the people you added**. Worse, the JPEGs are still stored on the disk, so your app takes up more and more room without having anything to show for it!
>
>This is quite intentional, and something we'll return to fix in project 12. Before then, let's take a look at another game…

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
>   - [x]  Add a second `UIAlertController` that gets shown when the user taps a picture, asking them whether they want to rename the person or delete them.

Add an action the preceeds the current renaming alert.

```swift
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let person = people[indexPath.item]
    
    let ac = UIAlertController(title: "Edit Contact", message: "How would you like to modify this contact?", preferredStyle: .alert)
    
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    ac.addAction(UIAlertAction(title: "Rename", style: .default) { [weak self, weak ac] _ in
      guard let newName = ac?.textFields?[0].text else { return }
      person.name = newName
      
      self?.collectionView.reloadData()
    })
    
    ac.addAction(UIAlertAction(title: "Delete", style: .default) {_ in
      self.people.remove(at: indexPath.item)
      
      collectionView.reloadData()
    })
    
    present(ac, animated: true)
  }
```


>  - [x]  Try using `picker.sourceType = .camera` when creating your image picker, **which will tell it to create a new image by taking a photo.** This is only available on devices (not on the simulator) so you might want to check the return value of `UIImagePickerController.isSourceTypeAvailable()` before trying to use it!

  - [x]  test on device

>   - [ ]  Modify project 1 so that it uses a collection view controller rather than a table view controller. I recommend you keep a copy of your original table view controller code so you can refer back to it later on.

:white_check_mark: Refactoring page.

## :two:  [Review for Project 10: Names to Faces](https://www.hackingwithswift.com/review/hws/project-10-names-to-faces) 

### :boom: Quiz insights

* We can create custom classes for our collection view cells
* When the user selects a picture using UIImagePickerController we'll be sent a dictionary of data.
  * Apple prefers using dictionaries for this purpose because it allows them to expand it to add more things later on if needed.
* The path property of a URL gives us the location as a string.
  * It's helpful for APIs that use a string for the filename rather than a URL.
* UIImagePickerController lets us read photos from the user's photo library.
  * This is exactly what it's for, and it can also let us take photos using the camera.
* UIKit re-uses collection view cells for performance reasons.
  * As soon as one scrolls offscreen it becomes eligible for re-use.
* Data can hold any kind of binary data
  * It might be a zip file, it might be a JPEG, or it might just be a string stored as binary data.
* Each app has its own documents directory.
  * It's stored in a location we can't guess, so we need to read it using FileManager.
* Collection view items are referenced using section and item rather than section and row.
  * Collection views work as grids by default, so they don't have a concept of "rows".
* When dequeueing a custom collection view cell we need to typecast it to our specific type
  * UIKit gives us back a general UICollectionViewCell, but we know it's actually our custom type so we need to use as or as? to convert it.
* CALayer can add borders and round corners of views.
  * Every UIView has a layer property that we can manipulate in this way.
* We can force a UICollectionView to reload all its data by calling its reloadData() method
  * This works just the same as with UITableView.
* UIColor can be created as a grayscale color.
  * There's a dedicated UIColor(white:alpha:) initializer just for this purpose.

:tada: 12/12 

