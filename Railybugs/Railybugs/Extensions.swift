//
//  Extensions.swift
//  Railybugs
//
//  Created by Rasmus on 2017-04-14.
//  Copyright © 2017 Rasmus. All rights reserved.
//

import Foundation
import CoreGraphics


extension CGPoint {
    
    func distance(toPoint p:CGPoint) -> CGFloat {
        return sqrt(pow((p.x - x), 2) + pow((p.y - y), 2))
    }
}
