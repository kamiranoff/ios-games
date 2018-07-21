//
//  GameScene.swift
//  SpriteKit Demo
//
//  Created by Kevin Amiranoff on 17/07/2018.
//  Copyright © 2018 Nemean Tale Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let wolverineSprite = SKSpriteNode(imageNamed: "sprites0");
    var wolverineFrames = [SKTexture]();
    
    override func didMove(to view: SKView) {
        
        wolverineSprite.position = CGPoint(x: frame.midX, y: frame.midY);
        wolverineSprite.zPosition = 10;
        addChild(wolverineSprite);
        
        let textureAtlas = SKTextureAtlas(named: "Player Frames");
        for index in 0..<textureAtlas.textureNames.count {
            let textureName = "Sprites" + String(index);
            wolverineFrames.append(textureAtlas.textureNamed(textureName));
        }
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
