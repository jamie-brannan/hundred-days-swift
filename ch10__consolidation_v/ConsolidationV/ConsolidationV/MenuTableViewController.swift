//
//  MenuTableViewController.swift
//  ConsolidationV
//
//  Created by Jamie Brannan on 11/03/2021.
//

import Foundation
import UIKit

class MenuTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // MARK: - Properties
  var photoTitle: String?
  var photoDesc: String?
  var photoPath: String?
  var galleryItems: [Photo] = []

  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNavigationBar()
  }
  
  // MARK: - Setup
  func setUpNavigationBar() {
    title = "Photo Gallery"
    guard let nav = navigationController else { return }
    nav.navigationBar.prefersLargeTitles = true
    navigationItem.prompt = "100 Days of Swift"
    let addNavButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
    navigationItem.rightBarButtonItems = [addNavButton]
  }
  
  @objc func addNewPhoto() {
    let picker = UIImagePickerController()
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      return
    }
    picker.sourceType = .camera
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
  
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  // MARK: - Callbacks
  
  // MARK: Imagepicker
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let photo = info[.editedImage] as? UIImage else { return }
    
    DispatchQueue.global().async { [weak self] in
      let freshPhotoName = UUID().uuidString /// stringify the id name
      if let jpegData = photo.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: GalleryUserDefaults.getGalleryItemURL(for: freshPhotoName))
      }
      
      DispatchQueue.main.async {
        self?.dismiss(animated: true)
        
        let ac = UIAlertController(title: "Labeling", message: "What would you like to call your photo?", preferredStyle: .alert)
        ac.addTextField() { (textField) in
          textField.placeholder = "Name photo"
        }
        ac.addTextField() { (textField) in
          textField.placeholder = "Caption your photo"
        }
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak ac] _ in
          guard let newName = ac?.textFields?[0].text, newName != "" else { return }
          guard let newComment = ac?.textFields?[1].text, newComment != "" else { return }
          self?.saveGalleryItem(name: newName, comment: newComment, image: freshPhotoName)
        })
        self?.present(ac, animated: true)
      }
    }
  }

  func saveGalleryItem(name: String, comment: String, image: String) {
    let galleryItem = Photo(name: name, comment: comment, image: image)
    galleryItems.append(galleryItem)

    DispatchQueue.global().async { [weak self] in
      if let pictures = self?.galleryItems {
        GalleryUserDefaults.saveGalleryItem(items: pictures)
      }

      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Table view
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return galleryItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath) as? MenuItemTableViewCell else {
      fatalError("[MainTableView] – Unable to deque Photo cell")
    }

    let path = GalleryUserDefaults.getGalleryItemURL(for: galleryItems[indexPath.row].image)
    let galleryItem = galleryItems[indexPath.item]
    cell.imageView?.image = UIImage(contentsOfFile: path.path)
    cell.titleLabel.text = galleryItem.name
    cell.subtitleLabel.text = galleryItem.comment
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
      vc.galleryItem = galleryItems[indexPath.row]
      vc.pictureCount = galleryItems.count
      vc.selectedImageListOrderRank = indexPath.row
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}
