//
//  NoteDetailViewController.swift
//  ConsolidationViii
//
//  Created by Jamie Brannan on 26/12/2021.
//

import UIKit

final class NoteDetailViewController: UIViewController, UITextViewDelegate {

  // MARK: - Properties
  @IBOutlet var textView: UITextView!
  var note: NotepadNote = NotepadNote(title: "", body: "")

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = note.title
    textView.text = note.body
  }
}
