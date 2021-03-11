//
//  MenuTableViewController.swift
//  ConsolidationV
//
//  Created by Jamie Brannan on 11/03/2021.
//

import Foundation
import UIKit

class MenuTableViewController: UITableViewController {
 
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNavigationBar()
  }
  
  func setUpNavigationBar() {
    title = "Photo Gallery"
    guard let nav = navigationController else { return }
    nav.navigationBar.prefersLargeTitles = true
    navigationItem.prompt = "100 Days of Swift"
    // TODO: - add a add button
    let addNavButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(addNewPhoto))
    navigationItem.rightBarButtonItems = [addNavButton]
  }

  @objc func addNewPhoto() {
    // TODO: - demande use of the camera
    // TODO: - ask for name and a description of the photo just taken
  }
}
