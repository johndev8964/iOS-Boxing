import SpriteKit


// MARK: -

class OpponentPortraitNode: BKSpriteNode {

    // New Code Start
    private var opponentNumber: Int = 0
    // New Code End
    
    // MARK:
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
	
    required init(opponent: Int) {
        // New Code Start
        // use image instead of imageNamed
        opponentNumber = opponent
        let image = UIImage(named: "secret_\(opponent).png")
    	let texture = SKTexture(image: image!)
        // New Code End
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
	
    // MARK:
	
    func markDefeated() {
        // New Code Start
    	//let overlayColor = OpponentPortraitConfig.DefeatedOverlayColor
    	//let overlayStrength = OpponentPortraitConfig.DefeatedOverlayStrength
		
		//color = overlayColor
		//colorBlendFactor = overlayStrength
        self.texture = SKTexture(image: UIImage(named: "defeated_\(opponentNumber).png")!)
        // New Code End
		
//		flagSprite.color = overlayColor
//		flagSprite.colorBlendFactor = overlayStrength
	}
	
	func markNext() {
        // New Code Start
        self.texture = SKTexture(image: UIImage(named: "active_\(opponentNumber).png")!)
        // New Code End
        let overlayOneColor = OpponentPortraitConfig.NextOverlayOneColor
        let overlayOneStrength = OpponentPortraitConfig.NextOverlayOneStrength
        let overlayTwoColor = OpponentPortraitConfig.NextOverlayTwoColor
        let overlayTwoStrength = OpponentPortraitConfig.NextOverlayTwoStrength

        let colorizeAction = SKAction.colorize(with: overlayOneColor,
                colorBlendFactor: overlayOneStrength, duration: 0.3)
        let decolorizeAction = SKAction.colorize(with: overlayTwoColor,
                colorBlendFactor: overlayTwoStrength, duration: 0.3)

		run(SKAction.repeatForever(SKAction.sequence([colorizeAction, decolorizeAction])))
	
//		flagSprite.run(SKAction.repeatForever(SKAction.sequence([colorizeAction, decolorizeAction])))
	}
	
	func markSecret() {
        // New Code Start
		//let overlayColor = OpponentPortraitConfig.SecretOverlayColor
    	//let overlayStrength = OpponentPortraitConfig.SecretOverlayStrength
		
		//color = overlayColor
		//colorBlendFactor = overlayStrength
        self.texture = SKTexture(image: UIImage(named: "secret_\(opponentNumber).png")!)
        // New Code End

//		flagSprite.color = overlayColor
//		flagSprite.colorBlendFactor = overlayStrength
	}
}
