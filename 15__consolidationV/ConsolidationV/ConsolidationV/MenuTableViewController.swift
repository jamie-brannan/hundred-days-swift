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
    // TODO: - add a add button
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
    // TODO: - ask for name and a description of the photo just taken
  }
  
  func getDocumentsDirectory() -> URL {
    /// our way of asking Apple for the directory
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  // MARK: - Callbacks
  
  // MARK: Imagepicker
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    /// try to read the image, and typecast it as an image for the interface – and  if it's not `guard` will let us bail out
    guard let photo = info[.editedImage] as? UIImage else { return }
    
    /// stringify the id name
    let photoId = UUID().uuidString
    /// read out documents directory wherever it is secretly on the device
    let photoPath = getDocumentsDirectory().appendingPathComponent(photoId)
    
    /// `compressionQuality` is a value between 0 and 1, one being highest
    if let jpegData = photo.jpegData(compressionQuality: 0.8) {
      try? jpegData.write(to: photoPath)
    }
    
    // TODO: - Find a way to have alerts pop up so you can fill out name and comment right away?
    
    /// Create a person instance when image is found
    let galleryItem = Photo(name: "Unknown", comment: "Unknown", image: photoId)
    galleryItems.append(galleryItem)
    tableView.reloadData()
    
    /// when we're done, dismiss this vc away
    dismiss(animated: true)
  }
  
  // MARK: - Table view
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return galleryItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath) as? MenuItemTableViewCell else {
      fatalError("[MainTableView] – Unable to deque Photo cell")
    }
    let galleryItem = galleryItems[indexPath.item]
    cell.titleLabel.text = galleryItem.name
    cell.subtitleLabel.text = galleryItem.comment
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let galleryItem = galleryItems[indexPath.item]
    let ac = UIAlertController(title: "Labeling", message: "What would you like to call your photo?", preferredStyle: .alert)
    ac.addTextField() { (textField) in
      textField.placeholder = "Name photo"
    }
    ac.addTextField() { (textField) in
      textField.placeholder = "Caption your photo"
    }
    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
      guard let newName = ac?.textFields?[0].text, newName != "" else { return }
      guard let newComment = ac?.textFields?[1].text, newComment != "" else { return }
      galleryItem.name = newName
      galleryItem.comment = newComment
      
      self?.tableView.reloadData()
    })
    self.present(ac, animated: true)
  }
}
