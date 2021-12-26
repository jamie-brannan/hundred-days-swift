//
//  LocalStorage.swift
//  ConsolidationViii
//
//  Created by Jamie Brannan on 26/12/2021.
//

import Foundation

class LocalStorage {
  static let notepadKey = "notepad"

  static func loadNotepadPages() -> [NotepadNote] {
    let defaults = UserDefaults.standard
    var notepad = [NotepadNote]()
    if let savedData = defaults.object(forKey: notepadKey) as? Data {
      let decoder = JSONDecoder()
      notepad = (try? decoder.decode([NotepadNote].self, from: savedData)) ?? notepad
    }
    return notepad
  }

  static func save(notepad: [NotepadNote]) {
    let encoder = JSONEncoder()
    if let saveData = try? encoder.encode(notepad) {
      let defaults = UserDefaults.standard
      defaults.set(saveData, forKey: notepadKey)
    }
  }
}
