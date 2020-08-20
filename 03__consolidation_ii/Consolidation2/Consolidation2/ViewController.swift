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

    /// constant with datatype FileManager
    /// to examine the contents of a filesystem
    let fm = FileManager.default

    /// path of where our compiled program is
    let path =  Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

//    for item in items {
//      if item.hasPrefix("flag") {
//        flags.append(item)
//      }
//    }

    for item in items {
      if item.hasSuffix("2x.png") {
        flags.append(item)
      }
    }

    print("Flags are : \(flags)")
  }

  private func setupTitle() {
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Consolidation II"
  }

  // MARK: - Table settings
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("number of flags is \(flags.count)")
    return flags.count
  }

}

