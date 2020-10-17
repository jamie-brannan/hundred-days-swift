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