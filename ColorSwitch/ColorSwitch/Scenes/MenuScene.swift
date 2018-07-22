//
//  MenuScene.swift
//  ColorSwitch
//
//  Created by Kevin Amiranoff on 22/07/2018.
//  Copyright © 2018 Nemean Tale Studios. All rights reserved.
//

import SpriteKit


class MenuScene: SKScene {


    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44 / 255, green: 62 / 255, blue: 80 / 255, alpha: 1)
        addLogo()
        addLabels()
    }

    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "logo");
        let logoSize = frame.size.width / 3
        logo.size = CGSize(width: logoSize, height: logoSize)
        logo.position = CGPoint(x: frame.midX, y: frame.midY - logo.size.height);
        addChild(logo);
    }


    func addLabels() {
        let playLabel = SKLabelNode(text: "Play")
        let highScoreLabel = SKLabelNode(text: "HighScore: " + "\(UserDefaults.standard.integer(forKey: "HighScore"))")
        let recentScoreLabel = SKLabelNode(text: "Most recent score: " + "\(UserDefaults.standard.integer(forKey: "RecentScore"))")

        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 60.0
        playLabel.fontColor = UIColor.white;
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)


        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontSize = 30.0
        highScoreLabel.fontColor = UIColor.white;
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100.0)
        addChild(highScoreLabel)

        recentScoreLabel.fontName = "AvenirNext-Bold"
        recentScoreLabel.fontSize = 20.0
        recentScoreLabel.fontColor = UIColor.white;
        recentScoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 200.0)
        addChild(recentScoreLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene);
    }
}
