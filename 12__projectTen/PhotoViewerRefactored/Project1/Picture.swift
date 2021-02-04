//
//  Picture.swift
//  Project1
//
//  Created by Jamie Brannan on 04/02/2021.
//  Copyright © 2021 Jamie Brannan. All rights reserved.
//

import UIKit

class Picture: NSObject {
  var name: String
  var image: String

  init(name: String, image: String) {
      self.name = name
      self.image = image
  }
}
