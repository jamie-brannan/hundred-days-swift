//
//  Target.swift
//  ConsolidationVii
//
//  Created by Jamie Brannan on 20/07/2021.
//

import SpriteKit

struct Good {
  var name: String {
    let collection: [String] = ["ladybug", "butterfly"]
    return collection.randomElement()!
  }
}

//class Target: SKSpriteNode {
//  let goodItem = Good()
//
//  convenience init() {
//    self.init()
//    self.name = goodItem.name
//    self.position = CGPoint(x: 0, y: 0)
//  }
//}
