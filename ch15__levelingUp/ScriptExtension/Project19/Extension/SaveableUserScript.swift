//
//  SaveableUserScript.swift
//  Extension
//
//  Created by Jamie Brannan on 12/11/2021.
//

import Foundation

class SavableUserScript: Codable {
  var associatedUrl: String
  var name: String
  var script: String

  init(associatedUrl: String, name: String, script: String) {
    self.associatedUrl = associatedUrl
    self.name = name
    self.script = script
  }
}
