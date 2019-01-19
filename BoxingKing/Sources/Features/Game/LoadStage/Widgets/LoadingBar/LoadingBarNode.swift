import SpriteKit


// MARK: -

class LoadingBarNode: BKSpriteNode {
    private(set) var progress: Float = 0 {
        didSet {
            guard oldValue != progress else {
                return
            }
            
            if progress < 0 {
                progress = 0
            }
            else if progress > 1 {
                progress = 1
            }
        }
    }
    private var barSprite: BKSpriteNode!
    
    // MARK:
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(size: CGSize) {
        super.init(texture: nil, color: AppConfig.LoadingBackgroundColor, size: size)
        
        barSprite = BKSpriteNode(color: AppConfig.LoadingBarColor, size: size)
        barSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
        barSprite.position = CGPoint(x: size.width * -0.5, y: 0)
        barSprite.zPosition = 1
        addChild(barSprite)
        
        barSprite.xScale = 0
    }
    
    // MARK:
    
    func setProgress(_ progress: Float, animated: Bool) {
        self.progress = progress
        
        if animated {
            let scaleAction = SKAction.scaleX(to: CGFloat(self.progress), duration: 0.3)
            barSprite.run(scaleAction)
        }
        else {
            barSprite.xScale = CGFloat(self.progress)
        }
    }
}
