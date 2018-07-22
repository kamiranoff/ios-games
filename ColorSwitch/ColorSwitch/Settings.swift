//
//  Settings.swift
//  ColorSwitch
//
//  Created by Kevin Amiranoff on 21/07/2018.
//  Copyright © 2018 Nemean Tale Studios. All rights reserved.
//

import SpriteKit


enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1;          //01
    static let switchCategory: UInt32 = 0x1 << 1;   //10

}


enum ZPositions {
    static let score: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}