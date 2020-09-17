# Day 23 (3)
:calendar: – Thursday September 17, 2020

:desert_island: been on vacation, and picking back up the challenge

## Picking back up

Added a condition so that whatever is an acronym is capitalized accordingly.

```swift
    /// view the table at cell row
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
    /// get file name
    let flagFileName = flags[indexPath.row]
    /// title the cell with the file name minus the end of the name
    let cellTitle = flagFileName.replacingOccurrences(of: "@2x.png", with: "")
    /// if the cell title has two letters, it's an acronym that needs to be capitalized
    if cellTitle.count == 2 {
        cell.textLabel?.text = cellTitle.uppercased()
    } else {
        cell.textLabel?.text = cellTitle.capitalizingFirstLetter()
    }
    return cell
  }
}
```

### Remaining part of the challenge going on

>3) Create a new Cocoa Touch Class responsible for the **detail view controller**, and give it properties for its image view and the image to load.

We now have a table with arrows on the right, but when you touch them it doesn't push to anything.
* we don't have a new template for next page yet
* we also haven't set up the data that we want to send to that page from here.

:red_circle: `Thread 1: Exception: "[<Consolidation2.DetailViewController 0x7fc1e7e087a0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key selectedImage."`
* After writing the `didSelectRowAt` and starting the `DetailViewController` class

:bulb: **Need** to redo the outlet because I changed the name?
* :white_check_mark: yes

### No picture?

1) In previous picture viewer, we have a folder of contents in the root, that's looped through based on the file name and appended.

```sh
(lldb) po pictures
▿ 10 elements
  - 0 : "nssl0049.jpg"
  - 1 : "nssl0046.jpg"
  - 2 : "nssl0091.jpg"
  - 3 : "nssl0045.jpg"
  - 4 : "nssl0051.jpg"
  - 5 : "nssl0041.jpg"
  - 6 : "nssl0042.jpg"
  - 7 : "nssl0043.jpg"
  - 8 : "nssl0033.jpg"
  - 9 : "nssl0034.jpg"
```

2) The entry point table view is loaded
3) We select one of the items

IBOutlet var is created

SelectedImage var is created

Nothing is assigned to either of them

`didSelectRowAt` call back has instantiated a Detail view :point_up:

Now it is in the block and selecting what from the entry point is to be passed.

:bulb: **this is where we have an issue because we've made a new name but we need the file name not the cell title that we have wanted**

:arrow_right: ooooooor maybe not? :worried:

```sh
(lldb) po flags[indexPath.row]
"spain@2x.png"
```

actually I think this was getting over written with a `nil` when it arrived on the DetailControler.

:bulb: **USE THE :eye: DEBUGGER TOOL TO CHECK IF ITS CONSTRAINTS FOR THE SEND**

>4) You’ll also need to adjust your storyboard to include the detail view controller, including using Auto Layout to pin its image view correctly.
>5) You will need to use `UIActivityViewController` to share your flag.
>
>As always, I’m going to provide some hints below, but I suggest you try to complete as much of the challenge as you can before reading them.
>
>Hints:
>
>To load the images from disk you need to use three lines of code: `let fm = FileManager.default`, then `let path = Bundle.main.resourcePath!`, then finally `let items = try! fm.contentsOfDirectory(atPath: path)`.
>
>Those lines end up giving you an array of all items in your app’s bundle, but you only want the pictures, so you’ll need to use something like the `hasSuffix()` method.
>
>Once you have made `ViewController` build on `UITableViewController`, you’ll need to `override` its `numberOfRowsInSection` and `cellForRowAt` methods.
>
>You’ll need to assign a cell prototype identifier in Interface Builder, such as “Country”. You can then dequeue cells of that type using `tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)`.
>
>The `didSelectItemAt` method is responsible for taking some action when the user taps a row.

:bulb: This is a callback actually !

>Make sure your detail view controller has a property for the image name to load, as well as the UIImageView to load it into. The former should be modified from ViewController inside didSelectItemAt; the latter should be modified in the viewDidLoad() method of your detail view controller.
>
>**Bonus tip**: try setting the imageView property of the table view cell. Yes, they have one. And yes, it automatically places an image right there in the table view cell – it makes a great preview for every country.