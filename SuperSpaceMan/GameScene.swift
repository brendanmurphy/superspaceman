//
//  GameScene.swift
//  SuperSpaceMan
//
//  Created by brendan on 9/8/15.
//  Copyright (c) 2015 AppArmy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var backgroundNode: SKSpriteNode?
    var playerNode: SKSpriteNode?
    var orbNode: SKSpriteNode?
    
    let CollisionCategoryPlayer:        UInt32 = 0x1 << 1
    let CollisionCategoryPowerUpOrbs:   UInt32 = 0x1 << 2
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        physicsWorld.contactDelegate = self
        
        // set world's gravity
        physicsWorld.gravity = CGVectorMake(0.0, -2.0)
        
        // set bg color
        backgroundColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        userInteractionEnabled = true
        
        // add bg
        backgroundNode = SKSpriteNode(imageNamed: "Background")
        backgroundNode!.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        backgroundNode!.position = CGPoint(x: size.width/2.0, y: 0.0)
        
        addChild(backgroundNode!)
        
        // player node
        playerNode = SKSpriteNode(imageNamed: "Player")
        
        // add physics body to player
        playerNode!.physicsBody = SKPhysicsBody(circleOfRadius: playerNode!.size.width/2)
        playerNode!.physicsBody!.dynamic = true
        playerNode!.physicsBody!.linearDamping = 1.0
        playerNode!.physicsBody!.allowsRotation = false
        playerNode!.position = CGPoint(x: self.size.width/2.0, y: 80)
        
        // collisions
        playerNode!.physicsBody!.categoryBitMask = CollisionCategoryPlayer
        playerNode!.physicsBody!.contactTestBitMask = CollisionCategoryPowerUpOrbs
        playerNode!.physicsBody!.collisionBitMask  = 0
        
        addChild(playerNode!)

        // orb node
        orbNode = SKSpriteNode(imageNamed: "PowerUp")
        orbNode!.position = CGPoint(x: size.width/2 - 20, y: size.height - 25)
        orbNode!.physicsBody = SKPhysicsBody(circleOfRadius: orbNode!.size.width/2)
        orbNode!.physicsBody!.dynamic = false
        
        // collisions
        orbNode!.physicsBody!.categoryBitMask = CollisionCategoryPowerUpOrbs
        orbNode!.physicsBody!.collisionBitMask = 0
       
        addChild(orbNode!)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        playerNode!.physicsBody!.applyImpulse(CGVectorMake(0.0, 40.0))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        print("there has been contact: \(contact)")
    }
    
    
}


//class GameScene: SKScene {
//    override func didMoveToView(view: SKView) {
//        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
//    }
//    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        /* Called when a touch begins */
//        
//        for touch in (touches as! Set<UITouch>) {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
//    }
//   
//    override func update(currentTime: CFTimeInterval) {
//        /* Called before each frame is rendered */
//    }
//}
