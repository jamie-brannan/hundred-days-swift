//
//  ViewController.swift
//  Project10
//
//  Created by Jamie Brannan on 29/01/2021.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

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

