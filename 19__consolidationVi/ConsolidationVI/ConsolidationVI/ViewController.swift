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
}
