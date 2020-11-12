//
//  ViewController.swift
//  ShoppingList
//
//  Created by Jamie Brannan on 10/11/2020.
//

import UIKit
import Foundation

class ViewController: UITableViewController {

  var items = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    reloadList()
    setupToolbar()
  }

  private func setupToolbar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Shopping List"

    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
    let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearList))
    let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    toolbarItems = [clearButton, spacer, shareButton, addButton]
    navigationController?.isToolbarHidden = false
  }
  private func reloadList() {
    tableView.reloadData()
  }

  @objc private func clearList() {
    items.removeAll(keepingCapacity: true)
    reloadList()
  }

  @objc private func promptForItem(){
    let ac = UIAlertController(title: "What do you need at the store?", message: nil, preferredStyle: .alert)
    ac.addTextField()
    let submitAction = UIAlertAction(title: "Add", style: .default) {
      [weak self, weak ac] _ in
      guard let answer = ac?.textFields?[0].text else { return }
      self?.submit(answer)
    }
    ac.addAction(submitAction)
    present(ac, animated: true)
  }

  private func submit(_ answer: String) {
    items.insert(answer, at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }

  @objc func shareTapped() {
    let list = items.joined(separator: "\n")
    let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
    present(vc, animated: true)
//      guard let image = flagImage.image?.jpegData(compressionQuality: 0.8), let imageName = selectedImage else {
//          print("No image found")
//          return
//      }
//
//      let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
//      vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//      present(vc, animated: true)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
}

