//
//  GameScene.swift
//  ConsolidationVii2
//
//  Created by Jamie Brannan on 07/10/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  var rows = [RowVerticalPosition: RowNode]()
  var durations = [RowVerticalPosition: TimeInterval]()
  
  override func didMove(to view: SKView) {
    addBackground()
    rows[.back] = addRow(at: CGPoint(x: -82, y: 350), zPosition: 0, xScale: 1, direction: .right)
    rows[.middle] = addRow(at: CGPoint(x: -82, y: 200), zPosition: 0.2, xScale: 0.75, direction: .left)
    rows[.front] = addRow(at: CGPoint(x: -82, y: 50), zPosition: 0.4, xScale: 0.5, direction: .right)
    durations[.back] = 4
    durations[.middle] = 5
    durations[.front] = 6
    generateTargets()
  }
  
  private func addBackground() {
    let background = SKSpriteNode(imageNamed: "whackBackground")
    background.position = CGPoint(x: 512, y: 384)
    background.zPosition = -1
    background.blendMode = .replace
    addChild(background)
  }

  private func addRow(at position: CGPoint, zPosition: CGFloat, xScale: CGFloat, direction: RowDirection) -> RowNode {
    let row = RowNode()
    row.configure(at: position, xScale: xScale, direction: direction)
    row.zPosition = zPosition
    addChild(row)
    row.animate()
    return row
  }

  private func addTarget(row: RowNode, scale: CGFloat, duration: TimeInterval, points: Int) {
    let target = TargetNode()
    let targetType: TargetType
    if Int.random(in: 1...5) <= 4 {
      targetType = .good
    } else {
      targetType = .bad
    }
    // target will be child of the row, compensate for row scale
    var xScale = scale * (1/row.xScale)
    let yScale = scale
    
    let startingPoint: CGFloat = row.childrenStartingPoint
    let movement: CGFloat = row.childMovement
 
    if row.direction == .right { // reverse direct its facing if its other direction
      xScale = -xScale
    }
    
    let position = CGPoint(x: startingPoint, y: 100)
    target.configure(at: position, type: targetType, points: 1, xScale: xScale, yScale: yScale
    )
    
    target.zPosition = -0.1
    target.name = "target"
    row.addChild(target)
    
    let moveAction = SKAction.move(by: CGVector(dx: movement, dy: 0), duration: duration)
    let removeAction = SKAction.customAction(withDuration: 1) { (target, _) in
        target.removeFromParent()
    }
    let sequence = SKAction.sequence([moveAction, removeAction])
    target.run(sequence)
  }

  func generateTargets() {
    // 3/5 chances to generate a duck
    if Int.random(in: 1...5) <= 3 {
        addTarget(row: rows[.front]!, scale: 1, duration: durations[.back]!, points: 100)
    }
    if Int.random(in: 1...5) <= 3 {
        addTarget(row: rows[.middle]!, scale: 0.75, duration: durations[.middle]!, points: 200)

    }
    if Int.random(in: 1...5) <= 3 {
        addTarget(row: rows[.back]!, scale: 0.5, duration: durations[.front]!, points: 300)
    }
    
    durations[.back]! *= 0.996
    durations[.middle]! *= 0.996
    durations[.front]! *= 0.996
  }
  //    func touchDown(atPoint pos : CGPoint) {
  //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
  //            n.position = pos
  //            n.strokeColor = SKColor.green
  //            self.addChild(n)
  //        }
  //    }
  //
  //    func touchMoved(toPoint pos : CGPoint) {
  //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
  //            n.position = pos
  //            n.strokeColor = SKColor.blue
  //            self.addChild(n)
  //        }
  //    }
  //
  //    func touchUp(atPoint pos : CGPoint) {
  //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
  //            n.position = pos
  //            n.strokeColor = SKColor.red
  //            self.addChild(n)
  //        }
  //    }
  //
  //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  //        if let label = self.label {
  //            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
  //        }
  //
  //        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
  //    }
  //
  //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
  //        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
  //    }
  //
  //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
  //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  //    }
  //
  //    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
  //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  //    }
  //
  //
  //    override func update(_ currentTime: TimeInterval) {
  //        // Called before each frame is rendered
  //    }
}
