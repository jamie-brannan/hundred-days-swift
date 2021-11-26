# *Day 72 • Thursday November 25, 2021*

> Tim Ferriss is a well-known podcaster and angel investor, who once said “in a digital world, there are numerous technologies that we are attached to that create infinite interruption.” And it’s true: there’s a little jolt of excitement when we see your iPhone screen light up, because it means something interesting has happened.
> 
> In iOS these app interruptions come in two forms: either the app has received some remote data from the internet and it needs to be shown immediately, or it scheduled a local alert to be shown at a specific day and time. Remote data, known as push notifications, takes quite a lot of set up because you need a server capable of communicating with Apple’s push notification server (APNS), but local alerts aren’t hard at all, so they are what we’ll be looking at today.
> 
> But please remember: just because you can show a notification doesn’t mean you should – if the user grants you some permission you should be grateful, and try not to abuse that responsibility!
> 
> **Today you have three topics to work through, and you’ll learn about `UNUserNotificationCenter`, requesting permission for notifications, the different kinds of notification trigger, and more.**

- [*Day 72 • Thursday November 25, 2021*](#day-72--thursday-november-25-2021)
  - [:one:  Setting up](#one--setting-up)
  - [:two:  Scheduling notifications: UNUserNotificationCenter and UNNotificationRequest](#two--scheduling-notifications-unusernotificationcenter-and-unnotificationrequest)
  - [:three:  Acting on responses](#three--acting-on-responses)

## :one:  [Setting up](https://www.hackingwithswift.com/read/21/1/setting-up) 

> This is going to be the easiest technique project in the entire series, and I expect you're extremely relieved to hear that because it can be hard going always having to learn new things!
> 
> What you're going to learn about are local notifications, which let you send reminders to your user's lock screen to show them information when your app isn't running. If you set a reminder in your calendar, making it pop up on your lock screen at the right time is a local notification.
> 
> These aren't the same as push notifications, and in fact they are quite a different beast from a development perspective. I would love to cover push notifications here, but they require a dedicated server (or service, if you outsource) to send from and that's outside the remit of this course. Much later on – project 33 to be precise – we look at CloudKit, which can send push notifications when data is changed, but I wouldn’t recommend skipping ahead.
> 
> To get started, create a new Single View App project in Xcode, and name it Project21.

## :two:  [Scheduling notifications: UNUserNotificationCenter and UNNotificationRequest](https://www.hackingwithswift.com/read/21/2/scheduling-notifications-unusernotificationcenter-and-unnotificationrequest) 

> We only need two buttons to control the entire user interface for this project, and the easiest way to do that is using navigation bar buttons. So, open Main.storyboard in Interface Builder and embed the view controller inside a navigation controller – and that’s it for the interface.
> 
> Open ViewController.swift and add these two method stubs:

## :three:  [Acting on responses](https://www.hackingwithswift.com/read/21/3/acting-on-responses) 

> There’s a lot more you can do with notifications, but chances are the thing you most want to do is act on the user’s response – to show one or more options alongside your alert, then respond to the user’s choice.
> 
> We already set the categoryIdentifier property for our notification, which is a text string that identifies a type of alert. We can now use that same text string to create buttons for the user to choose from, and iOS will show them when any notifications of that type are shown.
> 
> This is done using two new classes: UNNotificationAction creates an individual button for the user to tap, and UNNotificationCategory groups multiple buttons together under a single identifier.
> 
> For this technique project we’re going to create one button, “Show me more…”, that will cause the app to launch when tapped. We’re also going to set the delegate property of the user notification center to be self, meaning that any alert-based messages that get sent will be routed to our view controller to be handled.
> 
> Creating a UNNotificationAction requires three parameters:
> 
> An identifier, which is a unique text string that gets sent to you when the button is tapped.
> A title, which is what user’s see in the interface.
> Options, which describe any special options that relate to the action. You can choose from .authenticationRequired, .destructive, and .foreground.
> Once you have as many actions as you want, you group them together into a single UNNotificationCategory and give it the same identifier you used with a notification.
> 
> That’s it! Add this method to ViewController now:

```swift
func registerCategories() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self

    let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

    center.setNotificationCategories([category])
}
```

> You might have noticed the empty intentIdentifiers parameter in the category initializer - this is used to connect your notifications to intents, if you have created any.
> 
> You’ll get an error because you assigned self to be the delegate of the user notification center. To fix it, make the ViewController class conform to UNUserNotificationCenterDelegate like this:

```swift
class ViewController: UIViewController, UNUserNotificationCenterDelegate {
```

> You can call registerCategories() wherever you want, but in this project the safest place is probably right at the beginning of the scheduleLocal() method.
> 
> Now that we have registered the “alarm” category with a single button, the last thing to do is implement the didReceive method for the notification center. This is triggered on our view controller because we’re the center’s delegate, so it’s down to us to decide how to handle the notification.
> 
> We attached some customer data to the userInfo property of the notification content, and this is where it gets handed back – it’s your chance to link the notification to whatever app content it relates to.
> 
> When the user acts on a notification you can read its actionIdentifier property to see what they did. We have a single button with the “show” identifier, but there’s also UNNotificationDefaultActionIdentifier that gets sent when the user swiped on the notification to unlock their device and launch the app.
> 
> So: we can pull out our user info then decide what to do based on what the user chose. The method also accepts a completion handler closure that you should call once you’ve finished doing whatever you need to do. This might be much later on, so it’s marked with the @escaping keyword.
> 
> Here’s the code – add this method to ViewController now:

```swift
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // pull out the buried userInfo dictionary
    let userInfo = response.notification.request.content.userInfo

    if let customData = userInfo["customData"] as? String {
        print("Custom data received: \(customData)")

        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // the user swiped to unlock
            print("Default identifier")

        case "show":
            // the user tapped our "show more info…" button
            print("Show more information…")

        default:
            break
        }
    }

    // you must call the completion handler when you're done
    completionHandler()
}
```
> Our project now creates notifications, attaches them to categories so you can create action buttons, then responds to whichever button was tapped by the user – we’re done!

