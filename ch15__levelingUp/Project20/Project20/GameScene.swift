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

  func createFirework(xMovement: CGFloat, x: Int, y: Int) {
      // 1
      let node = SKNode()
      node.position = CGPoint(x: x, y: y)

      // 2
      let firework = SKSpriteNode(imageNamed: "rocket")
      firework.colorBlendFactor = 1
      firework.name = "firework"
      node.addChild(firework)

      // 3
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

      // 4
      let path = UIBezierPath()
      path.move(to: .zero)
      path.addLine(to: CGPoint(x: xMovement, y: 1000))

      // 5
      let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
      node.run(move)

      // 6
      if let emitter = SKEmitterNode(fileNamed: "fuse") {
          emitter.position = CGPoint(x: 0, y: -22)
          node.addChild(emitter)
      }

      // 7
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
}
