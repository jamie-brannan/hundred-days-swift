# *Day 53 • Monday April 05, 2021*

>Pictures bring any user interface to life, but as app designers it’s our job to frame those pictures with a smart user interface to really bring them to life. As Ben Shneiderman, a professor for Computer Science at the University of Maryland, once said, “a picture is worth a thousand words; an interface is worth a thousand pictures” – for me that really underscores the importance of getting both right!
>
>Today you’re going to be trying Core Image for the first time. Its API has never really been updated for Swift, so you’ll see a few quirks here and there. It also has precious little margin for error, so you’ll see we add various checks to make sure our code is safe at runtime – it’s better to be safe than sorry.
>
>I said it before, but it bears repeating here: Core Image is extraordinarily fast on real iOS devices, but extraordinarily slow in Xcode’s simulator. So, don’t worry if you find the blur effect appears to lock up your Mac while it works – it will happen in the blink of an eye on a real device.
>
>**Today you have three topics to work through, and you’ll learn about `CIContext`, `CIFilter`, and more.**

## :one:  [Applying filters: CIContext, CIFilter](https://www.hackingwithswift.com/read/13/4/applying-filters-cicontext-cifilter) 

>You're probably getting tired of hearing me saying this, but Core Image is yet another super-fast and super-powerful framework from Apple. It does only one thing, which is to apply filters to images that manipulate them in various ways.
>
>One downside to Core Image is it's not very guessable, so you need to know what you're doing otherwise you'll waste a lot of time. It's also not able to rely on large parts of Swift's type safety, so you need to be careful when using it because the compiler won't help you as much as you're used to.
>
>To get started, import CoreImage by adding this line near the top of ViewController.swift:

```swift
import CoreImage
```

>We need to add two more properties to our class, so put these underneath the `currentImage` property:

```swift
var context: CIContext!
var currentFilter: CIFilter!
```
>The first is a Core Image context, which is the Core Image component that handles rendering. We create it here and use it throughout our app, because creating a context is computationally expensive so we don't want to keep doing it.
>
>The second is a Core Image filter, and will store whatever filter the user has activated. This filter will be given various input settings before we ask it to output a result for us to show in the image view.
>
>We want to create both of these in `viewDidLoad()`, so put this just before the end of the method:

```swift
context = CIContext()
currentFilter = CIFilter(name: "CISepiaTone")
```

>That creates a default Core Image context, then creates an example filter that will apply a sepia tone effect to images. It's just for now; we'll let users change it soon enough.
>
>To begin with, we're going to let users drag the slider up and down to add varying amounts of sepia effect to the image they select.
>
>To do that, we need to set our currentImage property as the input image for the `currentFilter` Core Image filter. We're then going to call a method (as yet unwritten) called `applyProcessing()`, which will do the actual Core Image manipulation.
>
>So, add this to the end of the `didFinishPickingMediaWithInfo` method:

```swift
let beginImage = CIImage(image: currentImage)
currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

applyProcessing()
```

>You’ll get an error for `applyProcessing()` because we haven’t written it yet, but we’ll get there soon.
>
>The `CIImage` data type is, for the sake of this project, just the Core Image equivalent of `UIImage`. Behind the scenes it's a bit more complicated than that, but really it doesn't matter.
>
>As you can see, we can create a `CIImage` from a `UIImage`, and we send the result into the current Core Image Filter using the `kCIInputImageKey`. There are lots of Core Image key constants like this; at least this one is somewhat self-explanatory!
>
>We also need to call the (still unwritten!) `applyProcessing()` method when the slider is dragged around, so modify the `intensityChanged()` method to this:

```swift
@IBAction func intensityChanged(_ sender: Any) {
    applyProcessing()
}
```

>With these changes, `applyProcessing()` is called as soon as the image is first imported, then whenever the slider is moved. Now it's time to write the initial version of the `applyProcessing()` method, so put this just before the end of your class:

```swift
func applyProcessing() {
    guard let image = currentFilter.outputImage else { return }
    currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)

    if let cgimg = context.createCGImage(image, from: image.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        imageView.image = processedImage
    }
}
```

>That's only five lines, none of which are terribly taxing.
>
>The first line safely reads the output image from our current filter. This should always exist, but there’s no harm being safe.
>
>The second line uses the value of our `intensity` slider to set the `kCIInputIntensityKey` value of our current Core Image filter. For sepia toning a value of 0 means "no effect" and 1 means "fully sepia."
>
>The third line is where the hard work happens: it creates a new data type called `CGImage` from the output image of the current filter. We need to specify which part of the image we want to render, but using `image.extent` means "all of it." Until this method is called, no actual processing is done, so this is the one that does the real work. This returns an optional `CGImage` so we need to check and unwrap with `if let`.
>
>The fourth line creates a new `UIImage` from the `CGImage`, and line five assigns that `UIImage` to our image view. Yes, I know that `UIImage`, `CGImage` and `CIImage` all sound the same, but they are different under the hood and we have no choice but to use them here.
>
>You can now press Cmd+R to run the project as-is, then import a picture and make it sepia toned. It might be a little slow in the simulator, but I can promise you it runs brilliantly on devices - Core Image is extraordinarily fast.
>
>Adding a sepia effect isn't very interesting, and I want to help you explore some of the other options presented by Core Image. So, we're going to make the "Change Filter" button work: it will show a `UIAlertController` with a selection of filters, and when the user selects one it will update the image.
>
>First, here's the new` changeFilter()` method:

```swift
@IBAction func changeFilter(_ sender: Any) {
    let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
}
```

>That's seven different Core Image filters plus one cancel button, but no new code. When tapped, each of the filter buttons will call the `setFilter()` method, which we need to make. This method should update our `currentFilter` property with the filter that was chosen, set the `kCIInputImageKey` key again (because we just changed the filter), then call `applyProcessing()`.
>
>Each `UIAlertAction` has its title set to a different Core Image filter, and because our `setFilter()` method must accept as its only parameter the action that was tapped, we can use the action's title to create our new Core Image filter. Here's the `setFilter()` method:

```swift
func setFilter(action: UIAlertAction) {  
    // make sure we have a valid image before continuing!
    guard currentImage != nil else { return }

    // safely read the alert action's title
    guard let actionTitle = action.title else { return }

    currentFilter = CIFilter(name: actionTitle)

    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

    applyProcessing()
}
```

>But don't run the project yet! Our current code has a problem, and it's this line:

```swift
currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
```
>That sets the intensity of the current filter. But the problem is that not all filters have an intensity setting. If you try this using the `CIBumpDistortion` filter, the app will crash because it doesn't know what to do with a setting for the key `kCIInputIntensityKey`.
>
>All the filters and the keys they use are described fully in Apple's documentation, but for this project we're going to take a shortcut. There are four input keys we're going to manipulate across seven different filters. Sometimes the keys mean different things, and sometimes the keys don't exist, so we're going to apply only the keys that do exist with some cunning code.
>
>Each filter has an `inputKeys` property that returns an array of all the keys it can support. We're going to use this array in conjunction with the `contains()` method to see if each of our input keys exist, and, if it does, use it. Not all of them expect a value between 0 and 1, so I sometimes multiply the slider's value to make the effect more pronounced.
>
>Change your `applyProcessing()` method to be this:

```swift
func applyProcessing() {
    let inputKeys = currentFilter.inputKeys

    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey) }
    if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }

    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        self.imageView.image = processedImage
    }
}
```

>Using this method, we check each of our four keys to see whether the current filter supports it, and, if so, we set the value. The first three all use the value from our `intensity` slider in some way, which will produce some interesting results. If you wanted to improve this app later, you could perhaps add three sliders.
>
>If you run your app now, you should be able to choose from various filters then watch them distort your image in weird and wonderful ways. Note that some of them – such as the Gaussian blur – will run very slowly in the simulator, but quickly on devices. If we wanted to do more complex processing (not least chaining filters together!) you can add configuration options to the `CIContext` to make it run even faster; another time, perhaps.

## :two:  [Saving to the iOS photo library](https://www.hackingwithswift.com/read/13/5/saving-to-the-ios-photo-library) 

>I know it's fun to play around with Core Image filters (and you've only seen some of them!), but we have a project to finish so I want to introduce you to a new function: `UIImageWriteToSavedPhotosAlbum()`. This method does exactly what its name says: give it a `UIImage` and it will write the image to the photo album.
>
>This method takes four parameters: the image to write, who to tell when writing has finished, what method to call, and any context. The context is just like the context value you can use with KVO, as seen in project 4, and again we're not going to use it here. The first two parameters are quite simple: we know what image we want to save (the processed one in the image view), and we also know that we want `self` (the current view controller) to be notified when writing has finished.
>
>The third parameter can be provided in two ways: vague and clean, or specific and ugly. It needs to be a selector that lists the method in our view controller that will be called, and it's specified using `#selector`. The method it will call will look like this:

```swift
func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
}
```

>Previously we've had very simple selectors, like `#selector(shareTapped)`. And we can use that approach here – Swift allows us to be really vague about the selector we intend to call, and this works just fine:

```swift
#selector(image)
```

>Yes, that approach is nice and easy to read, but it's also very vague: it doesn't say what is actually going to happen. The alternative is to be very specific about the method we want called, so you can write this:

```swift
#selector(image(_:didFinishSavingWithError:contextInfo:))
```

>This second option is longer, but provides much more information both to Xcode and to other people reading your code, so it's generally preferred. To be honest, this particular callback is a bit of a wart in iOS, but the fact that it stands out so much is testament to the fact that there are so few warts around!
>
>Putting it all together, here's the finished `save()` method:

```swift
@IBAction func save(_ sender: Any) {
    guard let image = imageView.image else { return }

    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
}
```

>From here on it's easy, because we just need to write the `didFinishSavingWithError` method. This must show one of two messages depending on whether we get an error sent to us. The error might be, for example, that the user denied us permission to write to the photo album. This will be sent as an `Error?` object, so if it's `nil` we know there was no error.
>
>This parameter is important because if an error has occurred (i.e., the `error` parameter is not `nil`) then we need to unwrap the `Error` object and use its `localizedDescription` property – this will tell users what the error message was in their own language.

```swift
@objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
        // we got back an error!
        let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    } else {
        let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
```
>And that's it: your app now imports pictures, manipulates them with a Core Image filter and a UISlider, then saves the result back to the photo library. Easy!