# *Day 51 • Thursday April 01, 2021*

>Today marks the start of **the second half of this course** – you’ve finished the first 50 days now, and it’s time for the second 50 days. So, today we’re going to do something a little different: _I want to give you a sense of the broader Swift ecosystem._
>
>I often write about conferences, because **I believe most people benefit from getting out there and meeting other people, hearing fresh ideas, and playing an active role in the community**.
>
>While you’re just learning it’s easy to miss just how interesting our community is, so today I would you like you to watch two talks I’ve given at conferences last year: **dotSwift** in Paris and **NSSpain** in Logroño.
>
>I’ve picked out these talks for different reasons:
>
>At this point in your learning, the dotSwift talk will be totally within your grasp, but will still inspire you to write better Swift code.
>
>The NSSpain talk will about 70% in your grasp, and about 30% new, but I think at this point you’ll appreciate some of the many pain points I talk about.
>
>**Don’t worry if there are some things you don’t fully understand yet.** When you listen to a conference talk, very often you’ll know some things already, learn a few things quickly, and have to do some extra research on others – that’s normal, and it shows that it hit the sweet spot.
>
>As I write this, I spoke to someone just yesterday who said they attended a conference in 2018 and then again in 2019, and **it was amazing for them to see how much more they understood after a year of work.** As Leonardo da Vinci said, “the noblest pleasure is the joy of understanding,” and I can think of few better yardsticks of your progress than watching talks live or recorded and realizing they are starting to make more sense than before.

Oh man the irony of jumping into this a year after having started this challenge! :joy:

>Hopefully this video day gives you a little time to catch your breath, while also giving you just a taste of what else is out there.
>
>**Today you have two videos to watch, and you’ll learn about `map()`, `flatMap()`, `filter()`, and more.**

## :one: [Elements of Functional Programming](https://www.youtube.com/watch?v=OgU8d_E1K14) 

Functional Programming – can be scary, boring difficult to apply.
* go for quick wins

Applicatives, mondads...

Any Matustack – "quick wins", ex-Apple
* get a few and then run back

There are a few informal ones

Rely very strongly on *immutability* – trying to change a constant and it won't even compile.

Void external stuff – change things only within functions

Composable, small functions that do maybe one or two things, that combine together to create bigger expressions

It clarify the intent.

Javier Soto – what you want to change rather than ho wits implemented

Values get admited and then transformed by a closure

Imperatively...

```swift
func lengthOf(strings: [String]) -> [Int] {
    var result = [Int]()
    for string in strings {
        result.append(string.count)
    }
    return result
}
```

Functionally

```swift
func lengthOf(strings: [String]) -> [Int] {
    return strings.map {$0.count}
}
```

*The function signature has not changed*
* $0 just means the element that is being passed in.

The Short code isn't whats great – its that its immutable, because it means you have to transform everything and you cannot bail out early.

**map()**
```swift
func map<T>(_ transform: (Element) -> T) -> [T] {
    var returnValue = [T]()
    for item in self {
        returnValue.append(transform(item))
    }
    return returnValue
}
```

This was exacly what was written before, but it's Apple's issue and they work on improving that.

Applications could be
* mapping a score into a strings
* moving a shape geometrically – `animate(withDuration)`

`flatMap()` • (`compactMap()`?)
* after the map is complete, it'll unwrap your optionals and throw away any `nil` for you! :yellow_heart:

These also work on Optionals, to unwrap it, check it and then send it back as an optional.

It's possible to have Optional Optionals – `Int??`

Swift is not a _"true functional language"_

## :two:  [Teaching Swift at Scale](https://vimeo.com/291590798) 

Used to do a bunch of Magazine work. Journalist :arrow_right: App development

Swift Knowledge Base, writes a lot of books

What book do I want to read?
* Where is Swift going, look at the analytics
* What are people looking at when they're learning Swift

Problems that people hit
* Systeme
  * UserDefaults
  * Timers – memory leaks
  * Energy Usage
  * **Tolerance**
  * Precision
  * Concurrency
* User Interface
  * Videos
  * Image Views
  * Web Views
  * Auto layout
* Swift
  * Strings – `StaticString`, `compactMap()

Splitting up App Targets