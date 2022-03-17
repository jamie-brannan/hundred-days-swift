# *Day 76 • Saturday February 19, 2022*

> This is one of those projects that unleashes a massive range of possibilities if you stop to think for a moment. Almost any physical location – from an office to a warehouse to a school to a museum – can benefit from triggering behaviors on the user’s device as they move around, so the real question is: what are you going to do with this technology?
> 
> Mo Farah – multiple-time British Olympic gold medallist – said “if you dream and have the ambition and want to work hard, then you can achieve.” Today is day 76 so you can clearly work hard, and I hope I’ve planted the dream of something big in your head – all that remains is your ambition to bring about that goal based on what you know.
> 
> And before you start doubting yourself, think about it: at this point you already know large parts of UIKit and SpriteKit, you can fetch and parse data from the internet using `Codable`, you can mark locations on maps, read from the camera, create animations, and more – the range of apps you can build is huge if you put your mind to it.
> 
> Today you should work through the wrap up chapter for project 22, complete its review, then work through all three of its challenges.
> 
> That’s another project finished, and one that opens a whole new world of micro-location possibilities – share your progress with the world!

## :one: [Wrap up](https://www.hackingwithswift.com/read/22/4/wrap-up) 

> Working with iBeacon locations is different from working with maps. The technology is often called micro-location because it can tell the difference between a few centimeters and a meter or more. Plus it works inside, which is somewhere GPS continues to be poor, and understandably.
> 
> What I like about iBeacons is their subtlety: hardware beacons are almost invisibly small, yet provide the ability for apps to respond to a user’s precise location – you can now make apps for museums, galleries, stores, schools, warehouses, and more, and it took less than 30 minutes.

### Challenge

> One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
>   - [ ]  Write code that shows a `UIAlertController` when your beacon is first detected. Make sure you set a `Boolean` to say the alert has been shown, so it doesn’t keep appearing.
>
>   - [ ]  Go through two or three other iBeacons in the Detect Beacon app and add their UUIDs to your app, then register all of them with iOS. Now add a second label to the app that shows new text depending on which beacon was located.
>
>   - [ ]  Add a circle to your view, then use animation to scale it up and down depending on the distance from the beacon – try 0.001 for unknown, 0.25 for far, 0.5 for near, and 1.0 for immediate. You can make the circle by adding an image, or by creating a view that’s 256 wide by 256 high then setting its layer.cornerRadius to 128 so that it’s round.

:warning: *A lot of dev environment obstacles to this, going to have to come back to it* 

## :two: [Review](https://www.hackingwithswift.com/review/hws/project-22-detect-a-beacon) 

iBeacons operate over Bluetooth.
Bluetooth is the low-power networking protocol that lets iBeacons work for years on a tiny battery.

CLLocationManager is responsible for telling us when beacons are detected.
We need to assign an object as its delegate, then wait for callbacks when something happens.

`@unknown default` cases let us catch values that were created after we wrote our code.
This helps our code behave sensibly even if iOS changes after we ship an app.

All modern iPhones and iPads support iBeacons.
iBeacons were first introduced way back with the iPhone 4S.

**iOS devices are capable of acting as iBeacons.**
Using an iOS is an easy way to test detection and ranging.

The signal of iBeacons is relatively weak, and can be interrupted even by turning your back away from the beacon.
_As a result of this they are usually best placed on ceilings so they don't get blocked by people._

Ranging a beacon means determining how far away it is.

iBeacon detection is powered by the Core Location framework.
Core Location can also tell us the user's precise location and more.

"plist" is short for "property list".
Property lists can contain strings, integers, Booleans, dates, `Data` instances, plus arrays and dictionaries of each of those.

We must ask permission to read the user's location.
Location data is highly sensitive, so ask for it only if you need it.

`UUID` is its own dedicated type in Swift, and it has a precise format that must be followed.

 If we request Always location permission iOS will still offer users the chance to choose When In Use.
_This is one of the many security precautions Apple enforces on behalf of users._
* :question: *This is pretty important in terms of developing I imagine, ie. – you can't propose a feature and have it be one way or another, there's always a possibility of degrated experience I guess?*

`CLProximity` gives us a rough indication of how far away the beacon is.

The user can change their location permission preference at any point.
This option is available inside Settings for each app that has requested location.

iBeacons have major and minor numbers that help us differentiate one beacon from another.
These are used to subdivide your beacon's UUID.

:question: *Are an iBeacons UUID's the same as the actual device UUID when it's an iOS device of another person (phone, tablet etc)?* 