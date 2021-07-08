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
    var topRow = SKShapeNode(rectOf: CGSize(width: size.width, height: (size.height / 3)))
    topRow.fillColor = .blue
    topRow.position = CGPoint(x: size.width/2, y: size.height)
    addChild(topRow)
  }
}
