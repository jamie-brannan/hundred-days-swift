//
//  ViewController.swift
//  Consolidation2
//
//  Created by Jamie Brannan on 20/08/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTitle()
  }

  private func setupTitle() {
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Consolidation II"
  }

}

