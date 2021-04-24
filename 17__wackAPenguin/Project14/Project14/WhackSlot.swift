//
//  WhackSlot.swift
//  Project14
//
//  Created by Jamie Brannan on 21/04/2021.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {
  var charNode: SKSpriteNode!
  func configure(at position: CGPoint) {
    self.position = position

    let sprite = SKSpriteNode(imageNamed: "whackHole")
    addChild(sprite)

    let cropNode = SKCropNode()
    cropNode.position = CGPoint(x: 0, y: 15)
    cropNode.zPosition = 1
    cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")

    charNode = SKSpriteNode(imageNamed: "penguinGood")
    charNode.position = CGPoint(x: 0, y: -90)
    charNode.name = "character"
    cropNode.addChild(charNode)

    addChild(cropNode)
  }
  
}
