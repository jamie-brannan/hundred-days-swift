//
//  ViewController.swift
//  ConsolidationV
//
//  Created by Jamie Brannan on 11/03/2021.
//

import UIKit

class DetailViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet var imageView: UIImageView!
  var galleryItem: Photo?
  var pictureCount: Int?
  var selectedImageListOrderRank: Int?
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let galleryItem = galleryItem, let detailPictureCount = pictureCount, let detailSelectedImageOrderRank = selectedImageListOrderRank else { return }
    let path = GalleryUserDefaults.getGalleryItemURL(for: galleryItem.image)
    imageView.image  = UIImage(contentsOfFile: path.path)
    title = "Picture \(detailSelectedImageOrderRank + 1) of \(detailPictureCount)"
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editGalleryItem))
  }

  @objc func editGalleryItem() {
    let ac = UIAlertController(title: "Labeling", message: "What would you like to call your photo?", preferredStyle: .alert)
    ac.addTextField() { (textField) in
      textField.placeholder = "Name photo"
    }
    ac.addTextField() { (textField) in
      textField.placeholder = "Caption your photo"
    }
    ac.addAction(UIAlertAction(title: "OK", style: .default) { [self, weak ac] _ in
      guard let newName = ac?.textFields?[0].text, newName != "" else { return }
      guard let newComment = ac?.textFields?[1].text, newComment != "" else { return }
      self.galleryItem?.name = newName
      galleryItem?.comment = newComment
    })
    self.present(ac, animated: true)
  }

}

