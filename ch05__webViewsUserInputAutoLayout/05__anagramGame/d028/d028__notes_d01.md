# _Day 28(1) • Tuesday October 20, 2020_

- [_Day 28(1) • Tuesday October 20, 2020_](#day-281--tuesday-october-20-2020)
  - [:one: Prepare for submission : `lowercased()` and `indexPath`](#one-prepare-for-submission--lowercased-and-indexpath)
  - [:two: Checking for valid answers](#two-checking-for-valid-answers)
    - [`isOriginal` check](#isoriginal-check)
    - [`isPossible` check](#ispossible-check)
    - [`isReal` checker](#isreal-checker)
  - [`utf16`](#utf16)
  - [:three:  Or else what?](#three--or-else-what)

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

## :two: [Checking for valid answers](https://www.hackingwithswift.com/read/5/5/checking-for-valid-answers)

>As you’ve seen, the `return` keyword exits a method at any time it's used. If you use `return` by itself, _it exits the method and does nothing else_. 
>
>But if you use `return` with a value, it sends that value back to whatever called the method. 
>
>We’ve used it previously to send back the number of rows in a table, for example.

Yup and I've used it countless times at work before.

### `isOriginal` check

>Before you can send a value back, you need to tell Swift that you expect to return a value. Swift will automatically check that a value is returned and it's of the right data type, so this is important. We just put in stubs (empty methods that do nothing) for three new methods, each of which returns a value. Let's take a look at one in more detail:

```swift
func isOriginal(word: String) -> Bool {
    return true
}
```

>The method is called `isOriginal()`, and it takes one parameter that's a string. But before the opening brace there's something important: `-> Bool`. This tells Swift that the method will return a boolean value, which is the name for a value that can be either true or false.
>
>The body of the method has just one line of code: `return true`. This is how the return statement is used to send a value back to its caller: we're returning true from this method, _so the caller can use this method inside an if statement to check for true or false._
>
>This method can have as much code as it needs in order to evaluate fully whether the word has been used or not, including calling any other methods it needs. We're going to change it so that it calls another method, which will check whether our `usedWords` array already contains the word that was provided. 
>
>Replace its current return true code with this:

```swift
return !usedWords.contains(word)
```

>There are two new things here. First, `contains()` is a method that checks whether the array it’s called on (`usedWords`) contains the value specified in parameter 2 (`word`). If it does contain the value, `contains() `returns true; if not, it returns false. Second, the `!` symbol. You've seen this before as the way to _force unwrap optional variables_, but here it's something different: **it means not**.

Yup, it's a ____ operator – I can't remember the word though!

>The difference is small but important: 
>* when used **before** a variable or constant, `!` means _"not" or "opposite"_. So if `contains()` returns true, `!` flips it around to make it false, and vice versa. 
>* When used **after** a variable or constant, `!` means "force unwrap this optional variable."
>
>This is used because our method is called `isOriginal()`, and should return true if the word has never been used before. If we had used `return usedWords.contains(word)`, then it would do the opposite: it would return true if the word had been used and false otherwise. So, by using `!` we're flipping it around so that the method returns true if the word is new.

:white_check_mark: Yup yup

### `isPossible` check

>That's one method down. Next is the `isPossible()`, which also takes a string as its only parameter and returns a `Bool` – true or false. This one is more complicated, but I've tried to make the algorithm as simple as possible.
>
>How can we be sure that "cease" can be made from "agencies", using each letter only once? **The solution I've adopted is** to loop through every letter in the player's answer, seeing whether it exists in the _eight-letter start word_ we are playing with. 
>* If it does exist, we remove the letter from the start word, then continue the loop. 
>* So, if we try to use a letter twice, it will exist the first time, but then get removed so it doesn't exist the next time, and the check will fail.
>
>In **project 4** we used the `contains()` method to see if one string exists inside another. Here we need something more precise: _if it exists, where?_ 
>
>_That extra information allows us to remove the character from our word so that it won’t be used twice._ Swift has a separate method for this called `firstIndex(of:)`, which will return _the first position_ of the **substring** if it exists or nil otherwise.
>
>To put that into practice, here’s the `isPossible()` method:

```swift
func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else { return false }

    for letter in word {
        if let position = tempWord.firstIndex(of: letter) {
            tempWord.remove(at: position)
        } else {
            return false
        }
    }

    return true
}
```

>If the letter was found in the string, we use `remove(at:)` to remove the used letter from the `tempWord` variable. This is why we need the `tempWord` variable at all: because we'll be removing letters from it so we can check again the next time the loop goes around.
>
>The method ends with `return true`, b**ecause this line is reached only if every letter in the user's word was found in the start word no more than once**. 
>* If any letter isn't found, or is used more than possible, one of the `return false` lines would have been hit, so by this point we're sure the word is good.
>
>**Important**: we have told Swift that we are returning a boolean value from this method, and it will check every possible outcome of the code to _make sure a boolean value is returned no matter what_.
>
>Time for the final method. Replace the current i`sReal()` method with this:

### `isReal` checker

```swift
func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
}
```

>There's a new class here, called `UITextChecker`. This is an iOS class that is designed to **spot spelling errors**, which makes it perfect for knowing if a given word is real or not. We're creating a new instance of the class and putting it into the checker constant for later.

Wwwwhaaaat! iOS Spell check built in? Hell yeahhhh
* does this work for other languages / based on provisioning profiles I guess?

>There's a new type here too, called `NSRange`. This is used to store **a string range**, which is a value that holds a start position and a length. We want to examine the whole string, so we use `0` for the start position and _the string's length for the_ `length`.

Is this the way of making letters indexed like in PHP it would?

>Next, we call the `rangeOfMisspelledWord(in:)` method of our `UITextChecker` instance. This wants five parameters, but we only care about _the first two and the last one_: 
>1) the first parameter is our string, `word`, 
>2) the second is our range to **scan (the whole string)**, 
>3) and the last is the **language we should be checking with**, where `en` selects English.
>
>_Parameters three and four aren't useful here_, but for the sake of completeness: 
>* parameter three selects a point in the range where the text checker should start scanning, 
>* and parameter four lets us set whether the `UITextChecker` should start at the beginning of the range if no misspelled words were found starting from parameter three. 
>
>Neat, but not helpful here.

Great to know! Something new :sparkles:

>Calling `rangeOfMisspelledWord(in:)` returns another `NSRange` structure, which **tells us where the misspelling was found**. 
>
> :arrow_right:  But what we care about was **whether any misspelling was found**, and **if nothing was found** our `NSRange` will have the special location `NSNotFound`. 
> 
> Usually location would tell you where the misspelling started, but `NSNotFound` is telling us the word is spelled correctly – i.e., it's a valid word.
>
> :pencil: Note: In case you were curious, `NSRange` pre-dates Swift, and therefore doesn’t have access to optionals – `NSNotFound` is effectively a magic number that means “not found”, assigned to a constant to make it easier to use.
>
>Here the return statement is used in a new way: as part of an operation involving `==`. 
>
>This is a very common way to code, and what happens is that **`==` returns true or false depending on** _whether `misspelledRange.location` is equal to `NSNotFound`._ That true or false is then given to return as the return value for the method.
>
>We could have written that same line across multiple lines, but it's not common:

```swift
if misspelledRange.location == NSNotFound {
    return true
} else {
    return false
}
```

But what does a "misspelled range" even mean?

>That completes the third of our missing methods, so the project is almost complete. Run it now and give it a thorough test!

:tada:

## `utf16`

>Before we continue, there’s one small thing I want to touch on briefly. In the `isPossible()` method we looped over each letter by treating the word as an array, but in this new code we use `word.utf16` instead. Why?
>
>The answer is an annoying _backwards compatibility quirk_: Swift’s strings natively **store international characters as individual characters**, e.g. the letter “é” is stored as precisely that. However, `UIKit` was written in Objective-C before Swift’s strings came along, and it uses a different character system called UTF-16 – short for _16-bit Unicode Transformation Format_ – **where the accent and the letter are stored separately**.

Know this well because it's just what the American Apple keyboard does when handling accents

>It’s a subtle difference, and often it isn’t a difference at all, but it’s _becoming increasingly problematic_ because of the rise of **emoji** – those little images that are frequently used in messages. 
>
>Emoji are actually just _special character combinations behind the scenes_, and they are measured differently with Swift strings and UTF-16 strings: 
>* Swift strings count them as 1-letter strings, 
>* :arrow_right: but UTF-16 considers them to be 2-letter strings. This means if you use `count` with `UIKit` methods, you run the risk of miscounting the string length.
>
>I realize this seems like pointless additional complexity, so let me try to give you a simple rule: when you’re working with `UIKit`, `SpriteKit`, or any other Apple framework, use `utf16.count` for the character count. 

:star: `utf16.count` is the rule of thumb, got it :+1:

>If it’s just your own code - i.e. looping over characters and processing each one individually – then use count instead.

## :three:  [Or else what?](https://www.hackingwithswift.com/read/5/6/or-else-what) 

>There remains one problem to fix with our code, and it's quite a tedious problem. If the word is possible and original and real, we add it to the list of found words then insert it into the table view. **But what if the word isn't possible?** **Or if it's possible but not original?** In this case, we reject the word and don't say why, so the _user gets no feedback_.

So user messages just with the else of the ifs

>So, the final part of our project is to give users feedback when they make an invalid move. This is tedious because it's just adding `else` statements to all the `if` statements in `submit()`, each time configuring a message to show to users.

Or you could probably create cases right?

>Here's the adjusted method:

```swift
func submit(answer: String) {
    let lowerAnswer = answer.lowercased()

    let errorTitle: String
    let errorMessage: String

    if isPossible(word: lowerAnswer) {
        if isOriginal(word: lowerAnswer) {
            if isReal(word: lowerAnswer) {
                usedWords.insert(answer, at: 0)

                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)

                return
            } else {
                errorTitle = "Word not recognised"
                errorMessage = "You can't just make them up, you know!"
            }
        } else {
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
        }
    } else {
        guard let title = title?.lowercased() else { return }
        errorTitle = "Word not possible"
        errorMessage = "You can't spell that word from \(title)"
    }

    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```

>As you can see, every `if` statement now has a matching `else` statement so that the user gets appropriate feedback. All the elses are effectively the same (albeit with changing text): set the values for `errorTitle` and `errorMessage` to something useful for the user. The only interesting exception is the last one, where we use string interpolation to show the view controller's title as a lowercase string.
>
>If the user enters a valid answer, a call to `return` forces Swift to exit the method immediately once the table has been updated. This is helpful, because at the end of the method there is code to create a new `UIAlertController` with the error title and message that was set, add an OK button without a handler (i.e., just dismiss the alert), then show the alert. So, this error will only be shown if something went wrong.
>
>This demonstrates one important tip about Swift constants: both `errorTitle` and `errorMessage` were declared as constants, which means their value cannot be changed once set. I didn't give either of them an initial value, and that's OK – Swift lets you do this as long as you do provide a value before the constants are read, and also as long as you don't try to change the value again later on.
>
>Other than that, your project is done. Go and play!

:tada: