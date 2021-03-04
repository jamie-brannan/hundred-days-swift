//
//  ViewController.swift
//  Project10
//
//  Created by Jamie Brannan on 29/01/2021.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: - Properties
  
  var people = [Person]()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    let defaults = UserDefaults.standard

    if let savedPeople = defaults.object(forKey: "people") as? Data {
        let jsonDecoder = JSONDecoder()

        do {
            people = try jsonDecoder.decode([Person].self, from: savedPeople)
        } catch {
            print("Failed to load people")
        }
    }
  }
  
  @objc func addNewPerson() {
    let picker = UIImagePickerController()
    /// allows the user to crop the picture they select
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      return
    }
    picker.sourceType = .camera
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
  
  // MARK: - Data
  func save() {
      let jsonEncoder = JSONEncoder()
      if let savedData = try? jsonEncoder.encode(people) {
          let defaults = UserDefaults.standard
          defaults.set(savedData, forKey: "people")
      } else {
          print("Failed to save people.")
      }
  }
  
  // MARK: - Actions

  // MARK:  Navigation bar
  
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
    
    /// Create a person instance when image is found
    let person = Person(name: "Unknown", image: imageName)
    people.append(person)
    collectionView.reloadData()
    
    save()
    
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
    return people.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
      fatalError("Unable to dequeue PersonCell.")
    }
    
    let person = people[indexPath.item]
    
    cell.nameLabel.text = person.name
    
    let path = getDocumentsDirectory().appendingPathComponent(person.image)
    cell.imageView.image = UIImage(contentsOfFile: path.path)
    
    cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
    cell.imageView.layer.borderWidth = 2
    cell.imageView.layer.cornerRadius = 3
    cell.layer.cornerRadius = 7
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let person = people[indexPath.item]
    
    let ac = UIAlertController(title: "Edit Contact", message: "How would you like to modify this contact?", preferredStyle: .alert)
    
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    ac.addAction(UIAlertAction(title: "Rename", style: .default) { _ in
      let act = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
      act.addTextField()
      act.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak act] _ in
        guard let newName = act?.textFields?[0].text else { return }
        person.name = newName

        self?.collectionView.reloadData()
        self?.save()
      })
      self.present(act, animated: true)
    })
    
    ac.addAction(UIAlertAction(title: "Delete", style: .default) {_ in
      self.people.remove(at: indexPath.item)
      
      collectionView.reloadData()
    })
    
    present(ac, animated: true)
  }
}

