//
//  GameScene.swift
//  Project14
//
//  Created by Jamie Brannan on 11/04/2021.
//

import SpriteKit

class GameScene: SKScene {
  // MARK: - Properties
  var gameScore: SKLabelNode!
  var score = 0 {
    didSet {
      gameScore.text = "Score: \(score)"
    }
  }
  
  // MARK: – Call backs
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "whackBackground")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)
    
    gameScore = SKLabelNode(fontNamed: "Chalkduster")
    gameScore.text = "Score: 0"
    gameScore.position = CGPoint(x: 8, y: 8)
    gameScore.horizontalAlignmentMode = .left
    gameScore.fontSize = 48
    addChild(gameScore)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
}
