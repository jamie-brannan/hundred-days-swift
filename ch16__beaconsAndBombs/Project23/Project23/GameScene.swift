//
//  GameScene.swift
//  Project23
//
//  Created by Jamie Brannan on 31/07/2022.
//

import SpriteKit
import GameplayKit
import AVFoundation

enum ForceBomb {
  case never, always, random
}

class GameScene: SKScene {
  
  //  MARK: Properties
  
  var gameScore: SKLabelNode!
  var score = 0 {
    didSet {
      gameScore.text = "Score: \(score)"
    }
  }
  
  var livesImages = [SKSpriteNode]()
  var lives = 3
  
  var activeSliceBG: SKShapeNode!
  var activeSliceFG: SKShapeNode!
  var activeSlicePoints = [CGPoint]()
  
  var isSwooshSoundActive = false
  
  var activeEnemies = [SKSpriteNode]()
  
  var bombSoundEffect: AVAudioPlayer?
  
  //  MARK: HUD
  
  func createScore() {
    gameScore = SKLabelNode(fontNamed: "Chalkduster")
    gameScore.horizontalAlignmentMode = .left
    gameScore.fontSize = 48
    addChild(gameScore)
    
    gameScore.position = CGPoint(x: 8, y: 8)
    score = 0
  }
  
  /// Make game lives available for
  func createLives() {
    for i in 0 ..< 3 {
      let spriteNode = SKSpriteNode(imageNamed: "sliceLife")
      spriteNode.position = CGPoint(x: CGFloat(834 + (i * 70)), y: 720)
      addChild(spriteNode)
      
      livesImages.append(spriteNode)
    }
  }
  
  func createSlices() {
    activeSliceBG = SKShapeNode()
    activeSliceBG.zPosition = 2
    
    activeSliceFG = SKShapeNode()
    activeSliceFG.zPosition = 3
    
    activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
    activeSliceBG.lineWidth = 9
    
    activeSliceFG.strokeColor = UIColor.white
    activeSliceFG.lineWidth = 5
    
    addChild(activeSliceBG)
    addChild(activeSliceFG)
  }
  
  func createEnemy(forceBomb: ForceBomb = .random) {
    let enemy: SKSpriteNode
    
    var enemyType = Int.random(in: 0...6)
    
    if forceBomb == .never {
      enemyType = 1
    } else if forceBomb == .always {
      enemyType = 0
    }
    
    if enemyType == 0 {
      // 1 : Create a new SKSpriteNode that will hold the fuse and the bomb image as children, setting its Z position to be 1.
      enemy = SKSpriteNode()
      enemy.zPosition = 1
      enemy.name = "bombContainer"
      
      // 2 : Create the bomb image, name it "bomb", and add it to the container.
      let bombImage = SKSpriteNode(imageNamed: "sliceBomb")
      bombImage.name = "bomb"
      enemy.addChild(bombImage)
      
      // 3 : If the bomb fuse sound effect is playing, stop it and destroy it.
      if bombSoundEffect != nil {
        bombSoundEffect?.stop()
        bombSoundEffect = nil
      }
      
      // 4 : Create a new bomb fuse sound effect, then play it.
      if let path = Bundle.main.url(forResource: "sliceBombFuse", withExtension: "caf") {
        if let sound = try?  AVAudioPlayer(contentsOf: path) {
          bombSoundEffect = sound
          sound.play()
        }
      }
      
      // 5 : Create a particle emitter node, position it so that it's at the end of the bomb image's fuse, and add it to the container.
      if let emitter = SKEmitterNode(fileNamed: "sliceFuse") {
        emitter.position = CGPoint(x: 76, y: 64)
        enemy.addChild(emitter)
      }
    } else {
      enemy = SKSpriteNode(imageNamed: "penguin")
      run(SKAction.playSoundFileNamed("launch.caf", waitForCompletion: false))
      enemy.name = "enemy"
    }
    
    // 1 : Give the enemy a random position off the bottom edge of the screen.
    let randomPosition = CGPoint(x: Int.random(in: 64...960), y: -128)
    enemy.position = randomPosition
    
    // 2 : Create a random angular velocity, which is how fast something should spin.
    let randomAngularVelocity = CGFloat.random(in: -3...3 )
    let randomXVelocity: Int
    
    // 3 : Create a random X velocity (how far to move horizontally) that takes into account the enemy's position.
    if randomPosition.x < 256 {
      randomXVelocity = Int.random(in: 8...15)
    } else if randomPosition.x < 512 {
      randomXVelocity = Int.random(in: 3...5)
    } else if randomPosition.x < 768 {
      randomXVelocity = -Int.random(in: 3...5)
    } else {
      randomXVelocity = -Int.random(in: 8...15)
    }
    
    // 4 : Create a random Y velocity just to make things fly at different speeds.
    let randomYVelocity = Int.random(in: 24...32)
    
    // 5 : Give all enemies a circular physics body where the collisionBitMask is set to 0 so they don't collide.
    enemy.physicsBody = SKPhysicsBody(circleOfRadius: 64)
    enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * 40, dy: randomYVelocity * 40)
    enemy.physicsBody?.angularVelocity = randomAngularVelocity
    enemy.physicsBody?.collisionBitMask = 0
    
    addChild(enemy)
    activeEnemies.append(enemy)
  }
  
  //  MARK: Mechanics
  
  /// Animated drawn FruitNinja like slice path
  func redrawActiveSlice() {
    // 1 : If we have fewer than two points in our array, we don't have enough data to draw a line so it needs to clear the shapes and exit the method.
    if activeSlicePoints.count < 2 {
      activeSliceBG.path = nil
      activeSliceFG.path = nil
      return
    }
    
    // 2 : If we have more than 12 slice points in our array, we need to remove the oldest ones until we have at most 12 – this stops the swipe shapes from becoming too long.
    if activeSlicePoints.count > 12 {
      activeSlicePoints.removeFirst(activeSlicePoints.count - 12)
    }
    
    // 3 : It needs to start its line at the position of the first swipe point, then go through each of the others drawing lines to each point.
    let path = UIBezierPath()
    path.move(to: activeSlicePoints[0])
    
    for i in 1 ..< activeSlicePoints.count {
      path.addLine(to: activeSlicePoints[i])
    }
    
    // 4 : Finally, it needs to update the slice shape paths so they get drawn using their designs – i.e., line width and color.
    activeSliceBG.path = path.cgPath
    activeSliceFG.path = path.cgPath
  }
  
  func playSwooshSound() {
    isSwooshSoundActive = true
    
    let randomNumber = Int.random(in: 1...3)
    let soundName = "swoosh\(randomNumber).caf"
    
    let swooshSound = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
    
    run(swooshSound) { [weak self] in
      self?.isSwooshSoundActive = false
    }
  }
  
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "sliceBackground")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)
    
    physicsWorld.gravity = CGVector(dx: 0, dy: -6)
    physicsWorld.speed = 0.85
    
    //    createScore()
    createLives()
    createSlices()
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    activeSlicePoints.append(location)
    redrawActiveSlice()
    if !isSwooshSoundActive {
      playSwooshSound()
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    activeSliceBG.run(SKAction.fadeOut(withDuration: 0.25))
    activeSliceFG.run(SKAction.fadeOut(withDuration: 0.25))
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    
    // 1 : Remove all existing points in the activeSlicePoints array, because we're starting fresh.
    activeSlicePoints.removeAll(keepingCapacity: true)
    
    // 2 : Get the touch location and add it to the activeSlicePoints array.
    let location = touch.location(in: self)
    activeSlicePoints.append(location)
    
    // 3 : Call the (as yet unwritten) redrawActiveSlice() method to clear the slice shapes.
    redrawActiveSlice()
    
    // 4 : Remove any actions that are currently attached to the slice shapes. This will be important if they are in the middle of a fadeOut(withDuration:) action.
    activeSliceBG.removeAllActions()
    activeSliceFG.removeAllActions()
    
    // 5 : Set both slice shapes to have an alpha value of 1 so they are fully visible.
    activeSliceBG.alpha = 1
    activeSliceFG.alpha = 1
  }
  
  override func update(_ currentTime: TimeInterval) {
    var bombCount = 0
    
    for node in activeEnemies {
      if node.name == "bombContainer" {
        bombCount += 1
        break
      }
    }
    
    if bombCount == 0 {
      // no bombs – stop the fuse sound!
      bombSoundEffect?.stop()
      bombSoundEffect = nil
    }
  }
}
