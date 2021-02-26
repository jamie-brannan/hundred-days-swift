//
//  ViewController.swift
//  Project1
//
//  Created by Jamie Brannan on 08/06/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  var pictures = [Picture]()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Storm Viewer by Jamie"
    navigationController?.navigationBar.prefersLargeTitles = true

    let fm = FileManager.default
    let path =  Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

    for item in items {
        if item.hasPrefix("nssl") {
          let picture = Picture(name: item, image: item, subtitle: "0 views", views: 0)
          pictures.append(picture)
        }
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return pictures.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row].name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
      vc.selectedImage = pictures[indexPath.row].image
      vc.pictureCount = pictures.count
      pictures[indexPath.row].views += 1
      vc.pictureViewCount = pictures[indexPath.row].views
      vc.selectedImageListOrderRank = indexPath.row
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}

