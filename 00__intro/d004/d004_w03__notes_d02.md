# Day 4, Week 3

:calendar: – Thursday April 09, 2020

*At home* :house:

- [Day 4, Week 3](#day-4-week-3)
  - [:two: While loops](#two-while-loops)
  - [:three: Repeat loops](#three-repeat-loops)
  - [:four: Exiting loops](#four-exiting-loops)
    - [:boom: Quiz correct answers](#boom-quiz-correct-answers)
  - [:five: Exiting multiple loops](#five-exiting-multiple-loops)
  - [:six: Skipping items](#six-skipping-items)
  - [:seven: Infinite loops](#seven-infinite-loops)
  - [:eight: Looping summary](#eight-looping-summary)
## :two: [While loops](https://www.hackingwithswift.com/sixty/4/2/while-loops)

>A second way of writing loops is using while: give it a condition to check, and its loop code will go around and around until the condition fails.

```swift
var number = 1

while number <= 20 {
    print(number)
    number += 1
}

print("Ready or not, here I come!")
```

## :three: [Repeat loops](https://www.hackingwithswift.com/sixty/4/3/repeat-loops)

>The third way of writing loops is **not commonly used,** but it’s so simple to learn we might as well cover it: it’s called **the repeat loop,** and it’s identical to a while loop except *the condition to check comes at the end*.

```swift
var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")
```

>Because the condition comes at the end of the repeat loop the code inside the loop will always be executed at least once, whereas while loops check their condition before their first run.

```swift
while false {
    print("This is false")
}

repeat {
    print("This is false")
} while false
```

## :four: [Exiting loops](https://www.hackingwithswift.com/sixty/4/4/exiting-loops)

>You can exit a loop at any time using the break keyword.

```swift
while countDown >= 0 {
    print(countDown)

    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }

    countDown -= 1
}
```

### :boom: Quiz correct answers 

The structure is not right

```swift
repeat while true {
	print("Fetching updates")
}
```

## :five: [Exiting multiple loops](https://www.hackingwithswift.com/sixty/4/5/exiting-multiple-loops)

>If you put a loop inside a loop it’s called a **nested loop**, and it’s not uncommon to want to break out of both the inner loop and the outer loop at the same time.

```swift
for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
    }
}
```

## :six: [Skipping items](https://www.hackingwithswift.com/sixty/4/6/skipping-items)

>As you’ve seen, the `break` keyword exits a loop. But if you just want to skip the current item and continue on to the next one, you should use `continue` instead.

```swift
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}
```

But what's the difference between `continue` and `fallthrough` then? Is `fallthrough` only about switches and cases?

## :seven: [Infinite loops](https://www.hackingwithswift.com/sixty/4/7/infinite-loops)

>It’s common to use `while` loops to make infinite loops: loops that either have no end or only end when you’re ready. 
>
>All apps on your iPhone use infinite loops, because they start running, then continually watch for events until you choose to quit them.

Avoid **infinite loops**.

>As an example, we’re going to use while true to print the music of John Cage’s piece 4’33” – if you didn’t know, it’s famous because it’s 4 minutes and 33 seconds of complete silence.
>
>We can write the “music” for this piece using while true, with a condition that exits the loop when we’ve gone around enough times:

```swift
var counter = 0

while true {
    print(" ")
    counter += 1

    if counter == 273 {
        break
    }
}
```

## :eight: [Looping summary](https://www.hackingwithswift.com/sixty/4/8/looping-summary)
