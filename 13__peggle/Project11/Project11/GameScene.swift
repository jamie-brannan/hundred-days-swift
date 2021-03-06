//
//  GameScene.swift
//  Project11
//
//  Created by Jamie Brannan on 07/02/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  // MARK:- Properties
  
  var scoreLabel: SKLabelNode!
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }

  var remainingBallsLabel: SKLabelNode!
  let ballColors = ["Blue", "Cyan", "Green", "Grey", "Purple", "Red", "Yellow"]
  var remainingBalls = 5 {
      didSet {
          remainingBallsLabel.text = "Balls: \(remainingBalls)"
      }
  }

  var editLabel: SKLabelNode!
  
  var editingMode: Bool = false {
    didSet {
      if editingMode {
        editLabel.text = "Done"
      } else {
        editLabel.text = "Edit"
      }
    }
  }
  
  // MARK: - Lifecycle
  
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background.jpg")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)
    
    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.text = "Score: 0"
    scoreLabel.horizontalAlignmentMode = .right
    scoreLabel.position = CGPoint(x: 512, y: 700)
    addChild(scoreLabel)
    
    remainingBallsLabel = SKLabelNode(fontNamed: "Chalkduster")
    remainingBallsLabel.text = "Balls: \(remainingBalls)"
    remainingBallsLabel.horizontalAlignmentMode = .right
    remainingBallsLabel.position = CGPoint(x: 980, y: 700)
    addChild(remainingBallsLabel)
    
    editLabel = SKLabelNode(fontNamed: "Chalkduster")
    editLabel.text = "Edit"
    editLabel.position = CGPoint(x: 80, y: 700)
    addChild(editLabel)
    
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    physicsWorld.contactDelegate = self
    
    makeBouncer(at: CGPoint(x: 0, y: 0))
    makeBouncer(at: CGPoint(x: 256, y: 0))
    makeBouncer(at: CGPoint(x: 512, y: 0))
    makeBouncer(at: CGPoint(x: 768, y: 0))
    makeBouncer(at: CGPoint(x: 1024, y: 0))
    
    makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
    makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
    makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
    makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
    
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }
    
    if nodeA.name == "ball" {
        collisionBetween(ball: nodeA, object: nodeB)
    }
    else if nodeB.name == "ball" {
        collisionBetween(ball: nodeB, object: nodeA)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    let objects = nodes(at: location)
    
    if objects.contains(editLabel) {
      editingMode.toggle()
    } else {
      if editingMode {
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
        let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = location

        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false
        box.name = "box"
        addChild(box)
      } else {
        let ball = SKSpriteNode(imageNamed: "ball\(ballColors.randomElement()!)")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.restitution = 0.4
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.position = CGPoint(x: location.x, y: 700)
        ball.name = "ball"
        addChild(ball)        }
    }
  }
  
  // MARK: - Setup UI
  func makeBouncer(at position: CGPoint) {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = position
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
    bouncer.physicsBody?.isDynamic = false
    addChild(bouncer)
  }
  
  func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode
    var slotGlow: SKSpriteNode
    
    if isGood {
      slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
      slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
      slotBase.name = "good"
    } else {
      slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
      slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
      slotBase.name = "bad"
    }
    
    slotBase.position = position
    slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
    slotBase.physicsBody?.isDynamic = false
    slotGlow.position = position
    
    addChild(slotBase)
    addChild(slotGlow)
    
    let spin = SKAction.rotate(byAngle: .pi, duration: 10)
    let spinForever = SKAction.repeatForever(spin)
    slotGlow.run(spinForever)
  }
  
  func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
      destroy(node: ball)
      if (remainingBalls < 5) && (scoreLabel.text != "DEFEAT") {
        remainingBalls += 1
      }
      score += 1
      checkGameProgress()
    } else if object.name == "bad" {
      destroy(node: ball)
      if (remainingBalls >= 0) && (scoreLabel.text != "DEFEAT") {
        remainingBalls -= 1
      }
      score -= 1
      checkGameProgress()
    } else if object.name == "box" {
      destroy(node: object)
    }
  }
  
  func destroy(node: SKNode) {
    if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
      fireParticles.position = node.position
      addChild(fireParticles)
    }
    node.removeFromParent()
  }

  func checkGameProgress() {
    if remainingBalls == 0 {
      scoreLabel.fontColor = .systemPink
      scoreLabel.text = "DEFEAT"
    }
  }
}
