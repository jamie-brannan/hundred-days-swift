//
//  ViewController.swift
//  Project1
//
//  Created by Jamie Brannan on 08/06/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var pictures = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    /// constant with datatype FileManager
    /// to examine the contents of a filesystem
    let fm = FileManager.default
    /// path of where our compiled program is
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

    for item in items {
        if item.hasPrefix("nssl") {
          /// this is a picture to load!
          pictures.append(item)
        }
    }
    /// print out array that's appended via the file managers path
    print(pictures)
  }

}

