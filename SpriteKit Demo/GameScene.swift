//
//  GameScene.swift
//  SpriteKit Demo
//
//  Created by Kevin Amiranoff on 17/07/2018.
//  Copyright © 2018 Nemean Tale Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
//    let myFirstNode = SKNode();
//    let myFirstSpriteNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 200.0, height: 200.0));
//    let myFirstTextureNode = SKSpriteNode(imageNamed: "wolverine");
//    let blueBox = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 100.0, height: 100.0));
    
    let wolverineSprite = SKSpriteNode(imageNamed: "sprites0");
    var wolverineFrames = [SKTexture]();
    
    override func didMove(to view: SKView) {
        
        wolverineSprite.position = CGPoint(x: frame.midX, y: frame.midY);
        addChild(wolverineSprite);
        
        let textureAtlas = SKTextureAtlas(named: "Player Frames");
        for index in 0..<textureAtlas.textureNames.count {
            let textureName = "Sprites" + String(index);
            wolverineFrames.append(textureAtlas.textureNamed(textureName));
        }
//        addChild(myFirstNode);
//
//        myFirstSpriteNode.position = CGPoint(x: frame.midX, y: frame.midY)
//        myFirstSpriteNode.anchorPoint = CGPoint.zero
//        addChild(myFirstSpriteNode);
//
//        myFirstTextureNode.zPosition = 1;
//        myFirstTextureNode.size = CGSize(width: 100.0, height: 100.0);
//        myFirstSpriteNode.addChild(myFirstTextureNode);
//
//        blueBox.zPosition = 2;
//        blueBox.position = CGPoint(x: myFirstSpriteNode.size.width/2, y: myFirstSpriteNode.size.height/2)
//        myFirstSpriteNode.addChild(blueBox);
//
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame);
//        myFirstTextureNode.physicsBody = SKPhysicsBody(circleOfRadius: myFirstTextureNode.size.width/2);
//        myFirstTextureNode.physicsBody?.allowsRotation = true;
//        myFirstTextureNode.physicsBody?.restitution = 0.7;
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let animate = SKAction.animate(with: wolverineFrames, timePerFrame: 0.1);
        let forever = SKAction.repeatForever(animate);
        
        if let _ = wolverineSprite.action(forKey: "run") {
            wolverineSprite.removeAllActions();
        } else {
            wolverineSprite.run(forever, withKey: "run");

        }
        
    }

}
