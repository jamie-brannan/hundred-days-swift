*Day 39 • Sunday January 10, 2021*

>Joss Whedon, the creator of Firefly, once said that “the secret to multitasking is that it isn't actually multitasking – it’s just extreme focus and organization.” (If you weren’t aware, Firefly played a big part in the development of Swift – the internal code name (“Shiny”) was from there, the original documentation mentioned the series a lot, and you’ll even find references to Firefly in my work!)
>
>Of course, computers operate very different from people: an iPhone XS has six CPU cores inside, and each of those six things can work independently of the others. If you use just one of them – as we have been doing all this time – then your app will never come close to using the full power of the device.
>
>So, to make the most of those cores we need to do real multitasking: not just extreme focus and organization, but dividing up work that can happen simultaneously across as many cores as we need.
>
>This is traditionally A Very Hard Problem, but Apple has a framework called Grand Central Dispatch that makes it remarkably easy. It does, however, use closures, so brace yourself!
>
>Today you have five topics to work through, and you’ll learn about Grand Central Dispatch, quality of service queues, performSelector(), and more.