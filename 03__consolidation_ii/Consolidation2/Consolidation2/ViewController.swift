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

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
    let flagFileName = flags[indexPath.row]
    let cellTitle = flagFileName.replacingOccurrences(of: "@2x.png", with: "")
    cell.textLabel?.text = cellTitle.capitalizingFirstLetter()
    return cell
  }
}

extension String {
  // look into objective C for something to capitalize the first two letters / acronymn of country name
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
