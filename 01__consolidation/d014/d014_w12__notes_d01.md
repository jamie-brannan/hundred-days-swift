# Day 14, Week 12
:calendar: – Thursday June 04, 2020

**Consolidation : Day 2**

## :one:  [Functions](https://www.hackingwithswift.com/read/0/11/functions) 

>Functions let you define re-usable pieces of code that perform specific pieces of functionality. Usually functions are able to receive some values to modify the way they work, but it's not required.
>
>Let's start with a simple function:

```swift
func favoriteAlbum() {
    print("My favorite is Fearless")
}
```

>If you put that code into your playground, nothing will be printed. And yes, it is correct. The reason nothing is printed is that we've placed the "My favorite is Fearless" message into a function called `favoriteAlbum()`, and that code won't be called until we ask Swift to run the `favoriteAlbum()` function. To do that, add this line of code:

```swift
favoriteAlbum()
```

>That runs the function (or "calls" it), so now you'll see "My favorite is Fearless" printed out.
>
>As you can see, you define a function by writing `func`, then your function name, then open and close parentheses, then a block of code marked by open and close braces. You then call that function by writing its name followed by an open and close parentheses.
>
>Of course, that's a silly example – that function does the same thing no matter what, so there's no point in it existing. But what if we wanted to print a different album each time? In that case, we could tell Swift we want our function to accept a value when it's called, then use that value inside it.
>
>Let's do that now:

```swift
func favoriteAlbum(name: String) {
    print("My favorite is \(name)")
}
```

>That tells Swift we want the function to accept one value (called a "parameter"), named "name", that should be a string. We then use string interpolation to write that favorite album name directly into our output message. To call the function now, you’d write this:

```swift
favoriteAlbum(name: "Fearless")
```

>You might still be wondering what the point is, given that it's still just one line of code. Well, imagine we used that function in 20 different places around a big app, then your head designer comes along and tells you to change the message to "I love Fearless so much – it's my favorite!" Do you really want to find and change all 20 instances in your code? Probably not. With a function you change it once, and everything updates.
>
>You can make your functions accept as many parameters as you want, so let's make it accept a name and a year:

```swift
func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

printAlbumRelease(name: "Fearless", year: 2008)
printAlbumRelease(name: "Speak Now", year: 2010)
printAlbumRelease(name: "Red", year: 2012)
```

>These function parameter names are important, and actually form part of the function itself. Sometimes you’ll see several functions with the same name, e.g. `handle()`, but with different parameter names to distinguish the different actions.

### External and intenral parameter names

>Sometimes you want parameters to be named one way when a function is called, but another way inside the function itself. This means that when you call a function it uses almost natural English, but inside the function the parameters have sensible names. This technique is employed very frequently in Swift, so it’s worth understanding now.
>
>To demonstrate this, let’s write a function that prints the number of letters in a string. This is available using the count property of strings, so we could write this:

```swift
func countLettersInString(string: String) {
    print("The string \(string) has \(string.count) letters.")
}
```

>With that function in place, we could call it like this:

```swift
countLettersInString(string: "Hello")
```

>While that certainly works, it’s a bit wordy. Plus it’s not the kind of thing you would say aloud: “count letters in string string hello”.
>
>Swift’s solution is to let you specify one name for the parameter when it’s being called, and another inside the method. To use this, just write the parameter name twice – once for external, one for internal.
>
>For example, we could name the parameter myString when it’s being called, and str inside the method, like this:

```swift
func countLettersInString(myString str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString(myString: "Hello")  
```

>You can also specify an underscore, _, as the external parameter name, which tells Swift that it shouldn’t have any external name at all. For example:

```swift
func countLettersInString(_ str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString("Hello")
```

>As you can see, that makes the line of code read like an English sentence: “count letters in string hello”.
>
>While there are many cases when using _ is the right choice, Swift programmers generally prefer to name all their parameters. And think about it: why do we need the word “String” in the function – what else would we want to count letters on?
>
>So, what you’ll commonly see is external parameter names like “in”, “for”, and “with”, and more meaningful internal names. So, the “Swifty” way of writing this function is like so:

```swift
func countLetters(in string: String) {
    print("The string \(string) has \(string.count) letters.")
}
```

That means you call the function with the parameter name “in”, which would be meaningless inside the function. However, inside the function the same parameter is called “string”, which is more useful. So, the function can be called like this:

```swift
countLetters(in: "Hello")
```

>And that is truly Swifty code: “count letters in hello” *reads like natural English*, but the code is also clear and concise.

Human readability and swift

### Return values

>Swift functions can return a value by writing -> then a data type after their parameter list. Once you do this, Swift will ensure that your function will return a value no matter what, so again this is you making a promise about what your code does.
>
>As an example, let's write a function that returns true if an album is one of Taylor Swift's, or false otherwise. This needs to accept one parameter (the name of the album to check) and will return a Boolean. Here's the code:

```swift
func albumIsTaylor(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    if name == "Fearless" { return true }
    if name == "Speak Now" { return true }
    if name == "Red" { return true }
    if name == "1989" { return true }

    return false
}
```

>If you wanted to try your new `switch/case` knowledge, this function is a place where it would work well.
>
>You can now call that by passing the album name in and acting on the result:

```swift
if albumIsTaylor(name: "Red") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}

if albumIsTaylor(name: "Blue") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}
```

## :two:  [Optionals](https://www.hackingwithswift.com/read/0/12/optionals) 

>Swift is a very safe language, by which I mean it works hard to ensure your code never fails in surprising ways.
>
>**One of the most common** ways that code fails is when it **tries to use data that is bad or missing**. 
>
>For example, imagine a function like this:

```swift
func getHaterStatus() -> String {
    return "Hate"
}
```

>That function doesn't accept any parameters, and it returns a string: "Hate". But what if today is a particularly sunny day, and those haters don't feel like hating – what then? Well, maybe we want to return nothing: this hater is doing no hating today.
>
>Now, when it comes to a string you might think an *empty string* is a great way to communicate nothing, and that might be true sometimes. 
>* But how about numbers – is 0 an "empty number"? Or -1?
>
>Before you start trying to create imaginary rules for yourself, Swift has a solution: *optionals*. An optional value is one that might have a value or might not. 

**optional** : *(swift)* a value that might have a value *or* might not

>* Most people find optionals hard to understand, and that’s OK – I’m going to try explaining it in several ways, so hopefully one will work.
>
>For now, imagine a survey where you ask someone, “On a scale of 1 to 5 how awesome is Taylor Swift?” 
>* – what would someone answer if they had never heard of her? 
>
>1 would be unfairly slating her, and 5 would be praising her when they had no idea who Taylor Swift was. The solution is optionals: *“I don’t want to provide a number at all.”*

It is a "no comment" multiple choice response

>When we used `-> String` it means "this will definitely return a string," which means this function cannot return no value, and thus can be called safe in the knowledge that you'll always get a value back that you can use as a string. If we wanted to tell Swift that this function might return a value or it might not, we need to use this instead:

```swift
func getHaterStatus() -> String? {
    return "Hate"
}
```

>Note the extra question mark: `String?` means “optional string.” Now, in our case we're still returning “Hate” no matter what, but let's go ahead and modify that function further: if the weather is sunny, the haters have turned over a new leaf and have given up their life of hating, so we want to return no value. In Swift, this "no value" has a special name: `nil`.
>
>Change the function to this:

```swift
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}
```

>That accepts one string parameter (the weather) and returns one string (hating status), but that return value might be there or it might not – it's nil. In this case, it means we might get a string, or we might get nil.
>
>Now for the important stuff: Swift wants your code to be really safe, and trying to use a nil value is a bad idea. It might crash your code, it might screw up your app logic, or it might make your user interface show the wrong thing. As a result, when you declare a value as being optional, Swift will make sure you handle it safely.
>
>Let's try this now: add these lines of code to your playground:

```swift
var status: String
status = getHaterStatus(weather: "rainy")
```

>The first line creates a string variable, and the second assigns to it the value from `getHaterStatus()` – and today the weather is rainy, so those haters are hating for sure.
>
>That code will not run, because we said that `status` is of *type String*, which requires a value, but `getHaterStatus()` might not provide one because it returns an optional string. 
>
>That is, we said there would definitely be a string in status, but getHaterStatus() *might return nothing at all*. 
* Swift simply will not let you make this mistake, which is extremely helpful because it effectively **stops dead a whole class of common bugs**.
>
>To fix the problem, we need to make the `status` variable a `String?`, or just remove the type annotation entirely and let Swift use type inference. 
>
>The first option looks like this:

```swift
var status: String?
status = getHaterStatus(weather: "rainy")
```

>And the second like this:

```swift
var status = getHaterStatus(weather: "rainy")
```

>Regardless of which you choose, that value might be there or might not, and by default Swift won't let you use it dangerously. As an example, imagine a function like this:

```swift
func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}
```

>That takes a string and prints a message depending on its contents. This function takes a String value, and not a String? value – you can't pass in an optional here, it wants a real string, which means we can't call it using the status variable.
>
>Swift has two solutions. Both are used, but one is definitely preferred over the other. The first solution is called optional unwrapping, and it's done inside a conditional statement using special syntax. It does two things at the same time: checks whether an optional has a value, and if so unwraps it into a non-optional type then runs a code block.
>
>The syntax looks like this:

```swift
if let unwrappedStatus = status {
    // unwrappedStatus contains a non-optional value!
} else {
    // in case you want an else block, here you go…
}
```

>These if let statements check and unwrap in one succinct line of code, which makes them very common. Using this method, we can safely unwrap the return value of `getHaterStatus()` and be sure that we only call `takeHaterAction()` with a valid, non-optional string. Here's the complete code:

```swift
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

if let haterStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: haterStatus)
}
```

>**If you understand this concept, you're welcome to skip down to the title that says "Force unwrapping optionals".** If you're still not quite sure about optionals, carry on reading.
>
>OK, if you're still here it means the explanation above either made no sense, or you sort of understood but could probably use some clarification. Optionals are used extensively in Swift, so you really do need to understand them. I'm going to try explaining again, in a different way, and hopefully that will help!
>
>Here's a new function:

```swift
func yearAlbumReleased(name: String) -> Int {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return 0
}
```

>That takes the name of a Taylor Swift album, and returns the year it was released. But if we call it with the album name "Lantern" because we mixed up Taylor Swift with Hudson Mohawke (an easy mistake to make, right?) then it returns 0 because it's not one of Taylor's albums.
>
>But does 0 make sense here? Sure, if the album was released back in 0 AD when Caesar Augustus was emperor of Rome, 0 might make sense, but here it's just confusing – people need to know ahead of time that 0 means "not recognized."
>
>A much better idea is to re-write that function so that it either returns an integer (when a year was found) or nil (when nothing was found), which is easy thanks to optionals. Here's the new function:

```swift
func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return nil
}
```

Now that it returns nil, we need to unwrap the result using `if let` because we need to check whether a value exists or not.

**If you understand the concept now, you're welcome to skip down to the title that says “Force unwrapping optionals”.** If you're still not quite sure about optionals, carry on reading.

OK, if you're still here it means you're really struggling with optionals, so I'm going to have one last go at explaining them.

Here's an array of names:

```swift
var items = ["James", "John", "Sally"]
```

>If we wanted to write a function that looked in that array and told us the index of a particular name, we might write something like this:

```swift
func position(of string: String, in array: [String]) -> Int {
    for i in 0 ..< array.count {
        if array[i] == string {
            return i
        }
    }

    return 0
}
```

>That loops through all the items in the array, returning its position if it finds a match, otherwise returning 0.
>
>Now try running these four lines of code:

```swift
let jamesPosition = position(of: "James", in: items)
let johnPosition = position(of: "John", in: items)
let sallyPosition = position(of: "Sally", in: items)
let bobPosition = position(of: "Bob", in: items)
```

>That will output 0, 1, 2, 0 – the positions of James and Bob are the same, even though one exists and one doesn't. This is because I used 0 to mean "not found." The easy fix might be to make -1 not found, but whether it's 0 or -1 you still have a problem because you have to remember that specific number means "not found."
>
>The solution is optionals: return an integer if you found the match, or nil otherwise. In fact, this is exactly the approach the built-in "find in array" methods use: someArray.firstIndex(of: someValue).
>
>When you work with these "might be there, might not be" values, Swift forces you to unwrap them before using them, thus acknowledging that there might not be a value. That's what if let syntax does: if the optional has a value then unwrap it and use it, otherwise don't use it at all. You can’t use a possibly-empty value by accident, because Swift won’t let you.
>
>If you're still not sure how optionals work, then the best thing to do is ask me on Twitter and I'll try to help: you can find me @twostraws.

### Force unwrapping optionals

>Swift lets you override its safety by using the exclamation mark character: `!`. If you know that an optional definitely has a value, you can force unwrap it by placing this exclamation mark after it.
>
>Please be careful, though: if you try this on a variable that does not have a value, your code will crash.
>
>To put together a working example, here's some foundation code:

```swift
func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return nil
}

var year = yearAlbumReleased(name: "Red")

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year)")
}
```

>That gets the year an album was released. If the album couldn't be found, year will be set to nil, and an error message will be printed. Otherwise, the year will be printed.
>
>Or will it? Well, yearAlbumReleased() returns an optional integer, and this code doesn't use if let to unwrap that optional. As a result, it will print out the following: "It was released in Optional(2012)" – probably not what we wanted!
>
>At this point in the code, we have already checked that we have a valid value, so it's a bit pointless to have another if let in there to safely unwrap the optional. So, Swift provides a solution – change the second print() call to this:

```swift
print("It was released in \(year!)")
```

>Note the exclamation mark: it means "I'm certain this contains a value, so force unwrap it now."

### Implicitly unwrapped optionals

>You can also use this exclamation mark syntax to create implicitly unwrapped optionals, which is where some people really start to get confused. So, please read this carefully!
>
>* A regular variable must contain a value. *Example*: String must contain a string, even if that string is empty, i.e. "". It cannot be nil.
>* An optional variable might contain a value, or might not. It must be unwrapped before it is used. *Example*: String? might contain a string, or it might contain nil. The only way to find out is to unwrap it.
>* An implicitly unwrapped optional might contain a value, or might not. But it does not need to be unwrapped before it is used. Swift won't check for you, so you need to be extra careful. *Example*: String! might contain a string, or it might contain nil – and it's down to you to use it appropriately. It’s like a regular optional, but Swift lets you access the value directly without the unwrapping safety. If you try to do it, it means you know there’s a value there – but if you’re wrong your app will crash.
>
>The main times you're going to meet implicitly unwrapped optionals is when you're working with user interface elements in UIKit on iOS or AppKit on macOS. These need to be declared up front, but you can't use them until they have been created – and Apple likes to create user interface elements at the last possible moment to avoid any unnecessary work. Having to continually unwrap values you definitely know will be there is annoying, so these are made implicitly unwrapped.
>   
>Don't worry if you find implicitly unwrapped optionals a bit hard to grasp - it will become clear as you work with the language.

## :three:  [Optional chaining](https://www.hackingwithswift.com/read/0/13/optional-chaining) 

>Working with optionals can feel a bit clumsy sometimes, and all the unwrapping and checking can become so onerous that you might be tempted to throw some exclamation marks to force unwrap stuff so you can get on with work. Be careful, though: if you force unwrap an optional that doesn't have a value, your code will crash.
>
>Swift has two techniques to help make your code less complicated. The first is called optional chaining, which lets you run code only if your optional has a value. Put the below code into your playground to get us started:

```swift
func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    default: return nil
    }
}

let album = albumReleased(year: 2006)
print("The album is \(album)")
```

>That will output "The album is Optional("Taylor Swift")" into the results pane.
>
>If we wanted to convert the return value of albumReleased() to be uppercase letters (that is, "TAYLOR SWIFT" rather than "Taylor Swift") we could call the uppercased() method of that string. For example:

```swift
let str = "Hello world"
print(str.uppercased())
```

>The problem is, albumReleased() returns an optional string: it might return a string or it might return nothing at all. So, what we really mean is, "if we got a string back make it uppercase, otherwise do nothing." And that's where optional chaining comes in, because it provides exactly that behavior.
>
>Try changing the last two lines of code to this:

```swift
let album = albumReleased(year: 2006)?.uppercased()
print("The album is \(album)")
```

>Note that there's a question mark in there, which is the optional chaining: everything after the question mark will only be run if everything before the question mark has a value. This doesn't affect the underlying data type of album, because that line of code will now either return nil or will return the uppercase album name – it's still an optional string.
>
>Your optional chains can be as long as you need, for example:

```swift
let album = albumReleased(year: 2006)?.someOptionalValue?.someOtherOptionalValue?.whatever
```

>Swift will check them from left to right until it finds nil, at which point it stops.

### The nil coalescing operator

>This simple Swift feature makes your code much simpler and safer, and yet has such a grandiose name that many people are scared of it. This is a shame, because the nil coalescing operator will make your life easier if you take the time to figure it out!
>
>What it does is let you say "use value A if you can, but if value A is nil then use value B." That's it. It's particularly helpful with optionals, because it effectively stops them from being optional because you provide a non-optional value B. So, if A is optional and has a value, it gets used (we have a value.) If A is present and has no value, B gets used (so we still have a value). Either way, we definitely have a value.
>
>To give you a real context, try using this code in your playground:

```swift
let album = albumReleased(year: 2006) ?? "unknown"
print("The album is \(album)")
```

>That double question mark is the **nil coalescing operator**, and in this situation it means "if `albumReleased() `returned a value then put it into the `album` variable, but if `albumReleased()` returned nil then use 'unknown' instead."

Is this not called a Turner expression?

>If you look in the results pane now, you'll see "The album is Taylor Swift" printed in there – no more optionals. This is because Swift can now be sure it will get a real value back, either because the function returned one or because you're providing "unknown". This in turn means you don't need to unwrap anything or risk crashes – you're guaranteed to have real data to work with, which makes your code safer and easier to work with.

## :four:  [Enumerations](https://www.hackingwithswift.com/read/0/14/enumerations) 

>Enumerations – usually just called "enum" and pronounced "ee-num" - are a way for you to define your own kind of value in Swift. In some programming languages they are simple little things, but Swift adds a huge amount of power to them if you want to go beyond the basics.
>
>Let's start with a simple example from earlier:

```swift
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}
```

>That function accepts a string that defines the current weather. The problem is, a string is a poor choice for that kind of data – is it "rain", "rainy" or "raining"? Or perhaps "showering", "drizzly" or "stormy"? Worse, what if one person writes "Rain" with an uppercase R and someone else writes "Ran" because they weren't looking at what they typed?
>
>Enums solve this problem by letting you define a new data type, then define the possible values it can hold. For example, we might say there are five kinds of weather: sun, cloud, rain, wind and snow. If we make this an enum, it means Swift will accept only those five values – anything else will trigger an error. And behind the scenes enums are usually just simple numbers, which are a lot faster than strings for computers to work with.
>
>Let's put that into code:

```swift
enum WeatherType {
    case sun, cloud, rain, wind, snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    if weather == WeatherType.sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus(weather: WeatherType.cloud)
```

>Take a look at the first three lines: line 1 gives our type a name, WeatherType. This is what you'll use in place of String or Int in your code. Line 2 defines the five possible cases our enum can be, as I already outlined. Convention has these start with a lowercase letter, so “sun”, “cloud”, etc. And line 3 is just a closing brace, ending the enum.
>
>Now take a look at how it's used: I modified the getHaterStatus() so that it takes a WeatherType value. The conditional statement is also rewritten to compare against WeatherType.sun, which is our value. Remember, this check is just a number behind the scenes, which is lightning fast.
>
>Now, go back and read that code again, because I'm about to rewrite it with two changes that are important. All set?