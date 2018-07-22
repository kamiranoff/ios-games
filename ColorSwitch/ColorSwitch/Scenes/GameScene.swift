//
//  GameScene.swift
//  ColorSwitch
//
//  Created by Kevin Amiranoff on 21/07/2018.
//  Copyright © 2018 Nemean Tale Studios. All rights reserved.
//

import SpriteKit

enum PlayerColors {
    static let colors = [
        UIColor(red: 231 / 255, green: 76 / 255, blue: 60 / 255, alpha: 1.0),
        UIColor(red: 241 / 255, green: 196 / 255, blue: 15 / 255, alpha: 1.0),
        UIColor(red: 46 / 255, green: 204 / 255, blue: 113 / 255, alpha: 1.0),
        UIColor(red: 52 / 255, green: 152 / 255, blue: 219 / 255, alpha: 1.0)
    ]
}

enum SwitchSate: Int {
    case red, yellow, green, blue
}


class GameScene: SKScene {

    var colorSwitch: SKSpriteNode!
    var switchState = SwitchSate.red
    var currentColorIndex: Int?

    let scoreLabel = SKLabelNode(text: "0")
    var score: Int = 0

    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0);
        physicsWorld.contactDelegate = self
    }

    override func didMove(to view: SKView) {
        layoutScene();
    }

    func showScore() {
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = UIColor.white;
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = ZPositions.score
        addChild(scoreLabel)
    }

    func updateScore() {
        score = Int(scoreLabel.text!)! + 1;
        scoreLabel.text = String(score)
    }

    func layoutScene() -> Void {
        setupPhysics();
        backgroundColor = UIColor(red: 44 / 255, green: 62 / 255, blue: 80 / 255, alpha: 1)
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle");
        let colorCircleSize = frame.size.width / 3
        colorSwitch.size = CGSize(width: colorCircleSize, height: colorCircleSize)
        colorSwitch.zPosition = ZPositions.colorSwitch
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.midY - colorSwitch.size.height);
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width / 2);
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory;
        colorSwitch.physicsBody?.isDynamic = false;
        addChild(colorSwitch);

        showScore()
        spawnBall()
    }

    func spawnBall() -> Void {

        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"),
                color: PlayerColors.colors[currentColorIndex!],
                size: CGSize(width: 30.0, height: 30.0)
        )
        ball.colorBlendFactor = 1;
        ball.name = "Ball"
        ball.zPosition = ZPositions.ball
        ball.position = CGPoint(x: frame.midX, y: frame.maxY);
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2);
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory;
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory;
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none;
        addChild(ball)
    }

    func turnColorSwitch() {
        if let newState = SwitchSate(rawValue: switchState.rawValue + 1) {
            switchState = newState
        } else {
            switchState = .red;
        }

        colorSwitch.run(SKAction.rotate(byAngle: .pi / 2, duration: 0.25))
    }

    func gameOver() {

        UserDefaults.standard.set(score, forKey: "RecentScore")
        if (score > UserDefaults.standard.integer(forKey: "HighScore")) {
            UserDefaults.standard.set(score, forKey: "HighScore")
        }

        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene, transition: SKTransition.fade(withDuration: 1.0))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnColorSwitch();
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {

        // bitwise operator will combine the bitmasks 01 and 10 to 11;
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask


        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if currentColorIndex == switchState.rawValue {
                    self.updateScore()
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                } else {
                    gameOver()
                }
            }
        }
    }
}
