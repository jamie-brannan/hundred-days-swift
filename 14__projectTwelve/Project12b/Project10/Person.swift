//
//  Person.swift
//  Project10
//
//  Created by Jamie Brannan on 31/01/2021.
//

import UIKit

class Person: NSObject {
  var name: String
  var image: String
  
  /// initalize the class
  init(name: String, image: String) {
      self.name = name
      self.image = image
  }
}
