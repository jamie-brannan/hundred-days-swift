//
//  MainMenuTableViewController.swift
//  Project4
//
//  Created by Jamie Brannan on 08/10/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
  
  let websiteController = ViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Web Nav POC"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  // MARK: - Table view data source
  
  //    override func numberOfSections(in tableView: UITableView) -> Int {
  //        // #warning Incomplete implementation, return the number of sections
  //        return 0
  //    }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    let approvedCount = websiteController.approvedWebsites.count
    return approvedCount
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Configure the cell...
    let cell = tableView.dequeueReusableCell(withIdentifier: "startSiteCell", for: indexPath)
    cell.textLabel?.text = websiteController.approvedWebsites[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let webNavVc = storyboard?.instantiateViewController(identifier: "webNavigator") as? ViewController {
      webNavVc.selectedWebsite = websiteController.approvedWebsites[indexPath.row]
      navigationController?.pushViewController(webNavVc, animated: true)
    }
  }
}
