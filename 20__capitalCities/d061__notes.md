# *Day 61 • Wednesday May 26, 2021*

>I could easily have written this whole course about UIKit, skipping out Core Image, SpriteKit, MapKit, and more. But my hope is that by immersing you in other Apple frameworks you’re starting to become soaked in their way of approaching things – you’re starting to build a build a gut instinct for how Apple’s framework work.
>
>I realize this place extra learning stress on you, because rather than staying within our comfort we’re constantly pushing forward into new things. It will help you in the long term, though – as James Bryant Conant said, “behold the turtle – it makes progress only when it sticks its neck out.”
>
>Today you’ve finished another app, and I hope feel like you have a basic grasp of how maps work. There’s a lot more you can do with them, such as adding placemarks, looking up locations, and finding directions, but I hope you can at least see that it’s all within your grasp now!
>
>**Today you should work through the wrap up chapter for project 16, complete its review, then work through all three of its challenges.**
>
>That’s another project finished, and one that gets you started with one of the most popular and powerful iOS frameworks – make sure you share your progress with others once you complete the challenges!

- [*Day 61 • Wednesday May 26, 2021*](#day-61--wednesday-may-26-2021)
  - [:one:  Wrap up](#1️⃣-wrap-up)
    - [Challenge](#challenge)
  - [:two:  Review for Project 16: Capital cities](#2️⃣-review-for-project-16-capital-cities)
    - [:boom: Quiz insights](#-quiz-insights)

## :one:  [Wrap up](https://www.hackingwithswift.com/read/16/4/wrap-up) 

I tried to keep this project as simple as possible so that you can focus on the map component, because there was a lot to learn: MKMapView, MKAnnotation, MKPinAnnotationView, CLLocationCoordinate2D and so on, and all must be used before you get a finished product.

Again, we've only scratched the surface of what maps can do in iOS, but that just gives you more room to extend the app yourself!

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
>   - [x]   Try typecasting the return value from `dequeueReusableAnnotationView()` so that it's an `MKPinAnnotationView`. Once that’s done, change the `pinTintColor` property to your favorite `UIColor`.

```swift
    if let annotationPinView = annotationView as? MKPinAnnotationView {
      annotationPinView.pinTintColor = .cyan
      return annotationPinView
    }
```

:white_check_mark: Easy peasy!

>   - [x]   Add a `UIAlertController` that lets users specify how they want to view the map. There's a `mapType` property that draws the maps in different ways. For example, `.satellite` gives a satellite view of the terrain.

Go dictionaries :) 

```swift
  let types: [String:MKMapType] = [
    "Hybrid" : MKMapType.hybrid,
    "Satellite" : MKMapType.satellite,
    "Muted Standard" : MKMapType.mutedStandard
  ]

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map type", style: .plain, target: self, action: #selector(askForMapType))

    @objc func askForMapType() {
    let ac = UIAlertController(title: "Welcome!", message: "What style of map would you like?", preferredStyle: .alert)
    for (typeName, rawMapType) in types {
      ac.addAction(UIAlertAction(title: typeName, style: .default) { _ in
        self.mapView.mapType = rawMapType
      })
    }
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
  }
```


>   - [ ]   Modify the callout button so that pressing it shows a new view controller with a web view, taking users to the Wikipedia entry for that city.

## :two:  [Review for Project 16: Capital cities](https://www.hackingwithswift.com/review/hws/project-16-capital-cities) 

### :boom: Quiz insights

* Every map annotation needs a latitude and longitude coordinate.
  * Without this information the annotation wouldn't make sense – where would it go?
* If we make a class and don't give all its properties default values, we need to create a custom initializer.
  * Structs benefit from a default memberwise initializer.
* MKPinAnnotationView is a built-in class that draws tappable pins on the map.
  * As its name suggests, this draws a pin on the map.
* Annotation titles are automatically shown by MapKit.
  * This is the default behavior of MapKit.
* We can add individual map annotations, or add lots at once.
  * There are two method calls: addAnnotation() and addAnnotations().
* There's a specific UIButton type called detailDisclosure, which creates an "i" with a ring around it.
  * This is commonly used to let users dig into more detail on something.
* Custom annotations can have extra properties of our choosing.
  * This can be anything you want – strings, integers, arrays, and more.
* The dequeueReusableAnnotationView(withIdentifier:) method might return nil.
  * This returns an optional annotation view, so we need to unwrap it carefully.
* Map views have annotations that weren't created by us, such as the user's location.
  * This means we need to be careful when creating views for annotations.
* Map annotations may or may not have a title.
  * This is an optional string.
* We can choose from multiple map styles, such as satellite maps.
   *  Maps have a mapType property that lets us control this.
*  The MKMapViewDelegate protocol lets us control the way an MKMapView works.
   *  This is what contains the viewFor method that lets us control how annotation views look.