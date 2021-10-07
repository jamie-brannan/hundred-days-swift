//
//  Target.swift
//  ConsolidationVii2
//
//  Created by Jamie Brannan on 07/10/2021.
//

import SpriteKit

enum TargetType {
  case good
  case bad
}

class TargetNode: SKNode {
  static let collection: [String] = ["ladybug", "butterfly"]
  var type: TargetType = .good
  
  func configure(at position: CGPoint, type: TargetType, points: Int, xScale: CGFloat, yScale: CGFloat) {
    self.position = position
    self.type = type
    let target = SKSpriteNode(imageNamed: TargetNode.collection.randomElement()!)
    target.zPosition = 0.1
    target.position = CGPoint(x: 0, y: 100)
    addChild(target)
    self.xScale = xScale
    self.yScale = yScale
  }
}
