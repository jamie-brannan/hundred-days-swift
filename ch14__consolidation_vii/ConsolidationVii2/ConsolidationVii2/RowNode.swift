//
//  Row.swift
//  ConsolidationVii2
//
//  Created by Jamie Brannan on 07/10/2021.
//

import SpriteKit

enum RowDirection {
  case right
  case left
}

enum RowVerticalPosition {
  case back
  case middle
  case front
}

class RowNode: SKNode {
  let rows = "wind"
  var direction: RowDirection = .left
  var childrenStartingPoint: CGFloat = -200
  var childMovement: CGFloat = 1400
  
  func configure(at position: CGPoint, xScale: CGFloat, direction: RowDirection) {
    self.position = position
    self.direction = direction
    childMovement = childMovement / xScale // movement depends on scale for prespective sake
    if direction == .left {
      childrenStartingPoint += childMovement
      childMovement = -childMovement
    }
    self.xScale = xScale
    self.yScale = 1
    self.isUserInteractionEnabled = false
  }

  func animate() {
      let rotateCW = SKAction.rotate(byAngle: CGFloat.pi / 128, duration: getDuration())
      let rotateCCW = SKAction.rotate(byAngle: CGFloat.pi / -128, duration: getDuration())
      let goDown = SKAction.moveBy(x: 0, y: -20, duration: getDuration())
      let goUp = SKAction.moveBy(x: 0, y: 20, duration: getDuration())
      let goLeft = SKAction.moveBy(x: -20, y: 0, duration: getDuration())
      let goRight = SKAction.moveBy(x: 20, y: 0, duration: getDuration())
      
      let sequence1 = SKAction.sequence([rotateCW, goDown, goLeft, rotateCCW, goUp, rotateCCW, goDown, goRight, rotateCW, goUp])
      let sequence2 = SKAction.sequence([rotateCCW, goUp, goRight, rotateCW, goDown, rotateCW, goUp, goLeft, rotateCCW, goDown])
      let forever = SKAction.repeatForever([sequence1, sequence2].randomElement()!)
      self.run(forever)
  }
  
  func getDuration() -> Double {
      return Double.random(in: 0.2...0.6)
  }
  // MARK: Props
//  let duration = Double.random(in: 0.2...0.6)
//  lazy var goLeft = SKAction.moveBy(x: -20, y: 0, duration: duration)
//  lazy var goRight = SKAction.moveBy(x: 20, y: 0, duration: duration)
//  lazy var sequenceLeft = SKAction.sequence([goLeft, goRight])
//  lazy var sequenceRight = SKAction.sequence([goRight, goLeft])

//  var direction : RowDirection = .right
//  var rowName: RowVerticalPosition = .top

}
