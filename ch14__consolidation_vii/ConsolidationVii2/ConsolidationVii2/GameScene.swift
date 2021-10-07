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
  var durations = [RowDirection: TimeInterval]()
  
  override func didMove(to view: SKView) {
    addBackground()
    rows[.back] = addRow(at: CGPoint(x: -82, y: 350), zPosition: 0, xScale: 1, direction: .right)
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
