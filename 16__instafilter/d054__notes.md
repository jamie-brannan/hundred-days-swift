# *Day 54 • Tuesday April 06, 2021*

>Isn’t Core Image amazing? We only dabbled with a handful of effects, but even then it can do things in real-time that would take weeks if not months to code by hand. Even better, it automatically takes full advantage of the GPU and Metal, so you’re guaranteed maximum performance even though we barely wrote any code.
>
>I hope this has given you the taste for exploration. The challenges you’ll be completing today focus on enhancing what you have, but I really do encourage you to look up the list of Core Image filters and try some of them out. It’s fun, you’ll learn stuff, and you’ll really embed your new Core Image knowledge deep inside your brain.
>
>Nate Berkus, a famous American interior designer, once said “you will enrich your life immeasurably if you approach it with a sense of wonder and discovery, and always challenge yourself to try new things.” Well, this is your chance: step out into the world of Core Image, allow yourself to be playful for a while, and see what you can create!
>
>Today you should work through the wrap up chapter for project 13, complete its review, then work through all three of its challenges.
>
>* Wrap up
>* Review for Project 13: Instafilter
>
>That’s another project finished, and one that should be able to make some really interesting and experimental images! This is a great point to share your progress with others.

## :one: [Wrap up](https://www.hackingwithswift.com/read/13/6/wrap-up) 

>This has been the briefest possible introduction to Core Image, yet we still managed to make something useful, using UISlider for the first time and even writing images to the photo album.
>
>Unless you really do intend to make Yet Another Core Image Filters Program (best of luck!) your use of Core Image will mostly be about manipulating a picture in a very specific way, using a filter you have hand-crafted to look great.
>
>If you want to try other filters, search on Google for "Core Image Filter Reference" and have a read – it will list the input keys for each of them so that you can get really fine-grained control over the filters.

### Review what you learned

>Anyone can sit through a tutorial, but it takes actual work to remember what was taught. It’s my job to make sure you take as much from these tutorials as possible, so I’ve prepared a short review to help you check your learning.

### Challenge

>One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your new knowledge to make sure you fully understand what’s going on:
>
>1. Try making the Save button show an error if there was no image in the image view.

```swift
  @IBAction func save(_ sender: Any) {
    let warningAC = UIAlertController(title: "Ooops!", message: "You have not selected an image to edit yet.", preferredStyle: .alert)
    warningAC.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
    guard let image = imageView.image else { return present(warningAC, animated: true) }

    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }
```

:white_check_mark: Complete

>2. Make the Change Filter button change its title to show the name of the currently selected filter.

  - [x]  add outlet to button on view
  - [x]  program button to always be set to the name of the currentFilter

For looped over possible titles, then used a `changeFilterButton.setTitle("CISepiaTone", for: .normal)` on a new outlet

>3. Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.

What other slider could we possibly want?

What is the name of the types of inputs the filters can have (but not all have?)

We're working with [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter)
* _You use the CIFilter object in conjunction with other Core Image classes, such as CIImage, CIContext, and CIColor, to take advantage of the built-in Core Image filters when processing images, creating filter generators, or writing custom filters._

The CIFilter class automatically manages input parameters when archiving, copying, and deallocating filters. For this reason, your subclass must obey the following guidelines to ensure proper behavior:
>
>* Store input parameters in instance variables whose names are prefixed with input.
>
>* Don’t use auto-synthesized instance variables, because their names are automatically prefixed with an underscore. Instead, synthesize the property manually. For example: `@synthesize inputMyParameter;`
>
>* If using manual reference counting, don’t release input parameter instance variables in your dealloc method implementation. The dealloc implementation in the CIFilter class uses Key-value coding to automatically set the values of all input parameters to nil.

So currently we have : `@IBOutlet var intensitySlider: UISlider!`, whic is applied...

```swift
  func applyProcessing() {
    let inputKeys = currentFilter.inputKeys
    
    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensitySlider.value, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensitySlider.value * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensitySlider.value * 10, forKey: kCIInputScaleKey) }
    if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }
    
    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
      let processedImage = UIImage(cgImage: cgimg)
      self.imageView.image = processedImage
    }
  }
```

So what if for [Filter Parameter Keys](https://developer.apple.com/documentation/coreimage/cifilter/filter_parameter_keys)...
* kCIInputIntensityKey
* kCIInputRadiusKey
* kCIInputScaleKey
* kCIInputCenterKey

These are constants for the Filter but not all filters use all the constants. Right now we use more than parameter key to hold the value of the slider.

`intensitySlider` linked only to :arrow_right: `kCIInputIntensityKey`

:heavy_plus_sign: 3?

  - [x]  add slider to storyboard
  - [x]  refactor the `kCIInputRadiusKey`
  - [x]  completely re did all of the constraints by hand (good practice)


## :two: [Review for Project 13: Instafilter](https://www.hackingwithswift.com/review/hws/project-13-instafilter) 

### :boom: Quiz insights

* We can track changes in the value of a UISlider using its valueChanged event.
  * This gets reported back to us every time the slider is moved.
* ~~You should create a new CIContext for each image transformation.~~
  * :red_circle: Core Image contexts are expensive to create, so it's best to re-use them where possible.
* Any method used with `#selector` must be marked `@objc`
* When our user has selected an image inside a UIImagePickerController, our didFinishPickingMediaWithInfo method will get called.
  * We get passed a dictionary of data to read from.
* Setting allowsEditing to true lets users crop the photo they select.
  * They can also resize it so it better fits what they want.
* Writing to the user's photo library requires permission.
  * Make sure you set the "Privacy - Photo Library Additions Usage Description" key in your Info.plist file, otherwise your app will crash.
* Core Image runs slowly in the simulator
  * It's always, always better to test Core Image filters on a real device - even something that's four or more years old.
* Core Image filters are created using their names.
  * This does bypass some of the safety we're used to in Swift, but it also means Apple can add filters easily.
*  Xcode can automatically suggest Auto Layout constraints.
   *  Although it doesn't always get them correct, these usually provide a good foundation to improve on.
*  ~~A UIImageView always has a UIImage inside.~~
   *  :red_circle: Unless you assign an image, the image property of an image view will be nil.
*  We can create a UIImage from a CGImage.
   *  When reading images from Core Image, we should convert to CGImage first, and from there to UIImage.
*  Setting no handler closure for a UIAlertAction will cause your alert controller to be dismissed.
   *  This is generally a good idea for simple cancel buttons.
*  ~~Core Image works directly with UIImage.~~
   *  :red_circle: Core Image has its own special image type, CIImage.
*  We provide input to Core Image filters using a series of keys and values.
   *  All the keys have specific constants, such as `kCIInputIntensityKey`.
*  Each Core Image filter has its own set of keys that it supports.
   *  Your app will crash if you try to use a key that the filter doesn't support.





