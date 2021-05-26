//
//  Capital.swift
//  Project16
//
//  Created by Jamie Brannan on 25/05/2021.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
  var title: String?
  var coordinate: CLLocationCoordinate2D
  var info: String
//  var wiki: String
  
  init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
    self.title = title
    self.coordinate = coordinate
    self.info = info
//    self.wiki
  }
}
