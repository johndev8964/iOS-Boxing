import SpriteKit


class ShaderManager {
    static let SharedInstance = ShaderManager()
	
    private(set) var playerTiredShader: SKShader?
    private(set) var playerWeakShader: SKShader?
    private(set) var playerLightHitShader: SKShader?
    private(set) var playerHeavyHitShader: SKShader?
    private(set) var playerBlockShader: SKShader?

    private(set) var opponentTiredShader: SKShader?
    private(set) var opponentWeakShader: SKShader?
    private(set) var opponentLightHitShader: SKShader?
    private(set) var opponentHeavyHitShader: SKShader?
    private(set) var opponentBlockShader: SKShader?

    // New Code Start
    // Shaders for touch pad
    private(set) var touchPadHitShader: [SKShader]?
    // New Code End
    
    // MARK:
	
    private init() {}
	
    // MARK:
	
    func preloadShaders() {
		if playerTiredShader == nil {
			playerTiredShader = SKShader(fileNamed: "OverlayOutline.fsh")
		}
		
		if playerWeakShader == nil {
			playerWeakShader = SKShader(fileNamed: "OverlayOutline.fsh")
		}
		
		if playerLightHitShader == nil {
			playerLightHitShader = SKShader(fileNamed: "OverlayOutline.fsh")
		}
		
		if playerHeavyHitShader == nil {
			playerHeavyHitShader = SKShader(fileNamed: "OverlayOutline.fsh")
		}
		
		if opponentTiredShader == nil {
			opponentTiredShader = SKShader(fileNamed: "OverlayOutline.fsh")
		}
		
		if opponentWeakShader == nil {
			opponentWeakShader = SKShader(fileNamed: "OverlayOutline.fsh")
		}
		
		if opponentLightHitShader == nil {
			opponentLightHitShader = SKShader(fileNamed: "OverlayOutline.fsh")
		}
		
		if opponentHeavyHitShader == nil {
			opponentHeavyHitShader = SKShader(fileNamed: "OverlayOutline.fsh")
		}
        
        // New Code Start
        if touchPadHitShader == nil {
            touchPadHitShader = [SKShader]()
            for _ in 0..<7 {
                touchPadHitShader?.append(SKShader(fileNamed: "OverlayOutline.fsh"))
            }
        }
        if playerBlockShader == nil {
            playerBlockShader = SKShader(fileNamed: "OverlayOutline.fsh")
        }
        if opponentBlockShader == nil {
            opponentBlockShader = SKShader(fileNamed: "OverlayOutline.fsh")
        }
       // New Code End
    }
	
    func updatePlayerShaders(texture: SKTexture) {
		updatePlayerTiredShader(texture: texture)
		updatePlayerWeakShader(texture: texture)
		updatePlayerLightHitShader(texture: texture)
		updatePlayerHeavyHitShader(texture: texture)
        updatePlayerBlockShader(texture: texture)
	}
	
	func updateOpponentShaders(texture: SKTexture) {
		updateOpponentTiredShader(texture: texture)
		updateOpponentWeakShader(texture: texture)
		updateOpponentLightHitShader(texture: texture)
		updateOpponentHeavyHitShader(texture: texture)
        updateOpponentBlockShader(texture: texture)
	}
	
	// MARK:
	
    private func updatePlayerTiredShader(texture: SKTexture) {
		let outlineWidth: CGFloat = 0.1
		let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
									  Float(outlineWidth / texture.size().height))
        let overlayColor = PlayerConfig.TiredOverlayColor
        let overlayStrength = PlayerConfig.TiredOverlayStrength
		let outlineColor = PlayerConfig.TiredOutlineColor
		
		playerTiredShader?.uniforms = [
			SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
		]
    }
	
    private func updatePlayerWeakShader(texture: SKTexture) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = PlayerConfig.WeakOverlayColor
        let overlayStrength = PlayerConfig.WeakOverlayStrength
        let outlineColor = PlayerConfig.WeakOutlineColor
        
        playerWeakShader?.uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }
	
    private func updatePlayerLightHitShader(texture: SKTexture) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = PlayerConfig.LightHitOverlayColor
        let overlayStrength = PlayerConfig.LightHitOverlayStrength
        let outlineColor = PlayerConfig.LightHitOutlineColor
        
        playerLightHitShader?.uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }
	
    private func updatePlayerHeavyHitShader(texture: SKTexture) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = PlayerConfig.HeavyHitOverlayColor
        let overlayStrength = PlayerConfig.HeavyHitOverlayStrength
        let outlineColor = PlayerConfig.HeavyHitOutlineColor
		
        playerHeavyHitShader?.uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }
	
    private func updateOpponentTiredShader(texture: SKTexture) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = OpponentConfig.TiredOverlayColor
        let overlayStrength = OpponentConfig.TiredOverlayStrength
        let outlineColor = OpponentConfig.TiredOutlineColor
        
        opponentTiredShader?.uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }
    
    private func updateOpponentWeakShader(texture: SKTexture) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = OpponentConfig.WeakOverlayColor
        let overlayStrength = OpponentConfig.WeakOverlayStrength
        let outlineColor = OpponentConfig.WeakOutlineColor
        
        opponentWeakShader?.uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }
    
    private func updateOpponentLightHitShader(texture: SKTexture) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = OpponentConfig.LightHitOverlayColor
        let overlayStrength = OpponentConfig.LightHitOverlayStrength
        let outlineColor = OpponentConfig.LightHitOutlineColor
        
        opponentLightHitShader?.uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }
	
    private func updateOpponentHeavyHitShader(texture: SKTexture) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = OpponentConfig.HeavyHitOverlayColor
        let overlayStrength = OpponentConfig.HeavyHitOverlayStrength
        let outlineColor = OpponentConfig.HeavyHitOutlineColor
		
        opponentHeavyHitShader?.uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }
    
    // New Code Start
    func updateTouchPadHitShader(area: RingTouchArea, texture: SKTexture, overlayColor: GLKVector4) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = overlayColor
        let overlayStrength = GameControlConfig.TouchPadOverlayStrength
        let outlineColor = overlayColor
        
        touchPadHitShader?[area.rawValue].uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }
    
    private func updatePlayerBlockShader(texture: SKTexture) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = PlayerConfig.BlockOverlayColor
        let overlayStrength = PlayerConfig.BlockOverlayStrength
        let outlineColor = PlayerConfig.BlockOutlineColor
        
        playerBlockShader?.uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }

    private func updateOpponentBlockShader(texture: SKTexture) {
        let outlineWidth: CGFloat = 0.1
        let stepSize = GLKVector2Make(Float(outlineWidth / texture.size().width),
                                      Float(outlineWidth / texture.size().height))
        let overlayColor = OpponentConfig.BlockOverlayColor
        let overlayStrength = OpponentConfig.BlockOverlayStrength
        let outlineColor = OpponentConfig.BlockOutlineColor
        
        opponentBlockShader?.uniforms = [
            SKUniform(name: "u_step_size", float: stepSize),
            SKUniform(name: "u_overlay_color", float: overlayColor),
            SKUniform(name: "u_overlay_strength", float: overlayStrength),
            SKUniform(name: "u_outline_color", float: outlineColor)
        ]
    }

    // New Code End

}
