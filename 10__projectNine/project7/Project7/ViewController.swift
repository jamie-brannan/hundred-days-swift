//
//  ViewController.swift
//  Project7
//
//  Created by Jamie Brannan on 19/11/2020.
//

import UIKit

class TableViewController: UITableViewController {
  
  var petitions = [Petition]()
  var filteredPetitions = [Petition]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let urlString: String
    setupNavigation()
    if navigationController?.tabBarItem.tag == 0 {
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
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearFilteredTable))
    let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(getFilterQuery))
    let creditButton = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
    toolbarItems = [clearButton, spacer, filterButton]
    navigationItem.rightBarButtonItem = creditButton
    navigationController?.isToolbarHidden = false
  }
  
  func parse(json: Data) {
    let decoder = JSONDecoder()
    
    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
      petitions = jsonPetitions.results
      filteredPetitions = jsonPetitions.results
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
  
  @objc func getFilterQuery() {
    let ac = UIAlertController(title: "Filter", message: "What are you looking for?", preferredStyle: .alert)
    ac.addTextField()
    let submitAction = UIAlertAction(title: "Add", style: .default) {
          [weak self, weak ac] _ in
          guard let answer = ac?.textFields?[0].text else { return }
          self?.submitFilterQuery(answer)
        }
    ac.addAction(submitAction)
    present(ac, animated: true)
  }
  
  private func submitFilterQuery(_ answer: String) {
    DispatchQueue.global(qos: .userInteractive).async {
      self.filteredPetitions = self.petitions.filter {
        $0.body.contains(answer) || $0.title.contains(answer)
      }
    }
    tableView.reloadData()
  }
  
  @objc func clearFilteredTable() {
    filteredPetitions.removeAll(keepingCapacity: true)
    filteredPetitions = petitions
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredPetitions.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "thingy", for: indexPath)
    let petition = filteredPetitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.body
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = filteredPetitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }
}
