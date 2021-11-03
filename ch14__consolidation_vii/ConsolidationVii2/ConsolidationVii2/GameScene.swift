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
  var targetRotationDurations = [RowVerticalPosition: TimeInterval]()
  var gameTimer: Timer?
  var timeTimer: Timer?
  
  override func didMove(to view: SKView) {
    addBackground()
    // TODO: externalize in a function
    rows[.back] = addRow(at: CGPoint(x: -82, y: 350), zPosition: 0, xScale: 1, direction: .right)
    rows[.middle] = addRow(at: CGPoint(x: -82, y: 200), zPosition: 0.2, xScale: 0.75, direction: .left)
    rows[.front] = addRow(at: CGPoint(x: -82, y: 50), zPosition: 0.4, xScale: 0.5, direction: .right)
    targetRotationDurations[.back] = 4
    targetRotationDurations[.middle] = 5
    targetRotationDurations[.front] = 6
//    generateTargets()
    gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(generatePopulatedRows), userInfo: nil, repeats: true)
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

  private func addTargetToSceneRow(row: RowNode, scale: CGFloat, duration: TimeInterval, points: Int) {
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

    // TODO: Externalize if possible
    let moveAction = SKAction.move(by: CGVector(dx: movement, dy: 0), duration: duration)
    let removeAction = SKAction.customAction(withDuration: 1) { (target, _) in
        target.removeFromParent()
    }
    let sequence = SKAction.sequence([moveAction, removeAction])
    target.run(sequence)
  }

  @objc func generatePopulatedRows() {
    // 3/5 chances to generate a mosquito
    if Int.random(in: 1...5) <= 3 {
        addTargetToSceneRow(row: rows[.front]!, scale: 1, duration: targetRotationDurations[.back]!, points: 100)
    }
    if Int.random(in: 1...5) <= 3 {
        addTargetToSceneRow(row: rows[.middle]!, scale: 0.75, duration: targetRotationDurations[.middle]!, points: 200)

    }
    if Int.random(in: 1...5) <= 3 {
        addTargetToSceneRow(row: rows[.back]!, scale: 0.5, duration: targetRotationDurations[.front]!, points: 300)
    }
    
    targetRotationDurations[.back]! *= 0.996
    targetRotationDurations[.middle]! *= 0.996
    targetRotationDurations[.front]! *= 0.996
  }
}
