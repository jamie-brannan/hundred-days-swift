*Day 40 • Tuesday January 12, 2021*

>There’s an old joke about multitasking:
>
>>A programmer has a problem and thinks, “I can fix this using multitasking!”
>>
>>have Now problems! two they
>
>(Hey, I said it was old, I didn’t say it was funny!)
>
>The point is that when you start running multiple pieces of code at the same time, they can complete in any order – the “now they have two problems!” punchline got mashed up.
>
>In fact, race conditions are a whole category of bugs caused by one task completing before it was supposed to – they are particularly nasty to fix because sometimes work completes in the correct order and everything works great, which is why we call it a race.
>
>Yesterday was a gentle introduction to multi-tasking using Grand Central Dispatch, but we’ll be coming back to it more in the future. In the meantime, make sure you test what you’ve learned so you can be sure it’s all sunk in.
>
>**Today you should work through the wrap up chapter for project 9, complete its review, then work through all three of its challenges.**

## :one:  [Wrap up](https://www.hackingwithswift.com/read/9/6/wrap-up) 

>Although I've tried to simplify things as much as possible, GCD still isn't easy. That said, it's much easier than the alternatives: GCD automatically handles thread creation and management, automatically balances based on available system resources, and automatically factors in Quality of Service to ensure your code runs as efficiently as possible. The alternative is doing all that yourself!
>
>There's a lot more we could cover (not least how to create your own queues!) but really you have more than enough to be going on with, and certainly more than enough to complete the rest of this series. We'll be using GCD again, so it might help to keep this reference close to hand!

### Review what you learned

>Anyone can sit through a tutorial, but it takes actual work to remember what was taught. It’s my job to make sure you take as much from these tutorials as possible, so I’ve prepared a short review to help you check your learning.

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
> 1. Modify project 1 so that loading the list of NSSL images from our bundle happens in the background. Make sure you call `reloadData()` on the table view once loading has finished!

loading of NSSL images

```swift
    DispatchQueue.global(qos: .userInitiated).async {
      let fm = FileManager.default
      let path = Bundle.main.resourcePath!
      let items = try! fm.contentsOfDirectory(atPath: path)

      for item in items {
        if item.hasPrefix("nssl") {
          self.pictures.append(item)
        }
      }
    }
```

:question: *Where would I have a table reload in this project?*
* https://github.com/twostraws/100
* ... don't really see stuff

> 2. Modify project 8 so that loading and parsing a level takes place in the background. Once you’re done, make sure you update the UI on the main thread!

if loading and parsing is in the background, it must go on... `userInterface`

> 3. Modify project 7 so that your filtering code takes place in the background. This filtering code was added in one of the challenges for the project, so hopefully you didn’t skip it!

## :two:  [Project 9: Grand central dispatch](https://www.hackingwithswift.com/review/hws/project-9-grand-central-dispatch) 

### :boom: Quiz insights

* Multitasking refers to a computer running many pieces of code at the same time.
  * The codes runs in parallel, so any of the tasks can complete at any time.
* Background tasks prioritize battery efficiency.
  * Background priority is there for tasks that take a very long time to complete, so the system doesn't allocate them much CPU resource.
* The default GCD background queue has a lower priority than `.userInitiated` but higher than `.utility`.
  * It has a higher priority than `.utility` and lower than `.userInitiated`.
* All user interface code should be run on the main thread.
  * The main thread is the only place it can safely be run.
* GCD will automatically adapt the number of threads it creates based on the user device
  * It will automatically create fewer threads on less powerful devices.
* Blocking code stops any further code executing until some work finishes.
  * Slow work is best done on a background thread to avoid problems.
* Once work starts on a background thread, it will continue on that background thread until it finishes or you push work back to the main thread.
  * This makes for a common thread bounce: push work to the background, then push it back to the main thread to update the UI.
* ~~Creating UI code on a background thread is safe as long as you don't show it~~
  * :red_circle: No user interface code should be run on a background thread.
* ~~Because GCD works across CPU cores, you don't need to worry about strong reference cycles.~~
  * :red_circle: Strong reference cycles continue to be a risk with or without GCD.
* You can use `#selector` to point at methods from UIKit classes.
  * We could write `#selector(UITableView.reloadData)` to call that method on a table view.
* When calling `async()` we provide our work as a closure.
  * This way GCD can make sure that code executes on whichever thread is available.
* `performSelector()` can only run methods that are marked with `@objc`.
  * This is an Objective-C call, so the `@objc` attribute is required.
* GCD runs code on a first in, first out (FIFO) basis.
  * FIFO queues ensure work begins in the order we requested.
* GCD takes care of creating, scheduling, and destroying threads automatically.
  * This is the main reason it makes multitasking so easy compared to doing that work ourselves.















