//
//  ViewController.swift
//  Project4
//
//  Created by Jamie Brannan on 24/09/2020.
//  Copyright © 2020 Jamie Brannan. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

  var webView: WKWebView!

  override func loadView() {
      webView = WKWebView()
      webView.navigationDelegate = self
      view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupWebView()
  }

  private func setupWebView() {
    let url = URL(string: "https://www.hackingwithswift.com")!
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true
  }
}

