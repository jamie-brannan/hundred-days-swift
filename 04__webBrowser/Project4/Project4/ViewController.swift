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
  var progressView: UIProgressView!
  var approvedWebsites = ["apple.com", "hackingwithswift.com", "francetvinfo.fr"]
  var selectedWebsite: String?
  
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupWebView(with: selectedWebsite ?? "francetvinfo.fr")
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    createToolbar()
  }
  
  // MARK: -Toolbar configuration
  private func setupWebView(with selected: String) {
    let url = URL(string: "https://" + selected)!
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true
  }
  
  private func createToolbar() {
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(webView.goBack))
    let forward = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(webView.goForward))

    progressView = UIProgressView(progressViewStyle: .default)
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView)
    
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    
    toolbarItems = [back, forward, spacer, progressButton, spacer, refresh]
    navigationController?.isToolbarHidden = false
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
  
  // MARK: - WebView Navigation
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url
    
    if let host = url?.host {
      for website in approvedWebsites {
        if host.contains(website) {
          decisionHandler(.allow)
          return
        }
      }
      siteDeniedAlert(for: host)
    }
    
    decisionHandler(.cancel)
  }

  func siteDeniedAlert(for host: String) {
    let ac = UIAlertController(title: "Sorry", message: "\(host) site is not currently approved", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(ac, animated: true)
  }

  @objc func openTapped() {
    let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
    
    for website in approvedWebsites {
      ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
    }
    
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    present(ac, animated: true)
  }
  
  func openPage(action: UIAlertAction) {
    let url = URL(string: "https://" + action.title!)!
    webView.load(URLRequest(url: url))
  }
  
  // MARK: - Custom Callbacks
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }
}

