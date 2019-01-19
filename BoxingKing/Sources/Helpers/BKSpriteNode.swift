//
//  BKSpriteNode.swift
//  BoxingKing
//
//  Copyright © 2018 ifunco. All rights reserved.
//

import SpriteKit

class BKSpriteNode: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        texture?.filteringMode = AppConfig.AntiAliasingEnabled ? .linear : .nearest
    }
    
    override var texture: SKTexture? {
        didSet {
            texture?.filteringMode = AppConfig.AntiAliasingEnabled ? .linear : .nearest
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


