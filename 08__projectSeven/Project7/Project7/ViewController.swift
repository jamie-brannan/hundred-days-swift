//
//  ViewController.swift
//  Project7
//
//  Created by Jamie Brannan on 19/11/2020.
//

import UIKit

class TableViewController: UITableViewController {
  
  var petitions = [Petition]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    let urlString: String
    setupNavigation()
    if navigationController?.tabBarItem.tag == 0 {
        // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
    } else {
  
        urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
    }
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
    }
    showError()
  }
  
  func setupNavigation() {
    let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: nil)
    let creditButton = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
    navigationItem.leftBarButtonItem = clearButton
    navigationItem.rightBarButtonItem = creditButton
  }
  
  func parse(json: Data) {
    let decoder = JSONDecoder()
    
    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
      petitions = jsonPetitions.results
      tableView.reloadData()
    }
  }
  
  func showError() {
      let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
  }
  
  @objc func showCredits() {
    let ac = UIAlertController(title: "Credits", message: "The following data is provided by the We The People API of the Whitehouse", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return petitions.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "thingy", for: indexPath)
    let petition = petitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.body
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }
}
