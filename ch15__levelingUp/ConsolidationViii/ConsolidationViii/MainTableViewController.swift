//
//  MainTableViewController.swift
//  ConsolidationViii
//
//  Created by Jamie Brannan on 24/12/2021.
//

import UIKit

class MainTableViewController: UITableViewController {

  // MARK: - Properties
  var fakeData = [
    NotepadNote(title: "first", body: "fakenote"),
    NotepadNote(title: "second", body: "fakenote"),
    NotepadNote(title: "third", body: "fakenote"),
  ]

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Notepad"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNewNote))
  }

  // MARK: - Toolbar

  @objc func createNewNote() {
    print("✍🏻 trying to make a new note")
    let alertView = UIAlertController(title: "New", message: "Name your new notepage", preferredStyle: .alert)
    alertView.addTextField()
    let submitAction = UIAlertAction(title: "Draft", style: .default) { [unowned alertView] _ in
      let answer = alertView.textFields![0]
    }
    alertView.addAction(submitAction)
    alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(alertView, animated: true)
  }

  @objc func draftNewNoteInDetail() {
    print("✍🏻 opening new note detail")
  }

  // MARK: - Table View
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fakeData.count
  }

  // MARK: Table Cell Management
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let data = fakeData[indexPath.row]
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "note")
    cell.textLabel?.text = data.title
    cell.detailTextLabel?.text = data.body
    return cell
  }

  private func returnSubstituteCell() -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "note")
    cell.textLabel?.text = "tiiiiiiitle"
    cell.detailTextLabel?.text = "suuuuuuuuuubtitle"
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteDetailViewController")
    self.navigationController?.pushViewController(detailView, animated: true)
  }
}

