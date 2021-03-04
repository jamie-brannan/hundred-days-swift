//
//  DetailViewController.swift
//  Project1
//
//  Created by Jamie Brannan on 11/06/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet var imageView: UIImageView!
  var selectedImage: String?
  var pictureCount: Int?
  var pictureViewCount: Int?
  var selectedImageListOrderRank: Int?
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    /// Unwrapping optionalos
    guard let detailPictureCount = pictureCount, let detailSelectedImageOrderRank = selectedImageListOrderRank, let detailPictureViewCount = pictureViewCount else {
      print("somethings missing")
      return
    }

    title = "Picture \(detailSelectedImageOrderRank + 1) of \(detailPictureCount)"
    navigationItem.prompt = "\(detailPictureViewCount) views"
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

    if let imageToLoad = selectedImage {
      imageView.image  = UIImage(named: imageToLoad)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }

  @objc func shareTapped() {
    let imaginaryAppLink = NSURL(string: "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8")!
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8), let imageName = selectedImage else {
        print("No image found")
        return
    }
    let vc = UIActivityViewController(activityItems: [image, imageName, imaginaryAppLink], applicationActivities: nil)
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }
}
