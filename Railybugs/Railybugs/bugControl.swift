//
//  bugControl.swift
//  Railybugs
//
//  Created by Rasmus on 2017-04-06.
//  Copyright © 2017 Rasmus. All rights reserved.
//

import Foundation

import SpriteKit

class BugControl: SKSpriteNode {
    
    private let minX: CGFloat = -300.0
    private let maxX: CGFloat = 300.0
    
    func spawnBug() -> SKSpriteNode {

            
        let item = SKSpriteNode(imageNamed:"bluebug-1.png")
        
        item.zPosition = 2
        item.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        item.setScale(0.2)
        item.physicsBody = SKPhysicsBody(circleOfRadius: item.size.height / 2)
        item.physicsBody?.isDynamic = true
        item.physicsBody?.restitution = 1.0
        item.physicsBody?.friction = 0.0
        item.physicsBody?.linearDamping = 0.0
        item.physicsBody?.mass = 0.0
        item.physicsBody?.charge = 0.0
        item.physicsBody?.density = 0.0
        item.physicsBody?.angularDamping = 0.0
        item.physicsBody?.allowsRotation = false
        item.physicsBody?.affectedByGravity = false
        item.physicsBody?.contactTestBitMask = 2
        item.name = "bluebug"
        
        let newTouple = spawnStartPosition()
        item.position = newTouple.newStart
        item.physicsBody?.velocity = newTouple.newVelocity
        
        return item
        }
}

func random(between first: CGFloat, and second: CGFloat) -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(first - second) + min(first, second)
}


func spawnStartPosition() -> (newStart: CGPoint, newVelocity: CGVector) {
    
    let randomNumber = arc4random() % 2 + 1
    let screenSize = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeigth = screenSize.height
    let offSet: CGFloat = 100
    
    let positionX: CGFloat
    let positionY: CGFloat
    var newStart = CGPoint()
    var newVector = CGVector()
    
    switch randomNumber {
        
    //Top
    case 1:
        positionX = random(between: -screenSize.width/2, and: screenSize.width/2)
        positionY = offSet + screenSize.height
        newStart = CGPoint(x: positionX, y: positionY)
        
        let firstRandomPoint = CGPoint(x: random(between: -screenWidth, and: -110), y: 0)
        let secondRandomPoint = CGPoint(x: random(between: 110, and: screenWidth), y: 0)
        
        //SMALLER CONSTANT => GREATER SPEED
        let speedScale: CGFloat = 5
        
        let firstVector = CGVector(dx: (firstRandomPoint.x - positionX)/speedScale, dy: (0 - positionY)/speedScale)
        let secondVector = CGVector(dx: (secondRandomPoint.x - positionX)/speedScale, dy: (0 - positionY)/speedScale)
        
        if random(between:0, and:1) < 0.5 {
            newVector = firstVector
        } else {
            newVector = secondVector
        }
        
        
    //Bottom
    case 2:
        positionX = random(between: -screenWidth/2, and: screenWidth/2)
        positionY = -offSet - screenHeigth
        newStart = CGPoint(x: positionX, y: positionY)
        
        let firstRandomPoint = CGPoint(x: random(between: -screenWidth, and: -110), y: 0)
        let secondRandomPoint = CGPoint(x: random(between: 110, and: screenWidth), y: 0)
        
        //SMALLER CONSTANT => GREATER SPEED
        let speedScale: CGFloat = 5
        
        let firstVector = CGVector(dx: (firstRandomPoint.x - positionX)/speedScale, dy: (0 - positionY)/speedScale)
        let secondVector = CGVector(dx: (secondRandomPoint.x - positionX)/speedScale, dy: (0 - positionY)/speedScale)
        
        if random(between:0, and:1) < 0.5 {
            newVector = firstVector
        } else {
            newVector = secondVector
        }
        
        
    //Left
    case 3:
        print("left")
        newStart = CGPoint(x: 0, y: 0)
        
        
    //Right
    case 4:
        print("right")
        newStart = CGPoint(x: 0, y: 0)
    default:
        break
    }
    return (newStart, newVector)
}
