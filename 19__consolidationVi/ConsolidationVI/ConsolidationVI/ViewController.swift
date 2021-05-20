//
//  ViewController.swift
//  ConsolidationVI
//
//  Created by Jamie Brannan on 20/05/2021.
//

import UIKit

class ViewController: UITableViewController {

  var countriesList = [Country]()

  override func viewDidLoad() {
    super.viewDidLoad()
    getListOfCountries()
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.title = "Countries"
  }

  func getListOfCountries() {
    guard let urlPath = Bundle.main.url(forResource: "countries", withExtension: "json") else { return }
    guard let data = try? Data(contentsOf: urlPath) else { return }
    parse(json: data)
  }

  func parse(json: Data) {
    do {
      let decoder = JSONDecoder()
      let decodedResults = try decoder.decode(Countries.self, from: json)
      self.countriesList = decodedResults.results
    } catch let error {
      print(error)
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countriesList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
    let country = countriesList[indexPath.row]
    cell.textLabel?.text = country.name
    cell.detailTextLabel?.text = country.motto
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = CountryDetailViewController()
    vc.country = countriesList[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }
}
