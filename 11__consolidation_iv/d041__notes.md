*Day 41  • Wednesday January 13, 2021*

>There is some pseudo-science that claims the second or third Monday in January is “blue Monday” – the most depressing day of the year. The reasons given include weather conditions in the northern hemisphere being bleak, the amount of time since the Christmas holiday, the number of people giving up on New Year’s resolutions, and more.
>
>It is, of course, nonsense, but it does have one grain of truth: it’s easy to get discouraged when you’re part-way through something, because the initial novelty has worn off and there’s still a lot more work ahead of you.
>
>That’s where you are today. You’re less than half the way through the 100 Days of Swift, but you’re already being asked to tackle complicated topics in multiple consecutive days – the difficulty level is ramping up, the pace probably feels a little quicker, and the amount of code you’re being asked to write is also going up.
>
>I know some of the days you’ve faced have been harder than others, and I also know you’re probably feeling tired – you’re giving up a lot of time to make this happen. But I want to encourage you to keep pushing on: you’re almost at the half-way point now, and the apps you’re now able to build are genuinely useful – you’ve come a long way!
>
>Helpfully, today is another consolidation day, which is partly a chance for us to go over some topics again to make sure you really understand them, partly a chance for me to dive into specific topics such as `enumerated()` and GCD’s background/foreground bounce, and partly a chance for you to try making your own app from scratch.
>
>As always, the challenge you’ll face is absolutely within your current skill level, and it gives you a chance to see how far you’ve come for yourself. Ricky Mondello – one of the team who builds Safari at Apple – once said, “one of my favorite things about software engineering, or any kind of growth really, is coming back to something that you previously thought was too hard and knowing that you can do it.”
>
>Today you have three topics to work through, one of which of is your challenge.
>
>Note: Don’t worry if you don’t complete challenges in the day they were assigned – in future days you’ll find you have some time to spare here and there, so challenges are something you can return back to in the future.

## :one: [What you learned](https://www.hackingwithswift.com/guide/4/1/what-you-learned) 

>Projects 7, 8, and 9 were the first in the series I consider to be “hard”: you had to parse JSON data, you had to create a complex layout for 7 Swifty Words, and you took your first steps towards creating multithreaded code – code that has iOS do more than one thing at a time.
>
>None of those things were easy, but I hope you felt the results were worth the effort. And, as always, don’t worry if you’re not 100% on them just – we’ll be using `Codable` and GCD more in future projects, so you’ll have ample chance to practice.

>* You’ve now met `UITabBarController`, which is another core iOS component – you see it in the App Store, Music, iBooks, Health, Activity, and more.
>* Each item on the tab bar is represented by a `UITabBarItem` that has a title and icon. If you want to use one of Apple’s icons, it means using Apple’s titles too.
>* We used `Data` to load a URL, with its `contentsOf` method. That then got fed to `JSONDecoder` so that we could read it in code.
>* We used `WKWebView` again, this time to show the petition content in the app. This time, though, we wanted to load our own HTML rather than a web site, so we used the `loadHTMLString()` method.
>* Rather than connect lots of actions in Interface Builder, you saw how you could write user interfaces in code. This was particularly helpful for the letter buttons of 7 Swifty Words, because we could use a nested loop.
>* In project 8 we used property observers, using `didSet`. This meant that whenever the `score` property changed, we automatically updated the `scoreLabel` to reflect the new score.
>* You learned how to execute code on the main thread and on background threads using `DispatchQueue`, and also met the `performSelector(inBackground:)` method, which is the easiest way to run one whole method on a background thread.
>* Finally, you learned several new methods, not least `enumerated() `for looping through arrays, `joined()` for bringing an array into a single value, and `replacingOccurrences()` to change text inside a string.

## :two:  [Key points](https://www.hackingwithswift.com/guide/4/2/key-points) 

## :three:  [Challenge](https://www.hackingwithswift.com/guide/4/3/challenge) 