//
//  GameScene.swift
//  Birds
//
//  Created by Kevin Amiranoff on 22/07/2018.
//  Copyright © 2018 Nemean Tale Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var mapNode = SKTileMapNode()
    let gameCamera = GameCamera();
    var panRecognizer = UIPanGestureRecognizer()
    var pinchRecognizer = UIPinchGestureRecognizer()
    var maxScale: CGFloat = 0

    override func didMove(to view: SKView) {

        setupLevel()
        setupGestureRecognizers();
    }


    func addCamera() -> Void {
        guard let view = view else {
            return
        }
        addChild(gameCamera)
        gameCamera.position = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 2);
        camera = gameCamera;
        gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
    }

    func setupGestureRecognizers() {
        guard let view = view else {
            return
        }

        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        view.addGestureRecognizer(panRecognizer);

        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        view.addGestureRecognizer(pinchRecognizer)
    }

    func setupLevel() {
        if let mapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode {
            self.mapNode = mapNode
            maxScale = mapNode.mapSize.width / frame.size.width
        }

        addCamera()
    }

}


extension GameScene {
    @objc func pan(sender: UIPanGestureRecognizer) {
        guard let view = view else {
            return
        }

        let translation = Helpers.multiplyCGPointWithFloat(point: sender.translation(in: view), float: gameCamera.yScale)
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y)
    }

    @objc func pinch(sender: UIPinchGestureRecognizer) {
        guard let view = view else {
            return
        }

        if sender.numberOfTouches == 2 {
            let locationInView = sender.location(in: view)
            let location = convertPoint(fromView: locationInView)
            if sender.state == .changed {
                let convertedScale = 1 / sender.scale
                let newScale = gameCamera.yScale * convertedScale // xScale or yScale.

                if newScale < maxScale && newScale > 0.5 {
                    gameCamera.setScale(newScale)
                }

                let locationAfterScale = convertPoint(fromView: locationInView)
                let locationDelta = CGPoint(x: location.x - locationAfterScale.x, y: location.y - locationAfterScale.y)
                let newPosition = CGPoint(x: gameCamera.position.x + locationDelta.x, y: gameCamera.position.y + locationDelta.y)
                gameCamera.position = newPosition
                sender.scale = 1.0
                gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
            }
        }
    }
}
