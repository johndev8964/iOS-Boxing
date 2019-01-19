import SpriteKit


// MARK: -

class OpponentHealthBarNode: BKSpriteNode {
    private(set) var progress: Float = 0 {
        didSet {
            guard oldValue != progress else {
                return
            }
			
            if progress < 0 {
                progress = 0
            }
			
            if progress > 1 {
                progress = 1
            }
        }
    }
    private var maskSprite: BKSpriteNode!
	
    // MARK:
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
	
    required init() {
		guard let texture = GameImageCache.SharedInstance
            .getOpponentTexture(textureName: "health_bar.png") else {
            fatalError("Opponent texture not loaded.")
        }
		
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
		
        maskSprite = BKSpriteNode(imageNamed: "health_bar_mask.png")
		maskSprite.anchorPoint = CGPoint(x: 1, y: 0.5)
		maskSprite.position = CGPoint(x: maskSprite.size.width * 0.38, y: 0)
        maskSprite.zPosition = 1
        addChild(maskSprite)
    }
	
    // MARK:
	
    func setProgress(_ progress: Float, animated: Bool) {
        self.progress = progress
		
        let maskScale = 1 - self.progress
		
        if animated {
            let scaleAction = SKAction.scaleX(to: CGFloat(maskScale), duration: 0.3)
            maskSprite.run(scaleAction)
        }
        else {
            maskSprite.xScale = CGFloat(maskScale)
        }
    }
}
