//
//  DetailViewController.swift
//  Project7
//
//  Created by Jamie Brannan on 26/11/2020.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
