# *Day 31 • Thursday October 29, 2020*

- [*Day 31 • Thursday October 29, 2020*](#day-31--thursday-october-29-2020)
  - [:one: Auto Layout metrics and priorities: constraints(withVisualFormat:)](#one-auto-layout-metrics-and-priorities-constraintswithvisualformat)

>One of the three laws laid down by British science fiction writer Arthur C. Clarke is particularly well known: “any sufficiently advanced technology is indistinguishable from magic.”
>
>It’s possible that you’re thinking Auto Layout is a bit of a black box, where magic happens to make sure all your rules are followed. But it isn’t: Auto Layout is actually straightforward most of the time, and as long as you make sure your constraints are a) complete, and b) non-contradictory, you shouldn’t have too many problems.
>
>Today you have three topics to work through, and you’ll learn about advanced Visual Formatting Language and Auto Layout anchors. Once you’re done, please complete the project review then work through all three of its challenges.
>
>* Auto Layout metrics and priorities: constraints(withVisualFormat:)
>* Auto Layout anchors
>* Wrap up
>* Review for Project 6: Auto Layout
>
>If you’re keen to learn more about Auto Layout, I have an Auto Layout cheat sheet that gives you lots of example code to solve common problems.
>
>If you’re feeling mathematically brave, there’s also a great talk by Agnes Vasarhelyi that goes into exactly how the Auto Layout algorithm works behind the scenes – it should prove there’s no magic once and for all!

## :one: [Auto Layout metrics and priorities: constraints(withVisualFormat:)](https://www.hackingwithswift.com/read/6/4/auto-layout-metrics-and-priorities-constraintswithvisualformat) 

>We have a working layout now, but it's quite basic: the labels aren't very high, and without a rule regarding the bottom of the last label it's possible the views might be pushed off the bottom edge.
>
>To begin to fix this problem, we're going to add a constraint for the bottom edge saying that the bottom of our last label must be at least 10 points away from the bottom of the view controller's view. We're also going to tell Auto Layout that we want each of the five labels to be 88 points high. Replace the previous vertical constraints with this:

```swift
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==88)]-[label2(==88)]-[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|", options: [], metrics: nil, views: viewsDictionary))
```

:question: *What's really the origin on this mark up language?*
* is it used else where or something from Unix?

>The difference here is that we now have numbers inside parentheses: `(==88)` for the labels, and `(>=10)` for the space to the bottom. 
>* Note that when specifying the size of a space, you need to use the - before and after the size: a simple space, -, becomes `-(>=10)-`.
>
>We are specifying two kinds of size here: `==` and `>=`. 
>* The first means "exactly equal" and the second "greater than or equal to." 
>
>So, our labels will be forced to be an exact size, and we ensure that there's some space at the bottom while also making it flexible – it will definitely be at least 10 points, but could be 100 or more depending on the situation.
>
>Actually, wait a minute. I didn't want 88 points for the label size, I meant 80 points. Go ahead and change all the labels to 80 points high.
>
>Whoa there! It looks like you just received an email from your IT director: he thinks 80 points is a silly size for the labels; they need to be 64 points, because all good sizes are a power of 2.
>
>And now it looks like your designer and IT director are having a fight about the right size. A few punches later, they decide to split the difference and go for a number in the middle: 72. So please go ahead and make the labels all 72 points high.
>
>Bored yet? You ought to be. And yet this is the kind of **pixel-pushing** it's easy to fall into, particularly if your app is being designed by committee.

:x: yikes

>**Auto Layout has a solution,** and it's called _metrics_. 
>
>All these calls to `constraints(withVisualFormat:)` have been sent `nil` for their metrics parameter, but that's about to change. 
>* You see, you can _give VFL a set of sizes with names_, then use those sizes in the VFL rather than hard-coding numbers. 
>
>For example, we wanted our label height to be 88, so we could create a metrics dictionary like this:

```swift
let metrics = ["labelHeight": 88]
```
>
>Then, whenever we had previously written `==88`, we can now just write `labelHeight`. So, change your current vertical constraints to be this:

```swift
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
```

So this is the type `dictionary` ? Though right?

>So when your designer / manager / inner-pedant decides that 88 points is wrong and you want some other number, you can change it in one place to have everything update.
>
>Before we're done, we're going to make one more change that makes the whole user interface much better, because right now it's still imperfect. 
>
>To be more specific, we're forcing all labels to be a particular height, then adding constraints to the top and bottom. This still works fine in portrait, but in landscape you're unlikely to have enough room to satisfy all the constraints.
>
>With our current configuration, you'll see this message when the app is rotated to landscape: :red_circle: _"Unable to simultaneously satisfy constraints."_ This means your constraints simply don't work given how much screen space there is, and that's where priority comes in. You can give any layout constraint a priority, and Auto Layout will do its best to make it work.
>
>**Constraint priority is a value between 1 and 1000**, where 1000 means "this is absolutely required" and anything less is optional. 

Like Z-index??

>By default, all constraints you have are priority 1000, so Auto Layout will fail to find a solution in our current layout. But if we make the height optional – even as high as priority 999 – it means Auto Layout can find a solution to our layout: shrink the labels to make them fit.
>
>It's important to understand that Auto Layout doesn't just discard rules it can't meet – it still does its best to meet them. So in our case, if we make our 88-point height optional, Auto Layout might make them 78 or some other number. That is, it will still do its best to make them as close to 88 as possible. TL;DR: constraints are evaluated from highest priority down to lowest, but all are taken into account.
>
>So, we're going to make the label height have priority 999 (i.e., very important, but not required). But we're also going to make one other change, which is to tell Auto Layout that we want all the labels to have the same height. This is important, because if all of them have optional heights using `labelHeight`, Auto Layout might solve the layout by shrinking one label and making another 88.
>
>From its point of view it has at least managed to make some of the labels 88, so it's probably quite pleased with itself, but it makes our user interface look uneven. So, we're going to make the first label use `labelHeight` at a priority of 999, then have the other labels adopt the same height as the first label. Here's the new VFL line:

```swift
"V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|"
```
>
>It's the `@999` that assigns priority to a given constraint, and using `(label1)` for the sizes of the other labels is what tells Auto Layout to make them the same height.
>
>That's it: your Auto Layout configuration is complete, and the app can now be run safely in portrait and landscape.