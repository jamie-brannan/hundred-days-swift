//
//  GameScene.swift
//  ConsolidationVii
//
//  Created by Jamie Brannan on 05/07/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

  override func didMove(to view: SKView) {
    backgroundColor = .yellow
    addRow(at: CGPoint(x: frame.midX, y: frame.midY + frame.height/3 ), with: .cyan)
    addRow(at: CGPoint(x: frame.midX, y: frame.midY), with: .brown)
    addRow(at: CGPoint(x: frame.midX, y: frame.midY - frame.height/3 ), with: .cyan)
  }

  func addRow(at position: CGPoint, with color: UIColor) {
    let row = SKShapeNode(rectOf: CGSize(width: frame.width, height: (frame.height / 3)))
    row.position = position
    row.fillColor = color
    addChild(row)
  }
}
