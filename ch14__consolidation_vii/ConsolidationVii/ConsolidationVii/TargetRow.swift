//
//  RowNode.swift
//  ConsolidationVii
//
//  Created by Jamie Brannan on 08/07/2021.
//

import SpriteKit

enum FlowDirection {
  case right
  case left
}

enum VerticalPosition {
  case top
  case middle
  case bottom
}

class TargetRow: SKShapeNode {
  
  // MARK: Props
  let duration = Double.random(in: 0.2...0.6)
  lazy var goLeft = SKAction.moveBy(x: -20, y: 0, duration: duration)
  lazy var goRight = SKAction.moveBy(x: 20, y: 0, duration: duration)
  lazy var sequenceLeft = SKAction.sequence([goLeft, goRight])
  lazy var sequenceRight = SKAction.sequence([goRight, goLeft])

  var direction : FlowDirection = .right
  var rowName: VerticalPosition = .top

  // MARK: Configuration
  convenience init(direction: FlowDirection, fill: UIColor, size:CGSize, point: CGPoint, named name: VerticalPosition) {
    self.init(rectOf: size)
    self.direction = direction
    self.fillColor = fill
    self.position = point
    self.name = "\(name)Row"
  }

  override init() {
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func animate() {
    switch direction {
    case .right:
      let forever = SKAction.repeatForever(sequenceRight)
      self.run(forever)
    default:
      let forever = SKAction.repeatForever(sequenceLeft)
      self.run(forever)
    }
  }
}
