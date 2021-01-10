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

## :three:  [GCD 101 Async](https://www.hackingwithswift.com/read/9/3/gcd-101-async) 

## :four:  [Back to the main thread DispatchQue.main](https://www.hackingwithswift.com/read/9/4/back-to-the-main-thread-dispatchqueuemain) 

## :five:  [Easy GCD using performSelector(inBackground:)](https://www.hackingwithswift.com/read/9/5/easy-gcd-using-performselectorinbackground) 