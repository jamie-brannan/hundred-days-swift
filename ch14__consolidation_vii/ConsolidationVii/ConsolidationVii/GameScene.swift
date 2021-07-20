//
//  GameScene.swift
//  ConsolidationVii
//
//  Created by Jamie Brannan on 05/07/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {


  override func didMove(to view: SKView) {
    backgroundColor = .yellow
    let rowSize = CGSize(width: frame.width, height: frame.height/3)
    let topRow = Row(direction: .left, fill: .cyan, size: rowSize, point: CGPoint(x: frame.midX, y: frame.midY + frame.height/3 ), named: .top)
    let middleRow = Row(direction: .right, fill: .brown, size: rowSize, point: CGPoint(x: frame.midX, y: frame.midY), named: .middle)
    let bottomRow = Row(direction: .right, fill: .cyan, size: rowSize, point: CGPoint(x: frame.midX, y: frame.midY - frame.height/3 ), named: .bottom)
    addChild(topRow)
    addChild(middleRow)
    addChild(bottomRow)
  }
}
