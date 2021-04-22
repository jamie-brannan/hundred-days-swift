//
//  WhackSlot.swift
//  Project14
//
//  Created by Jamie Brannan on 21/04/2021.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {

  func configure(at position: CGPoint) {
      self.position = position

      let sprite = SKSpriteNode(imageNamed: "whackHole")
      addChild(sprite)
  }
}
