//
//  GameScene.swift
//  ConsolidationVii
//
//  Created by Jamie Brannan on 05/07/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

//  var topRow = SKShapeNode(rect: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3))
  var topRow = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 3)))

  override func didMove(to view: SKView) {
//    backgroundColor = .yellow
    topRow.fillColor = .blue
    topRow.position = CGPoint(x: 10, y: 10)
  }
}
