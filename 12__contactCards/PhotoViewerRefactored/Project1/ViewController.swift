//
//  ViewController.swift
//  Project1
//
//  Created by Jamie Brannan on 08/06/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

  var pictures = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    /// A library var that we are renaming here
    title = "Storm Viewer by Jamie"

    /// Enable large titles across our app
    navigationController?.navigationBar.prefersLargeTitles = true

    /// constant with datatype FileManager
    /// to examine the contents of a filesystem
    let fm = FileManager.default

    /// path of where our compiled program is
    let path =  Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

    for item in items {
        if item.hasPrefix("nssl") {
          /// this is a picture to load!
          pictures.append(item)
        }
    }
    /// print out array that's appended via the file managers path
    print("Unsorted pictures are: \(pictures)")
    pictures.sort()
    print("Sorted pictures are now:\(pictures)")
  }

  /// the number of cells will be the number of items in `pictures`

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pictures.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    /// only cells on screen are the only ones that  exist, so reuse what leave screen when scrolling
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath)
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as? PictureCell else {
      fatalError("Unable to dequeue PersonCell.")
    }
    /// if there's text, add it (but `optional` hence the `textLabel?` :)
    cell.textLabel?.text = pictures[indexPath.row]
    cell.layer.backgroundColor = UIColor(white: 0, alpha: 0.3).cgColor
    cell.layer.cornerRadius = 8
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    /**
     Type casting is done
     */
    if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
      vc.selectedImage = pictures[indexPath.row]
      /// additional dated needed in the `DetailViewController.swift`
      vc.pictureCount = pictures.count
      vc.selectedImageListOrderRank = indexPath.row
      navigationController?.pushViewController(vc, animated: true)
    }
  }

//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return pictures.count
//  }
//
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    /// only cells on screen are the only ones that  exist, so reuse what leave screen when scrolling
//    let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath)
//    /// if there's text, add it (but `optional` hence the `textLabel?` :)
//    cell.textLabel?.text = pictures[indexPath.row]
//    return cell
//  }
//  
//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    /**
//     Type casting is done
//     */
//    if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
//      vc.selectedImage = pictures[indexPath.row]
//      /// additional dated needed in the `DetailViewController.swift`
//      vc.pictureCount = pictures.count
//      vc.selectedImageListOrderRank = indexPath.row
//      navigationController?.pushViewController(vc, animated: true)
//    }
//  }
}

