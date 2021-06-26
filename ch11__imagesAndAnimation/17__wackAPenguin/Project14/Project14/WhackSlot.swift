//
//  WhackSlot.swift
//  Project14
//
//  Created by Jamie Brannan on 21/04/2021.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {
  var charNode: SKSpriteNode!
  var isVisible = false
  var isHit = false
  
//  enum PenguinDirection {
//    case up
//    case down
//  }
  
  func emitSmoke() {
    if let smoke = SKEmitterNode(fileNamed: "Smoke") {
      smoke.position = CGPoint(x: 0, y: 45)
      smoke.zPosition = 1
      smoke.numParticlesToEmit = 10
      smoke.particleLifetime = 0.75
      smoke.particleColor = SKColor.white
      smoke.particleAlpha = 0.2
      effectElement(node: smoke)
    }
  }
  
  func emitMud() {
    if let mud = SKEmitterNode(fileNamed: "Mud") {
      effectElement(node: mud)
    }
  }
  
  func effectElement(node: SKEmitterNode) {
    // use a sequence to remove the node after the effect ends
    let action = SKAction.run { [weak self] in
      self?.addChild(node)
    }
    let duration = SKAction.wait(forDuration: 1)
    let removal = SKAction.run { [weak self] in
      self?.removeChildren(in: [node])
    }
    run(SKAction.sequence([action, duration, removal]))
  }
  
  func configure(at position: CGPoint) {
    self.position = position
    
    let sprite = SKSpriteNode(imageNamed: "whackHole")
    addChild(sprite)
    
    let cropNode = SKCropNode()
    cropNode.position = CGPoint(x: 0, y: 15)
    cropNode.zPosition = 1
    cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
    
    charNode = SKSpriteNode(imageNamed: "penguinGood")
    charNode.position = CGPoint(x: 0, y: -90)
    charNode.name = "character"
    cropNode.addChild(charNode)
    
    addChild(cropNode)
  }
  
  func show(hideTime: Double) {
    if isVisible { return }
    emitMud()
    charNode.xScale = 1
    charNode.yScale = 1
    
    charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
    isVisible = true
    isHit = false
    
    if Int.random(in: 0...2) == 0 {
      charNode.texture = SKTexture(imageNamed: "penguinGood")
      charNode.name = "charFriend"
    } else {
      charNode.texture = SKTexture(imageNamed: "penguinEvil")
      charNode.name = "charEnemy"
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
      self?.hide()
    }
  }
  
  func hide() {
    if !isVisible { return }
    emitMud()
    charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
    isVisible = false
  }
  
  func hit() {
    isHit = true
    emitSmoke()
    let delay = SKAction.wait(forDuration: 0.25)
    let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
    let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
    charNode.run(SKAction.sequence([delay, hide, notVisible]))
  }
}
