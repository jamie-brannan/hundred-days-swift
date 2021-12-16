# *Day 73 • Thursday December 09, 2021*

> As I write this, Apple is running a series of adverts with the tagline “if privacy matters in your life, it should matter to the phone your life is on.” Of course, privacy does matter to the vast majority of us – it’s a bit like saying “you only need to floss the teeth you want to keep.”
> 
> It makes sense that Apple is running these ads right now: with companies like Facebook, Amazon, Google, and more making a lot of money over data collection, Apple’s policy of putting users in control really sets the company apart from the pack in a really positive way.
> 
> However, this policy doesn’t end at the border of Cupertino. You’re now a developer on Apple’s platforms, and it behoves you to attempt to follow in their footsteps: put the user in control, respect their settings, and treat their data with respect.
> 
> Today you’re going to be taking on some challenges to do with notifications, but when you’re doing it I want you to keep in mind what I said above: don’t abuse the trust users have placed in us, and remember that millions of apps have shipped before you that worked hard to maintain Apple’s high standards. You’re part of that now and I hope you feel increasingly able to rise to match that heritage.
> 
> Today you should work through the wrap up chapter for project 21, complete its review, then work through all three of its challenges.

- [*Day 73 • Thursday December 09, 2021*](#day-73--thursday-december-09-2021)
  - [:one: Wrap up](#one-wrap-up)
    - [Challenge](#challenge)
  - [:two:  Review for Project 21: Local Notifications](#two--review-for-project-21-local-notifications)

## :one: [Wrap up](https://www.hackingwithswift.com/read/21/4/wrap-up) 

> That was easy, right? And yet it's such a great feature to have, because now your app can talk to users even when it isn't running. You want to show a step count for how far they've walked? Use a notification. You want to trigger an alert because it's their turn to play in a game? Use a notification. You want to send them marketing messages to make them buy more stuff? Actually, just don't do that, you bad person.
> 
> We’ve only scratched the surface of what notifications can do, but if you’d like to explore more advanced topics – such as attaching pictures or letting the user type responses rather than tapping buttons – see my book Advanced iOS: Volume One.
> 
> We’ll be coming back to notifications again in project 33, where CloudKit is used to create and deliver remote notifications when server data has changed.

### Challenge

> One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
>  - [x]  Update the code in `didReceive` so that it shows different instances of `UIAlertController` depending on which action identifier was passed in.
>
>  - [x]  For a harder challenge, add a second `UNNotificationAction` to the `alarm` category of project 21. Give it the title “Remind me later”, and make it call `scheduleLocal()` so that the same alert is shown in 24 hours. (For the purpose of these challenges, a time interval notification with 86400 seconds is good enough – that’s roughly how many seconds there are in a day, excluding summer time changes and leap seconds.)
>
>  - [ ]  And for an even harder challenge, update project 2 so that it reminds players to come back and play every day. This means scheduling a week of notifications ahead of time, each of which launch the app. When the app is finally launched, make sure you call `removeAllPendingNotificationRequests()` to clear any un-shown alerts, then make new alerts for future days.

## :two:  [Review for Project 21: Local Notifications](https://www.hackingwithswift.com/review/hws/project-21-local-notifications) 

> We can only start showing notifications when permission is granted.
> 
> If a function receives a closure parameter and doesn't use it immediately, it must be marked @escaping.
> * Think about it like this: the closure escapes the method rather than being used inside there then thrown away.
> 
> We can change the delegate of the default UNUserNotificationCenter.
> * This lets us control who gets told when notifications are triggered.
> 
> Notifications can include alerts, sounds, and badges.
> There are extra settings, but these are the most common.
> 
> UUID stands for "Universally Unique Identifer".
> UUIDs are a long and random string of letters and numbers.
> 
> Notifications can be attached to a user's location.
> This approach is called "geofencing" and lets us send messages as the user moves about.
> 
> Notifications appear on the user's lock screen.
> If they are currently using their device, notifications also appear as a banner.
> 
> Notification categories let us attach buttons to our notifications.
> Each button can have its own action attached to it for custom behavior.
> 
> Users can launch our app from a notification.
> This isn't required; some notifications work better with a silent action.
> 
> DateComponents stores values like hours, minutes, days, and months.
> We usually just set the components we care about – you might set the month but not the year, for example.
> 
> Notifications are part of the UserNotifications framework.
> This is also available on macOS, tvOS, and watchOS.
> 
> We can attach a custom data dictionary to our notifications.
> This lets us provide context that gets sent back when the notification action is triggered.