# Day 23 (2), Week 19
:calendar: – Thursday August 20, 2020

- [Day 23 (2), Week 19](#day-23-2-week-19)
  - [:three:  Challenge](#three--challenge)
      - [Need to have tiles findable.](#need-to-have-tiles-findable)
      - [Because the cells are nill?](#because-the-cells-are-nill)
      - [We need to remove the file name at the end.](#we-need-to-remove-the-file-name-at-the-end)
      - [Tried using a `regex`](#tried-using-a-regex)
## :three:  [Challenge](https://www.hackingwithswift.com/guide/2/3/challenge) 

>You have a rudimentary understanding of table views, image views, and navigation controllers, so let’s put them together: your challenge is to create an app that lists various world flags in a table view. When one of them is tapped, slide in a detail view controller that contains an image view, showing the same flag full size. On the detail view controller, add an action button that lets the user share the flag picture and country name using `UIActivityViewController`.

>To solve this challenge you’ll need to draw on skills you learned in tutorials 1, 2, and 3:
>
> ### :one:  Start with a Single View App template, then change its main `ViewController` class so that builds on `UITableViewController` instead.


>
> ### :two:  Load the list of available flags from the app bundle. You can type them directly into the code if you want, but it’s preferable not to.

#### Need to have tiles findable.

```sh
./03__consolidation_ii/Consolidation2/Consolidation2/Contents/
├── estonia@2x.png
├── estonia@3x.png
├── france@2x.png
├── france@3x.png
├── germany@2x.png
├── germany@3x.png
├── ireland@2x.png
├── ireland@3x.png
├── italy@2x.png
├── italy@3x.png
├── monaco@2x.png
├── monaco@3x.png
├── nigeria@2x.png
├── nigeria@3x.png
├── poland@2x.png
├── poland@3x.png
├── russia@2x.png
├── russia@3x.png
├── spain@2x.png
├── spain@3x.png
├── uk@2x.png
├── uk@3x.png
├── us@2x.png
└── us@3x.png
```

We only one one of each so go for `hasSuffix("2x.png")` to get a total of 12 items

```swift
    /// constant with datatype FileManager
    /// to examine the contents of a filesystem
    let fm = FileManager.default

    /// path of where our compiled program is
    let path =  Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

    for item in items {
      if item.hasPrefix("flag") {
        flags.append(item)
      }
    }

    print("Flags are : \(flags)")
```

:red_circle: Readded the `Contents` folder with renamed flag files.
```sh
Thread 1: Exception: "UITableView dataSource returned a nil cell for row at index path: <NSIndexPath: 0xc275d30214a2cdd0> {length = 2, path = 0 - 0}. Table view: <UITableView: 0x7f8fc7835400; frame = (0 0; 414 896); autoresize = W+H; gestureRecognizers = <NSArray: 0x600000b770c0>; layer = <CALayer: 0x60000051e060>; contentOffset: {0, -140}; contentSize: {414, 1056}; adjustedContentInset: {140, 0, 34, 0}; dataSource: <_UIFilteredDataSource: 0x600000b74900>>, dataSource: <_UIFilteredDataSource: 0x600000b74900>"
```

#### Because the cells are nill?

```swift
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
    cell.textLabel?.text = flags[indexPath.row]
//    cell.imageView?.image = flags[indexPath]
    return cell
  }
```

:red_circle: `Thread 1: Exception: "unable to dequeue a cell with identifier flagCell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard"`

* :bulb: Oops! Thought I had added a cell to the table view in the storyboard but between trying things here and there, I'd forgotten

#### We need to remove the file name at the end.

* :pushpin: [**StackOverflow**](https://stackoverflow.com/questions/24122288/remove-last-character-from-string-swift-language#24122445) : *Remove last character form string swift language*

```swift
var str = "Hello, World"                           // "Hello, World"
str.dropLast()                                     // "Hello, Worl" (non-modifying)
str                                                // "Hello, World"
String(str.dropLast())                             // "Hello, Worl"

str.remove(at: str.index(before: str.endIndex))    // "d"
str                                                // "Hello, Worl" (modifying)
```

:x: Not the right way to go

#### Tried using a `regex`

Help with the community regexes in [IBM generator](https://regexr.com/)

```swift
let regex = NSRegularExpression("(@2x\.\w+$)")
```

>3) Create a new Cocoa Touch Class responsible for the detail view controller, and give it properties for its image view and the image to load.
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