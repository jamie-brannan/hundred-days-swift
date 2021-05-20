//
//  CountryDetailViewController.swift
//  ConsolidationVI
//
//  Created by Jamie Brannan on 20/05/2021.
//

import Foundation
import UIKit

class CountryDetailViewController: UITableViewController {
  
  var country: Country? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let country = country {
      self.navigationItem.title = country.name
    }
  }
}
