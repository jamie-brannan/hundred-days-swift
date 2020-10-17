# *Day 27 (2) • Saturday October 17, 2020*

*Continued*

## :two:  [Setting up](https://www.hackingwithswift.com/read/5/1/setting-up) 

>Projects 1 to 4 were all fairly easy, because my goal was to teach you the basics of iOS development while also trying to make something useful. But now that you're hopefully starting to become familiar with the core tools we have, it's time to change up a gear and tackle something a bit harder.

Great. I do feel I have a grasp of basics.

So what could *core tools* mean or include really? How linked to just learning programming period?

>In this project you're going to learn how to make **a word game that deals with anagrams**, but as per usual I'll be hijacking it as a method to teach you more about iOS development. 
>This time around we're going back to the table views as seen in project 1, but you're also going to learn how to 
>1) *load text from files*, 
>2) how to ask for user input in `UIAlertController`, 
>3) and get a little more insight to how closures work.

Cool :sunglasses:

>In Xcode, create a new Single View App called **Project5**. We’re going to turn this into a table view controller, just like we did in project 1. So, open `ViewController.swift` and find this line:

```swift
class ViewController: UIViewController {
```

>Please change it to read this instead:

```swift
class ViewController: UITableViewController {
```

>If you remember, that only changes the definition of our view controller in code. We need to change in the storyboard too, so open Main.storyboard now.

:white_check_mark: 

>Inside Interface Builder, use the document outline to select and delete the existing view controller so that the document is blank, then replace it with a new table view controller. Use the identity inspector to change the class of the new controller to be “ViewController”, then select its prototype cell and give it the re-use identifier “Word” and the cell style Basic.
>
>**All this was covered in project 1, but it’s OK if you forgot – don’t be afraid to go back to project 1 and re-read any bits you’re not sure about.**
>
>Now select the view controller again (use the document outline – it’s easier!) then make sure the “Is Initial View Controller” box is checked under the attributes inspector. Finally, go to the Editor menu and choose Embed In > Navigation Controller. We won’t be pushing anything onto the navigation controller stack like we did with project 1, but it does automatically provide the navigation bar at the top, which we will be using.
>
>Note: This app asks users to make anagrams out of a word, e.g. when given the word “anagrams” they might provide “rags”. If you look at that and think “that’s not an anagram – it doesn’t use all the letters!” then you need to search the internet for “well actually” and have a good, long think about life.

## :three:  [Reading from disk contents of file](https://www.hackingwithswift.com/read/5/2/reading-from-disk-contentsoffile) 

>We're going to make an anagram game, where the user is asked to make words out of a larger word. We're going to put together a list of possible starter words for the game, and that list will be stored in a separate file. But how do we get the text from the file into the app? Well, it turns out that Swift's String data type makes it a cinch – thanks, Apple!
>
>If you haven't already downloaded the assets for this project from GitHub (https://github.com/twostraws/HackingWithSwift), please do so now. In the project5-files folder you'll find the file `start.txt` – please drag that into your Xcode project, making sure that "Copy items if needed" is checked.
>
>The `start.txt` file contains over 12,000 eight-letter words we can use for our game, all stored one word per line. We need to turn that into an array of words we can play with. Behind the scenes, those line breaks are marked with a special line break character that is usually expressed as `\n`. So, we need to load that word list into a string, then split it into an array by breaking up wherever we see `\n`.

This is like the seperator you put in i think with `$ cut` option or something

:question: *What / when did I use this in linux for sorting text files?*

>First, go to the start of your class and make two new arrays. We’re going to use the first one to hold all the words in the input file, and the second one will hold all the words the player has currently used in the game.
>
>So, open `ViewController.swift` and add these two properties:

```swift
var allWords = [String]()
var usedWords = [String]()
```

>Second, loading our array. This is done in three parts: finding the path to our start.txt file, loading the contents of that file, then splitting it into an array.
>
>Finding a path to a file is something you'll do a lot, because even though you know the file is called "start.txt" you don't know where it might be on the filesystem. So, we use a built-in method of Bundle to find it: `path(forResource:)`. This takes as its parameters the name of the file and its path extension, and returns a String? – i.e., you either get the path back or you get nil if it didn’t exist.
>
>Loading a file into a string is also something you'll need to get familiar with, and again there's an easy way to do it: when you create a String instance, you can ask it to create itself from the contents of a file at a particular path.
>
>Finally, we need to split our single string into an array of strings based on wherever we find a line break (`\n`). This is as simple as another method call on `String: components(separatedBy:)`. Tell it what string you want to use as a separator (for us, that's `\n`), and you'll get back an array.
>
>Before we get onto the code, there are two things you should know: `path(forResource:)` and creating a String from the contents of a file both return String?, which means we need to check and unwrap the optional using if let syntax.
>
>OK, time for some code. Put this into viewDidLoad(), after the super call: