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
  var currentNotepad = LocalStorage.loadNotepadPages()
  var notepadReferenceIndex: Int? {
    return currentNotepad.firstIndex(where: { $0.title == note.title })
  }
  var note: NotepadNote = NotepadNote(title: "", body: "")

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = note.title
    textView.text = note.body
    let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTouchTrashIcon))
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTouchSaveButton))
    navigationItem.rightBarButtonItems = [saveButton, deleteButton]
  }

  @objc func didTouchTrashIcon() {
    guard !isNewNote, let notepadReferenceIndex = currentNotepad.firstIndex(where: { $0.title == note.title }) else {
      self.navigationController?.popToRootViewController(animated: true)
      return
    }
    currentNotepad.remove(at: notepadReferenceIndex)
    LocalStorage.save(notepad: currentNotepad)
    self.navigationController?.popToRootViewController(animated: true)
  }

  @objc func didTouchSaveButton() {
    note.body = textView.text
    guard !isNewNote, let originalNoteIndex = notepadReferenceIndex else {
      currentNotepad.append(note)
      LocalStorage.save(notepad: currentNotepad)
      isNewNote = false
      return
    }
    currentNotepad[originalNoteIndex] = note
    LocalStorage.save(notepad: currentNotepad)
  }
}
