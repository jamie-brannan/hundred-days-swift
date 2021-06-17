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
  
  let possibleEnemies = ["ball", "hammer", "tv"]
  var enemiesKilledCounter = 0
  var timeInterval: Double = 1
  var isGameOver = false
  var gameTimer: Timer?
  
  // MARK: - Delegation
  override func didMove(to view: SKView) {
    backgroundColor = .black
    
    starfield = SKEmitterNode(fileNamed: "starfield")
    starfield.position = CGPoint(x: 1083, y: 452)
    starfield.advanceSimulationTime(10)
    addChild(starfield)
    starfield.zPosition = -1
    
    player = SKSpriteNode(imageNamed: "player")
    player.position = CGPoint(x: 56, y: 484)
    player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
    player.physicsBody?.contactTestBitMask = 1
    addChild(player)
    
    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.position = CGPoint(x: 60, y: 60)
    scoreLabel.horizontalAlignmentMode = .left
    addChild(scoreLabel)
    
    score = 0
    
    physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    physicsWorld.contactDelegate = self
    
    gameTimer?.invalidate()
    gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    var location = touch.location(in: self)
    
    if location.y < 100 {
      location.y = 100
    } else if location.y > 1024 {
      location.y = 1024
    }
    
    player.position = location
  }
  
  override func update(_ currentTime: TimeInterval) {
    for node in children {
      if node.position.x < -300 {
        node.removeFromParent()
      }
    }
    
    if !isGameOver {
      score += 1
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !isGameOver {
      gameOver()
      return
    }
  }
  
  // MARK: - Actions
  
  @objc func createEnemy() {
    guard !isGameOver else { return }
    enemiesKilledCounter += 1
    guard let enemy = possibleEnemies.randomElement() else { return }
    
    let sprite = SKSpriteNode(imageNamed: enemy)
    sprite.position = CGPoint(x: 1366, y: Int.random(in: 50...1024))
    addChild(sprite)
    
    sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
    sprite.physicsBody?.categoryBitMask = 1
    sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
    sprite.physicsBody?.angularVelocity = 5
    sprite.physicsBody?.linearDamping = 0
    sprite.physicsBody?.angularDamping = 0
    checkCountAgainstClock()
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    guard !isGameOver else { return }
    gameOver()
  }

  func checkCountAgainstClock() {
    guard enemiesKilledCounter >= 20 else { return }
    guard timeInterval > 0.2 else { return }
    timeInterval -= 0.1
    gameTimer?.invalidate()
    gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
  }

  
  func gameOver(){
    let explosion = SKEmitterNode(fileNamed: "explosion")!
    explosion.position = player.position
    addChild(explosion)
    player.removeFromParent()
    isGameOver = true
    gameTimer?.invalidate()
    return
  }
}
