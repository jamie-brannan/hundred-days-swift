//
//  ViewController.swift
//  Project10
//
//  Created by Jamie Brannan on 29/01/2021.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
  }

  @objc func addNewPerson() {
      let picker = UIImagePickerController()
    /// allows the user to crop the picture they select
      picker.allowsEditing = true
      picker.delegate = self
      present(picker, animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      /// try to read the image, and typecast it as an image for the interface – and  if it's not `guard` will let us bail out
      guard let image = info[.editedImage] as? UIImage else { return }

      /// stringify the id name?
      let imageName = UUID().uuidString
      /// read out documents directory wherever it is secretly on the device
      let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

      /// `compressionQuality` is a value between 0 and 1, one being highest
      if let jpegData = image.jpegData(compressionQuality: 0.8) {
          try? jpegData.write(to: imagePath)
      }

      /// when we're done, dismiss this vc away
      dismiss(animated: true)
  }

  func getDocumentsDirectory() -> URL {
    /// our way of asking Apple for the directory
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      return paths[0]
  }

  // MARK: - Callbacks

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 10
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
          // we failed to get a PersonCell – bail out!
          fatalError("Unable to dequeue PersonCell.")
      }

      // if we're still here it means we got a PersonCell, so we can return it
      return cell
  }
}

