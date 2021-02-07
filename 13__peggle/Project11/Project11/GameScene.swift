//
//  GameScene.swift
//  Project11
//
//  Created by Jamie Brannan on 07/02/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
      let background = SKSpriteNode(imageNamed: "background.jpg")
      background.position = CGPoint(x: 512, y: 384)
      background.blendMode = .replace
      background.zPosition = -1
      addChild(background)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
