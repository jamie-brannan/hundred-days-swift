//
//  ViewController.swift
//  Project11
//
//  Created by Jamie Brannan on 05/04/2021.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: Outlets
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var intensitySlider: UISlider!
  
  // MARK: Properties
  var currentImage: UIImage!
  
  var context: CIContext!
  var currentFilter: CIFilter!
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Instafilter"
    navigationItem.prompt = "Day 52 of 100"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    
    context = CIContext()
    currentFilter = CIFilter(name: "CISepiaTone")
  }
  
  @objc func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    
    dismiss(animated: true)
    
    currentImage = image
    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    
    applyProcessing()
  }
  
  @IBAction func changeFilter(_ sender: Any) {
  }
  
  @IBAction func save(_ sender: Any) {
  }
  
  @IBAction func intensityChanged(_ sender: Any) {
    applyProcessing()
  }
  
  func applyProcessing() {
    // The first line safely reads the output image from our current filter
    guard let image = currentFilter.outputImage else { return }
    // For sepia toning a value of 0 means "no effect" and 1 means "fully sepia."
    currentFilter.setValue(intensitySlider.value, forKey: kCIInputIntensityKey)
    
    if let cgimg = context.createCGImage(image, from: image.extent) {
      let processedImage = UIImage(cgImage: cgimg)
      imageView.image = processedImage
    }
  }
}

