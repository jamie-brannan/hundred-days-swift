//
//  NoteDetailViewController.swift
//  ConsolidationViii
//
//  Created by Jamie Brannan on 26/12/2021.
//

import UIKit

final class NoteDetailViewController: UIViewController, UITextViewDelegate {

  @IBOutlet var textView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "NoteDetail"
  }
}
