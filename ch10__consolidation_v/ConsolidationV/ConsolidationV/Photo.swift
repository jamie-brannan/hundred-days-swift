//
//  Photo.swift
//  ConsolidationV
//
//  Created by Jamie Brannan on 11/03/2021.
//

import UIKit

class Photo: NSObject, Codable {
  
  var name: String
  var comment: String
  var image: String
  
  init(name: String, comment: String, image: String) {
    self.name = name
    self.comment = comment
    self.image = image
  }
}
