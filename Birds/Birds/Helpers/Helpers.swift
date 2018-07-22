//
//  Helpers.swift
//  Birds
//
//  Created by Kevin Amiranoff on 22/07/2018.
//  Copyright © 2018 Nemean Tale Studios. All rights reserved.
//

import Foundation
import SpriteKit

class Helpers {
    
    static func multiplyCGPointWithFloat(point:CGPoint, float:CGFloat) -> CGPoint {
        return CGPoint(x: point.x * float, y: point.y * float);
    }
}
