*Day 39 • Sunday January 10, 2021*

>Joss Whedon, the creator of Firefly, once said that “the secret to multitasking is that **it isn't actually multitasking – it’s just extreme focus and organization.**” (If you weren’t aware, Firefly played a big part in the development of Swift – *the internal code name (“Shiny”) was from there*, the original documentation mentioned the series a lot, and you’ll even find references to Firefly in my work!)
>
>Of course, computers operate very different from people: an iPhone XS has *six CPU cores inside, and each of those six things can work independently of the others*. If you use just one of them – as we have been doing all this time – then your app will never come close to using the full power of the device.
>
>So, to make the most of those cores we need to do real multitasking: not just extreme focus and organization, but dividing up work that can happen simultaneously across as many cores as we need.
>
>This is traditionally A Very Hard Problem, but Apple has a framework called **Grand Central Dispatch** that makes it remarkably easy. It does, however, use closures, so brace yourself!
>
>Today you have five topics to work through, and you’ll learn about Grand Central Dispatch, quality of service queues, `performSelector()`, and more.

- [:one:  Setting up](#one--setting-up)
- [:two:  Why is locking the UI bad?](#two--why-is-locking-the-ui-bad)
- [:three:  GCD 101 Async](#three--gcd-101-async)
- [:four:  Back to the main thread DispatchQue.main](#four--back-to-the-main-thread-dispatchquemain)
  - [User interface background work](#user-interface-background-work)
- [:five:  Easy GCD using performSelector(inBackground:)](#five--easy-gcd-using-performselectorinbackground)

## :one:  [Setting up](https://www.hackingwithswift.com/read/9/1/setting-up) 

>In this technique project we're going to return to project 7 to solve a critical problem using one of the most important Apple frameworks available: **Grand Central Dispatch**, or GCD. I already mentioned the problem to you, but here's a recap from project 7:
>
>By downloading data from the internet in `viewDidLoad()` our **app will lock up until all the data has been transferred**. 
>* There are solutions to this, but to avoid complexity they won't be covered until project 9.
>
>We're going to solve this problem by using GCD, which will allow us to fetch the data without locking up the user interface. But be warned: even though GCD might seem easy at first, it opens up a new raft of problems, so be careful!
>
>If you want to keep your previous work for reference, take a copy of project 7 now and call it project 9. Otherwise, just modify it in place.

Copied

## :two:  [Why is locking the UI bad?](https://www.hackingwithswift.com/read/9/2/why-is-locking-the-ui-bad) 

>The answer is two-fold. First, we used `Data`'s `contentsOf` to download data from the internet, which is what's known as a blocking call. That is, it blocks execution of any further code in the method until it has connected to the server and fully downloaded all the data.
>
>Second, behind the scenes your app actually _executes multiple sets of instructions at the same time_, which allows it to take advantage of having multiple CPU cores. Each CPU can be doing something independently of the others, which hugely boosts your performance. These code execution processes are called threads, and come with a number of important provisos:
>
>
> 1. **Threads** execute the code you give them, they don't just randomly execute a few lines from `viewDidLoad()` each. 
> * _This means by default your own code executes on only one CPU, because you haven't created threads for other CPUs to work on._

Main thread verus others, we've seen this at work.

> 2. **All user interface work must occur on the main thread,** which is the initial thread your program is created on. If you try to execute code on a different thread, it might work, it might fail to work, it might cause _unexpected results_, or _it might just crash_.

Lesson learned at work :+1:

> 3. **You don't get to control when threads execute, or in what order.** *You create them* and give them to the system to run, and the system handles executing them as best it can.

:question: *But I thought there would at least be when we call an API by starting a thread?*

> 4. Because you don't control the execution order, you need to be extra vigilant in your code to **ensure only one thread modifies your data at one time.**
>
>Points 1 and 2 explain why our call is bad: if all user interface code must run on the main thread, and we just blocked the main thread by using `Data`'s `contentsOf`, it causes the entire program to freeze – the user can touch the screen all they want, but nothing will happen. 
>* When the data finally downloads (or just fails), the program will unfreeze. 
>
>This is a terrible experience, particularly when you consider that iPhones are frequently on poor-quality data connections.
>
>Broadly speaking, if you’re accessing any **remote resource**, you should be doing it on **a background thread** – i.e., _any thread that is not the main thread_. 
>* If you're executing any slow code, you should be doing it on a background thread. 
>
>If you're executing any code that can be run in **parallel** – e.g. adding a filter to 100 photos – you should be doing it on _**multiple** background threads_.
>
>The power of GCD is that _it takes away a lot of the hassle of creating and working with multiple threads_, known as **multithreading**.
>* You don't have to worry about creating and destroying threads, and you don't have to worry about ensuring you have created the optimal number of threads for the current device. 
>* **GCD automatically creates threads for you, and executes your code on them in the most efficient way it can.**

Would I have to do this manually in node.js or other stuff?

>To fix our project, you need to learn three new GCD functions, but the most important one is called `async()` – it means "run the following code asynchronously," i.e. _don't block (stop what I'm doing right now) while it's executing_. Yes, that seems simple, but there's a sting in the tail: **you need to use closures**. Remember those? They are your best friend. No, really.

## :three:  [GCD 101 Async](https://www.hackingwithswift.com/read/9/3/gcd-101-async) 

>We're going to use `async()` twice: 
>1. once to push some code to a background thread, 
>2. then once more to push code back to the main thread.
> 
>This allows us to do any heavy lifting away from the user interface where we don't block things, _but then_ update the user interface safely on the main thread – which is the only place it can be safely updated.
>
>How you call `async()` informs the system where you want the code to run. 
>
>GCD works with a _system of queues_, which are much like a real-world queue: they are **First In, First Out (FIFO) blocks of code**. 
>* What this means is that your GCD calls _don't create threads_ to run in, they just get _assigned to one of the existing threads_ for GCD **to manage**.
>
>GCD creates for you a number of queues, and places tasks in those queues depending on how important you say they are. All are FIFO, _meaning that each block of code will be taken off the queue in the order they were put in_, but more than one code block can be executed at the same time so the finish order isn't guaranteed.
>
>“How important” some code is depends on something called **“quality of service”, or QoS**, which decides what level of service this code should be given. 
>
>Obviously at the top of this is **the main queue**, which runs on your main thread, and should be used to schedule any work that must update the user interface immediately even when that means blocking your program from doing anything else. But there are four background queues that you can use, each of which has their own QoS level set:

>
> 1. **User Interactive**: this is the highest priority background thread, and should be used when you want a background thread to do work that is important to keep your user interface working. 
> * This priority will ask the system to **dedicate nearly all available CPU time to you** to _get the job done as quickly as possible_.
>
> 2. **User Initiated**: this should be used to execute tasks requested by the user that they are now waiting for in order to continue using your app. 
> * It's not as important as user interactive work – i.e., if the user taps on buttons to do other stuff, that should be executed first – but it is important because you're keeping the user waiting.
>
> 3. **The Utility queue**: this should be used for _long-running tasks that the user is aware of, but not necessarily desperate for_ now. 
> * If the user has requested something and can **happily leave it running while they do something else with your app**, you should use Utility.
>
> 4. **The Background queue**: this is for long-running _tasks that the user isn't actively aware of_, or at least **doesn't care about its progress or when it completes**.

Priorities according to user experience

>Those QoS queues affect the way the system prioritizes your work: User Interactive and User Initiated tasks will be executed as quickly as possible **regardless of their effect on battery life**, Utility tasks will be executed with a view to keeping power efficiency as high as possible without sacrificing too much performance, whereas Background tasks will be executed with power efficiency as its priority.

Battery life is a concern based on wether they are visibleor not too.

>GCD automatically balances work so that higher priority queues are given more time than lower priority ones, even if that means temporarily delaying a background task because a user interactive task just came in.
>
>There’s also one more option, which is the **default queue**. This is prioritized between user-initiated and utility, and is **a good general-purpose choice** while you’re learning.

:five: last choice possible – default.

>Enough talking, time for some action: we're going to use `async()` to make all our loading code run in the _background queue with_ **default**_ quality of service_. It's actually only two lines of code different:

```swift
DispatchQueue.global().async {
```
>…before the code you want to run in the background, then a closing brace at the end. If you wanted to specify the user-initiated quality of service rather than use the default queue – which is a good choice for this scenario – you would write this instead:

```swift
DispatchQueue.global(qos: .userInitiated).async {
```

>The `async()` method takes one parameter, which is a closure to execute asynchronously. We’re using trailing closure syntax, which removes an unneeded set of parentheses.
>
>Because `async()` uses closures, you might think to start with `[weak self] in` to make sure there aren’t any accident strong reference cycles, but it isn’t necessary here because GCD runs the code once then throws it away – it won’t retain things used inside.
>
>To help you place it correctly, here's how the loading code should look:

```swift
DispatchQueue.global(qos: .userInitiated).async {
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
            return
        }
    }
}

showError()
```

>Note that because our code is now inside a closure, we need to prefix our method calls with `self.` otherwise Swift complains.
>
>If you want to try the other QoS queues, you could also use .userInteractive, `.utility` or `.background`.

It build but there's a loading error?

## :four:  [Back to the main thread DispatchQue.main](https://www.hackingwithswift.com/read/9/4/back-to-the-main-thread-dispatchqueuemain) 

>With this change, our code is both better and wor_se. It's better because _it no longer blocks the main thread while the JSON downloads from Whitehouse.gov. 
>* It's worse because _we're pushing work to the background_ thread, and any further code called in that work will also be on the background thread.
>
>This change also introduced some confusion: the `showError()` call will get called regardless of what the loading does. Yes, there’s still a call to return in the code, but **it now effectively does nothing** – it’s returning from the _closure that was being executed asynchronously_, not from the whole method.
>
>The combination of these problems means **that regardless of whether the download succeeds or fails**, `showError()` **will be called**. And if the download succeeds, the JSON will be parsed on the background thread and the table view's `reloadData()` will be called on the background thread – and the error will be shown regardless.

### User interface background work

>Let’s fix those problems, starting with the user interface background work. It's OK to parse the JSON on a background thread, but _it's never OK to do user interface work there_.
>
>That's so important it bears repeating twice: **it's never OK to do user interface work on the background thread**.
>
>If you're on a background thread and want to execute code on the main thread, you need to call `async()` again. This time, however, you do it on DispatchQueue.main, which is the main thread, rather than one of the global quality of service queues.
>
>We could modify our code to have `async()` before every call to `showError()` and parse(), but that's both ugly and inefficient. Instead, it's better to place the `async()` call inside `showError()`, wrapping up the whole UIAlertController code, and also inside parse(), but only where the table view is being reloaded. The actual JSON parsing can happily stay on the background thread.
>
>So, inside the `parse()` method find this code:

```swift
tableView.reloadData()
```

>…and replace it with this new code, bearing in mind again the need for self. to make our capturing clear:

```swift
DispatchQueue.main.async {
    self.tableView.reloadData()
}
```
Was missing this

>To stop `showError()` being called regardless of the result of our fetch call, we need to move it inside the call to `DispatchQueue.global()` in `viewDidLoad()`, like this:

```swift
DispatchQueue.global(qos: .userInitiated).async {
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
            return
        }
    }

    self.showError()
}
```

>Remember, we need to add self. to the `showError()` call because it’s inside a closure now.
>
>But this has created a second problem: `showError()` creates and shows a `UIAlertController` – we now have user interface work happening on a background thread, which is always a bad idea.
>
>So, we need to modify `showError()` to push that work back to the main thread, like this:

```swift
func showError() {
    DispatchQueue.main.async {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
}
```

>At this point, this code is in a better place: we do all the slow work off the main thread, then push work back to the main thread when we want to do user interface work. This background/foreground bounce is common, and you'll see it again in later projects.

:white_check_mark: Sent things to respective ques

## :five:  [Easy GCD using performSelector(inBackground:)](https://www.hackingwithswift.com/read/9/5/easy-gcd-using-performselectorinbackground) 

>There’s another way of using GCD, and it’s worth covering because it’s a great deal easier in some specific circumstances. It’s called `performSelector()`, and it has two interesting variants: `performSelector(inBackground:)` and `performSelector(onMainThread:)`.
>
>Both of them work the same way: you pass it the name of a method to run, and `inBackground` will run it on a background thread, and `onMainThread` will run it on a foreground thread. You don’t have to care about how it’s organized; GCD takes care of the whole thing for you. If you intend to run a whole method on either a background thread or the main thread, these two are easiest.
>
>For project 7, we can use this method to clear up the confusion with our `showError()` method. For example, we could refactor the fetching code into a `fetchJSON()` method that can then run in the background like this:

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    performSelector(inBackground: #selector(fetchJSON), with: nil)
}

@objc func fetchJSON() {
    let urlString: String

    if navigationController?.tabBarItem.tag == 0 {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    } else {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    }

    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
    }

    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}

func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
}

@objc func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```

This pulls errors because `navigationController` is only allowed on main thread, so using a selcond for `inBackground` with this no longer works.


>As you can see, it makes your code easier because you don’t need to worry about closure capturing, so we’ll come back to this again in the future. Note: because `performSelector() `uses `#selector`, we need to mark both `fetchJSON()` and `showError()` with the `@objc` attribute.
>
>Because the code is now much simpler, we can add an else block to our JSON decoding, like this:

```swift
if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
    petitions = jsonPetitions.results
    tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
} else {
    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}
```

>This refactored code also makes the return call inside `fetchJSON()` work as intended: the `showError()` method is never called when things go well, because the whole method is exited. What you choose depends on your project’s needs, but I think it’s much easier to understand the program flow using this final approach.

Interesting to know but this is tricky and doesn't seem that useful. We always use DispatchQues in our project anyways. Maybe with buttonsor things that really feel like selectors this could be useful.