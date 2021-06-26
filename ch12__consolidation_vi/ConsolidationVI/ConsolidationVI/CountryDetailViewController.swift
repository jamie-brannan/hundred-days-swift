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
  var sectionTitles = ["Motto", "Language", "Capital"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailCell")
    if let country = country {
      self.navigationItem.title = country.name
    }
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
  }

  @objc func shareTapped() {
    guard let country = country else { return }
    let countryText = "Checkout \(country.name) : \(country.motto) in the country app!"
    let vc = UIActivityViewController(activityItems: [countryText], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return sectionTitles.count
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionTitles[section]
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
    switch indexPath.section {
    case 0:
      guard let motto = country?.motto else {
        return cell
      }
      cell.textLabel?.text = motto
      return cell
    case 1:
      guard let language = country?.language else {
        return cell
      }
      cell.textLabel?.text = language
      return cell
    case 2:
      guard let capital = country?.capital else {
        return cell
      }
      cell.textLabel?.text = capital
      return cell
    default:
      cell.textLabel?.text = ""
      return cell
    }
  }
}
