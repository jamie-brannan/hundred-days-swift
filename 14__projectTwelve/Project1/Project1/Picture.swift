//
//  Picture.swift
//  Project1
//
//  Created by Jamie Brannan on 26/02/2021.
//  Copyright © 2021 Jamie Brannan. All rights reserved.
//

import UIKit

class Picture: NSObject, Codable {
  var name: String
  var image: String
  var subtitle: String
  var views: Int {
    didSet {
      subtitle = "\(views) views"
    }
  }
  
  init(name: String, image: String, subtitle: String, views: Int) {
    self.name = name
    self.image = image
    self.subtitle = subtitle
    self.views = views
  }
}
