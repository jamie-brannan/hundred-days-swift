//
//  GameScene.swift
//  Project20
//
//  Created by Jamie Brannan on 14/11/2021.
//

import SpriteKit

class GameScene: SKScene {

  // MARK: - Properties
  var gameTimer: Timer?
  var fireworks = [SKNode]()

  let leftEdge = -22
  let bottomEdge = -22
  let rightEdge = 1024 + 22

  var score = 0 {
      didSet {
          // your code here
      }
  }

  // MARK: - Lifecycle
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

    gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
  }

  // MARK: - Fireworks
  func createFirework(xMovement: CGFloat, x: Int, y: Int) {
      // 1 – make node
      let node = SKNode()
      node.position = CGPoint(x: x, y: y)

      // 2 – get asset
      let firework = SKSpriteNode(imageNamed: "rocket")
      firework.colorBlendFactor = 1
      firework.name = "firework"
      node.addChild(firework)

      // 3 - set color
      switch Int.random(in: 0...2) {
      case 0:
          firework.color = .cyan

      case 1:
          firework.color = .green

      case 2:
          firework.color = .red

      default:
          break
      }

      // 4 - decide its parallel path
      let path = UIBezierPath()
      path.move(to: .zero)
      path.addLine(to: CGPoint(x: xMovement, y: 1000))

      // 5 - speed
      let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
      node.run(move)

      // 6 - add the fuse tail to the firework node itself at the bottom of it's own frame
      if let emitter = SKEmitterNode(fileNamed: "fuse") {
          emitter.position = CGPoint(x: 0, y: -22)
          node.addChild(emitter)
      }

      // 7 - add the firework to the creater set node and scene
      fireworks.append(node)
      addChild(node)
  }

  @objc func launchFireworks() {
      let movementAmount: CGFloat = 1800

      switch Int.random(in: 0...3) {
      case 0:
          // fire five, straight up
          createFirework(xMovement: 0, x: 512, y: bottomEdge)
          createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
          createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
          createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
          createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)

      case 1:
          // fire five, in a fan
          createFirework(xMovement: 0, x: 512, y: bottomEdge)
          createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
          createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
          createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
          createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)

      case 2:
          // fire five, from the left to the right
          createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
          createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
          createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
          createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
          createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)

      case 3:
          // fire five, from the right to the left
          createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
          createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
          createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
          createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
          createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)

      default:
          break
      }
  }

  // MARK: Explosions
  func explode(firework: SKNode) {
      if let emitter = SKEmitterNode(fileNamed: "explode") {
          emitter.position = firework.position
          addChild(emitter)
      }

      firework.removeFromParent()
  }

  func explodeFireworks() {
      var numExploded = 0

      for (index, fireworkContainer) in fireworks.enumerated().reversed() {
          guard let firework = fireworkContainer.children.first as? SKSpriteNode else { continue }

          if firework.name == "selected" {
              // destroy this firework!
              explode(firework: fireworkContainer)
              fireworks.remove(at: index)
              numExploded += 1
          }
      }

      switch numExploded {
      case 0:
          // nothing – rubbish!
          break
      case 1:
          score += 200
      case 2:
          score += 500
      case 3:
          score += 1500
      case 4:
          score += 2500
      default:
          score += 4000
      }
  }

  // MARK: - Touch handling

  func checkTouches(_ touches: Set<UITouch>) { /// Veriy touch corresponds with color group selected before adding change
    guard let touch = touches.first else { return }
    
    let location = touch.location(in: self)
    let nodesAtPoint = nodes(at: location) /// Returns an array of all visible descendants that intersect a point.
    
    // Must typecast for the loop cause otherwise we won't get a SKSpriteNode
    for case let node as SKSpriteNode in nodesAtPoint {
      guard node.name == "firework" else { continue }
      
      for parent in fireworks {
        guard let firework = parent.children.first as? SKSpriteNode else { continue } /// Notions of parent child already in `SKNode`
        
        if firework.name == "selected" && firework.color != node.color {
          firework.name = "firework"
          firework.colorBlendFactor = 1
        }
      }
      
      node.name = "selected"
      node.colorBlendFactor = 0
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    checkTouches(touches)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    checkTouches(touches)
  }

  override func update(_ currentTime: TimeInterval) {
    for (index, firework) in fireworks.enumerated().reversed() {
      if firework.position.y > 900 {
        fireworks.remove(at: index)
        firework.removeFromParent()
      }
    }
  }

}
