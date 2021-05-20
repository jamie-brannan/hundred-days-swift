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
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailCell")
    if let country = country {
      self.navigationItem.title = country.name
    }
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
    guard let motto = country?.motto, let language = country?.language, let capital = country?.capital else { return cell }
    cell.textLabel?.text = "\(motto), \(language), \(capital)"
    return cell
  }
}
