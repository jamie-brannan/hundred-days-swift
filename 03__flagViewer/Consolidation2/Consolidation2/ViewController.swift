//
//  ViewController.swift
//  Consolidation2
//
//  Created by Jamie Brannan on 20/08/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  /// empty array to store flags in
  var flags = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTitle()
    loadContents()
  }

  private func setupTitle() {
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Consolidation II"
  }

  private func loadContents() {
    /// constant with datatype FileManager
    /// to examine the contents of a filesystem
    let fm = FileManager.default

    /// path of where our compiled program is
    let path =  Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)
    
    /// add an item is the suffix matches an end
    for item in items {
      if item.hasSuffix("2x.png") {
        flags.append(item)
      }
    }
  }

  // MARK: - Table settings
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return flags.count
  }

    /// view the table at cell row
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
    /// get file name
    let flagFileName = flags[indexPath.row]
    /// title the cell with the file name minus the end of the name
    let cellTitle = flagFileName.replacingOccurrences(of: "@2x.png", with: "")
    /// if the cell title has two letters, it's an acronym that needs to be capitalized
    if cellTitle.count == 2 {
        cell.textLabel?.text = cellTitle.uppercased()
    } else {
        cell.textLabel?.text = cellTitle.capitalizingFirstLetter()
    }
    return cell
  }
    
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
      vc.selectedImage = flags[indexPath.row]
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}

extension String {
  /// look into objective C for something to capitalize the first two letters / acronymn of country name
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
