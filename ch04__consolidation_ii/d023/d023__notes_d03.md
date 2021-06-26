# Day 23 (3)
:calendar: – Thursday September 17, 2020

:desert_island: been on vacation, and picking back up the challenge

- [Day 23 (3)](#day-23-3)
  - [Picking back up](#picking-back-up)
    - [Remaining part of the challenge going on](#remaining-part-of-the-challenge-going-on)
    - [No picture?](#no-picture)
  - [Adding a share photo feature](#adding-a-share-photo-feature)

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

>4) You’ll also need to adjust your storyboard to include the detail view controller, including using Auto Layout to pin its image view correctly

:white_check_mark: 

## Adding a share photo feature

>5) You will need to use `UIActivityViewController` to share your flag.

Will need to...
- [ ] add a button to the navigation menu

Want to have :
- [ ] a large title of the country on the details page below the actual flag.