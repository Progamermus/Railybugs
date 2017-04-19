//
//  GameScene.swift
//  Railybugs
//
//  Created by Rasmus on 2017-04-06.
//  Copyright © 2017 Rasmus. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var touchBool = false;
    
    var splinePoints = [CGPoint]()
    var activeDrawingLine: SKShapeNode?
    
    var background = SKSpriteNode(imageNamed: "background.png")
    var bugHole = SKSpriteNode(imageNamed: "bughole.png")
    private var bugControl = BugControl()
    
    var speedMultiplier: CGFloat = 2
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        setUpGame()
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(GameScene.spawnBugs), userInfo: nil, repeats: true)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        view.addGestureRecognizer(tap)
        

    }
    
    
    func setUpGame() {
        
        //BAKGRUND
        background.size.height = self.frame.height
        background.size.width = self.frame.width
        background.zPosition = 0
        self.addChild(background)
        
        
        //BUGHOLE
        bugHole.zPosition = 2
        bugHole.name = "bughole"
        bugHole.size = CGSize(width: 100, height: 100)
        
        bugHole.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        bugHole.physicsBody?.contactTestBitMask = 2
        bugHole.physicsBody?.isDynamic = false
        self.addChild(bugHole)
    }
    
    func spawnBugs() {
        self.scene?.addChild(bugControl.spawnBug())
    }
    
    
    func didTap(_ rec: UITapGestureRecognizer) {
        let viewTouchLocation = rec.location(in: self.view)
        guard let sceneTouchPoint = scene?.convertPoint(fromView: viewTouchLocation),
            let touchedNode = scene?.atPoint(sceneTouchPoint),
            touchedNode.name == "bluebug" else { return }
      print("rasmus hit a bluebug")
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        splinePoints.removeAll()
        
        let viewTouchLocation = touches.first!.location(in: self.view)
        
        
        
        if let sceneTouchPoint = scene?.convertPoint(fromView: viewTouchLocation),
            let touchedNode = scene?.atPoint(sceneTouchPoint),
            touchedNode.name == "bluebug" {
            touchBool = true;
            return
        }
        
        touchBool = false;
        
        guard let touch = touches.first else {
            return
        }
        
        splinePoints.append(touch.location(in: self))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        guard !touchBool else { return }
        
        guard let point = touches.first?.location(in: self) else { return }
        
        if let touchedNode = scene?.atPoint(point),
            touchedNode.name == "bluebug" {
            print("hanens")
            touchBool = true;
            splinePoints.removeAll()
            activeDrawingLine?.removeFromParent()
            return
        }
        
        if let lastPoint = splinePoints.last,
            point.distance(toPoint: lastPoint) < 1 {
            return
        }
        splinePoints.append(point)
        let newLine = SKShapeNode(splinePoints: &splinePoints, count: splinePoints.count)
        newLine.lineWidth = 5
        newLine.physicsBody = SKPhysicsBody(edgeChainFrom: newLine.path!)
        newLine.name = "Line"
        newLine.zPosition = 2
        newLine.strokeColor = .black
        activeDrawingLine?.removeFromParent()
        activeDrawingLine = newLine
        scene?.addChild(newLine)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "bluebug" && contact.bodyB.node?.name == "bughole" {
            contact.bodyA.node?.removeFromParent()
        } else if contact.bodyA.node?.name == "bughole" && contact.bodyB.node?.name == "bluebug" {
            contact.bodyB.node?.removeFromParent()
        }
    }

}




