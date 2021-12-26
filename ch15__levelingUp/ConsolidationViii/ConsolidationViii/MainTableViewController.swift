//
//  MainTableViewController.swift
//  ConsolidationViii
//
//  Created by Jamie Brannan on 24/12/2021.
//

import UIKit

class MainTableViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Notepad"
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UITableViewCell(style: .subtitle, reuseIdentifier: "note")
    cell.textLabel?.text = "tiiiiiiitle"
    cell.detailTextLabel?.text = "suuuuuuuuuubtitle"
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteDetailViewController")
    self.navigationController?.pushViewController(detailView, animated: true)
  }
}

