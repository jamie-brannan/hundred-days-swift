//
//  DetailViewController.swift
//  Consolidation2
//
//  Created by Jamie Brannan on 17/09/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var flagImage: UIImageView!
  var selectedImage : String?
    
  override func viewDidLoad() {
    super.viewDidLoad()

    addShareButton()
    loadFlagImage()
  }

  func loadFlagImage(){
    if let loadImage = selectedImage {
      flagImage.image = UIImage(named: loadImage)
      flagImage.layer.borderWidth = 2
      flagImage.layer.borderColor = UIColor.lightGray.cgColor
    }
  }

  func addShareButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
  }

  @objc func shareTapped() {
      guard let image = flagImage.image?.jpegData(compressionQuality: 0.8), let imageName = selectedImage else {
          print("No image found")
          return
      }

      let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
      vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
      present(vc, animated: true)
  }
}
