import SpriteKit


// MARK: -

class TimerBarNode: BKSpriteNode {
    weak var delegate: TimerBarDelegate?
    
    private var maskSprite: BKSpriteNode!
    
    // MARK:
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init() {
        // New Code Start
        // use image instead of imageNamed
        //let texture = SKTexture(imageNamed: "timer_bar.png")
        let image = UIImage(named: "timer_bar3.png")
        let texture = SKTexture(image: image!)
        // New Code End
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        maskSprite = BKSpriteNode(imageNamed: "timer_mask3.png")
        maskSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
        maskSprite.position = CGPoint(x: maskSprite.size.width * -0.5, y: 0)
        maskSprite.xScale = 1
        maskSprite.zPosition = 1
        addChild(maskSprite)
    }
    
    // MARK:
    
    func countdown(duration: TimeInterval) {
    	maskSprite.removeAllActions()
		
		maskSprite.xScale = 1
		
        let scaleAction = SKAction.scaleX(to: 0, duration: duration)
        maskSprite.run(scaleAction) {
            [weak self] in
            
            self?.delegate?.timerBarDidFinishCountdown(self!)
        }
    }
    
    func stopCountdown() {
        maskSprite.removeAllActions()
    }
}
