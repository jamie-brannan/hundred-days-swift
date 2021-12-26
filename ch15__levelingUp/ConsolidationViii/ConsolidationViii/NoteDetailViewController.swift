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
  var isNewNote = true
  var note: NotepadNote = NotepadNote(title: "", body: "")

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = note.title
    textView.text = note.body
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveManually))
  }

  @objc func saveManually() {
    var currentNotepad = LocalStorage.loadNotepadPages()
    note.body = textView.text
    guard !isNewNote else {
      currentNotepad.append(note)
      LocalStorage.save(notepad: currentNotepad)
      return
    }
    if let notepadReferenceIndex = currentNotepad.firstIndex(where: { $0.title == note.title }) {
      currentNotepad[notepadReferenceIndex] = note
    }
    LocalStorage.save(notepad: currentNotepad)
  }
}
