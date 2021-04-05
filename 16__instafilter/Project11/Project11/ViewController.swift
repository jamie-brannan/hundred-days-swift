//
//  ViewController.swift
//  Project11
//
//  Created by Jamie Brannan on 05/04/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet var imageView: UIImageView!
  @IBOutlet var intensitySlider: UISlider!
  var currentImage: UIImage!

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Instafilter"
    navigationItem.prompt = "Day 52 of 100"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
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
  }

  @IBAction func changeFilter(_ sender: Any) {
  }
  
  @IBAction func save(_ sender: Any) {
  }
  
  @IBAction func intensityChanged(_ sender: Any) {
  }
}

