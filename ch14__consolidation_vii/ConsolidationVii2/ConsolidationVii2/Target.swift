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
  static let goodGuys: [String] = ["ladybug", "butterfly"]
  static let badGuys: [String] = ["enemy"]
  var type: TargetType = .good
  
  func configure(at position: CGPoint, type: TargetType, points: Int, xScale: CGFloat, yScale: CGFloat) {
    self.position = position
    self.type = type
    switch type {
    case .good:
      let target = SKSpriteNode(imageNamed: TargetNode.goodGuys.randomElement()!)
      calibrate(the: target)
    case .bad:
      let target = SKSpriteNode(imageNamed: TargetNode.badGuys.randomElement()!)
      calibrate(the: target)
    }
    self.xScale = xScale
    self.yScale = yScale
  }

  func calibrate(the target: SKSpriteNode) {
    target.zPosition = 0.1
    target.position = CGPoint(x: 0, y: 100)
    addChild(target)
  }
}
