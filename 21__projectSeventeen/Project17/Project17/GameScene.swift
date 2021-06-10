//
//  GameScene.swift
//  Project17
//
//  Created by Jamie Brannan on 27/05/2021.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var starfield: SKEmitterNode!
  var player: SKSpriteNode!
  
  var scoreLabel: SKLabelNode!
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  // MARK: - Delegation
  override func didMove(to view: SKView) {
    backgroundColor = .black
    
    starfield = SKEmitterNode(fileNamed: "starfield")!
    starfield.position = CGPoint(x: 1024, y: 584)
    starfield.advanceSimulationTime(10)
    addChild(starfield)
    starfield.zPosition = -1
    
    player = SKSpriteNode(imageNamed: "player")
    player.position = CGPoint(x: 100, y: 584)
    player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
    player.physicsBody?.contactTestBitMask = 1
    addChild(player)
    
    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.position = CGPoint(x: 16, y: 16)
    scoreLabel.horizontalAlignmentMode = .left
    addChild(scoreLabel)
    
    score = 0
    
    physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    physicsWorld.contactDelegate = self
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
}
