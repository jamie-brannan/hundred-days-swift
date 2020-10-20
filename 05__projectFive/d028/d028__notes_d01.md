# _Day 28(1) • Tuesday October 20, 2020_

>Language is complicated.
>
>One of my favorite TV comedies is called Blackadder, and featured a conversation between Dr Samuel Johnson (who had recently finished his dictionary of the English language), and Blackadder (butler to Prince George):
>
>>Samuel Johnson: “Here it is, sir. The very cornerstone of English scholarship. This book, sir, contains every word in our beloved language.”
>>
>>Blackadder: “Every single one, sir?”
>>
>>Samuel Johnson: “Every single word, sir!”
>>
>>Blackadder: “Oh, well, in that case, sir, I hope you will not object if I also offer the doctor my most enthusiastic contrafibularities.”
>>
>>Samuel Johnson: “What?”
>>
>>Blackadder: “Contrafibularities, sir? It is a common word down our way.”
>>
>>Samuel Johnson: “Damn!” [adds it to his dictionary]
>>
>>Blackadder: “Oh, I'm sorry, sir. I'm anaspeptic, phrasmotic, even compunctuous to have caused you such pericombobulation.”
>>
>We can see further evidence of how complicated language is by **looking at the way Swift handles strings**. 
>
> :arrow_right:  Have you ever wondered w_hy you can’t read individual letters from strings using integer positions?_ In code, this kind of thing isn’t built into Swift: ~~`let letter = someString[5]`~~
>
>The reason for this is that Swift uses a rather complicated – but extremely important! – system of storing its characters, known **as extended grapheme clusters**. 
>
>This means for Swift to read character 8 of a string it needs to start at 0 and count through individual letters until it reaches the 8th one; _it can’t jump straight there._
>
>As a result, Swift doesn’t let us use str[7] to read the 8th character – even though they could enable such behavior trivially, it could easily result in folks using **integer subscripting inside a loop**, which would have **terrible performance**.

Damn, so wasteful that they banned that from the outset. Reminds me of how I'd solve anything in PHP :joy:

>All this matters because today you’re going to be using `UITextChecker` to check whether a string is spelled correctly. This comes from `UIKit`, which was written in `Objective-C`, so we need to be very careful how we give it Swift strings to use.
>
>Today you have three topics to work through, and you’ll learn about using `UITextChecker` to find invalid words, inserting table view rows with animation, and more.

## :one: [Prepare for submission : `lowercased()` and `indexPath`](https://www.hackingwithswift.com/read/5/4/prepare-for-submission-lowercased-and-indexpath)


>You can breathe again: we're done with closures for now. I know that wasn't easy, but once you understand basic closures you really have come a long way in your Swift adventure.
>
>We're going to do some much easier coding now, because believe it or not we're not that far from making this game actually work!
>
>We have now gone over the structure of a closure: trailing closure syntax, unowned self, a parameter being passed in, then the need for `self`. to make capturing clear. We haven't really talked about the actual content of our closure, because there isn't a lot to it. As a reminder, here's how it looks:

```swift
guard let answer = ac?.textFields?[0].text else { return }
self?.submit(answer)
```

>The first line safely unwraps the array of text fields – it's optional because there might not be any. The second line pulls out the text from the text field and passes it to our (all-new-albeit-empty) `submit()` method.
>
>This method needs to :
>* check whether the player's word can be made from the given letters. 
>* It needs to check whether the word has been used already, because obviously we don't want duplicate words. 
>* It also needs to check whether the word is actually a valid English word, because otherwise the user can just type in nonsense.
>
>If all three of those checks pass, `submit()` needs to add the word to the `usedWords` array, then insert a new row in the table view. 
>
>We could just use the table view's r`eloadData()` method to force a full reload, but that's not very efficient when we're changing just one row.
>
>First, let’s create dummy methods for the three checks we’re going to do: is the word possible, is it original, and is it real? 
>
>Each of these will accept a word string and return true or false, but _for now we’ll just always return true_ – we’ll come back to these soon. Add these methods now:

```swift
func isPossible(word: String) -> Bool {
    return true
}

func isOriginal(word: String) -> Bool {
    return true
}

func isReal(word: String) -> Bool {
    return true
}
```

>With those three methods in place, we can write our first pass at the `submit()` method:

```swift
func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()

    if isPossible(word: lowerAnswer) {
        if isOriginal(word: lowerAnswer) {
            if isReal(word: lowerAnswer) {
                usedWords.insert(answer, at: 0)

                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
```

>_If_ a user types "cease" as a word that can be made out of our started word "agencies", it's clear that is correct because there is one "c", two "e"s, one "a" and one "s". 
>
>_But what if they type "Cease"?_ Now it has a capital C, and "agencies" doesn't have a capital C. 
>* Yes, that's right: **strings are case-sensitive**, which means Cease is not cease is not CeasE is not CeAsE.
>
>The solution to this is quite simple: all the starter words are lowercase, so when we check the player's answer we immediately lowercase it using its `lowercased()` method. This is stored in the `lowerAnswer` constant because we want to use it several times.
>
>We then have three `if` statements, one inside another. These are called **nested statements**, because you _nest one inside the other_. 
>
>**Only if all three statements are true** (the word is possible, the word hasn't been used yet, and the word is a real word), **does the main block of code execute**.
>
>**Once we know the word is good,** we do three things: insert the new word into our `usedWords` array _at index 0_. 
>* This means "add it to the start of the array," and means that the newest words will appear at the top of the table view.

"Append", or some kind of FIFO algo then?

>The next two things are related: we insert a new row into the table view. Given that the table view gets all its data from the used words array, this might seem strange. After all, _we just inserted the word into the `usedWords` array, so why do we need to insert anything into the table view?_
>
>The answer is **animation**. Like I said, we could just call the `reloadData()` method and _have the table do a full reload of all rows,_ but it means a **lot of extra work for one small change**, and also causes **a jump**– the word wasn't there, and now it is.
>
>This can be hard for users to track visually, so using `insertRows()` lets us tell the table view that a new row has been placed at a specific place in the array so that it can _animate the new cell appearing_. Adding one cell is also significantly easier than having to reload everything, as you might imagine!
>
>There are two quirks here that require a little more detail. First, `IndexPath` is something we looked at briefly in **project 1**, as it contains a section and a row for every item in your table. As with project 1 we aren't using sections here, but _the row number should equal the position we added the item in the array_ – position 0, in this case.
>
>Second, the `with` parameter lets _you specify_ _**how**_ _the row should be animated in_. Whenever you're adding and removing things from a table, the `.automatic` value means "do whatever is the standard system animation for this change." In this case, it means _"slide the new row in from the top."_

Sweeeeeet, works great! Even one after another it seems to know to just push the previous through to the next index.

>Our three checking methods always return true regardless of what word is entered, but apart from that the game is starting to come together. Press Cmd+R to play back what you have: you should be able to tap the + button and enter words into the alert.