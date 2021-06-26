//
//  CityWikiDetailViewController.swift
//  Project16
//
//  Created by Jamie Brannan on 26/05/2021.
//

import UIKit
import WebKit

class CityWikiDetailViewController: UIViewController {
  
  let webView = WKWebView()
  var capital: Capital?
  
  override func loadView() {
      self.view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let capital = capital?.title else { return }
    let urlString = "https://en.wikipedia.org/wiki/\(capital)"
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
}
