import SpriteKit


// MARK: -

class ButtonNode: BKSpriteNode
{
    typealias ClickHandler = (_ sender: ButtonNode) -> Void
    
    public var clickHandler: ClickHandler?
    
    public private(set) var isHighlighted = false {
        didSet {
            guard oldValue != isHighlighted else {
                return
            }
            
            guard isEnabled else {
                return
            }
            
            removeAllActions()
            
            run(SKAction.colorize(with: AppConfig.ButtonHighlightedColor,
						  colorBlendFactor: isHighlighted ? AppConfig.ButtonHighlightedStrength : 0,
						  duration: 0.1))
        }
    }
    public var isEnabled = true {
        didSet {
            guard oldValue != isEnabled else {
                return
            }
            
            removeAllActions()
            
            color = AppConfig.ButtonDisabledColor
            colorBlendFactor = isEnabled ? 0 : AppConfig.ButtonDisabledStrength
        }
    }
    
    // MARK:
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        isUserInteractionEnabled = true
    }
    
    required init(imageNamed name: String) {
        let image = UIImage(named: name)
        let texture = SKTexture(image: image!)
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        isUserInteractionEnabled = true
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        isUserInteractionEnabled = true
    }
    
    // MARK:
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        isHighlighted = true
		
        AudioHelper.SharedInstance.playClickEffect()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        isHighlighted = containsTouches(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        isHighlighted = false
        
        if containsTouches(touches: touches) {
            clickHandler?(self)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        isHighlighted = false
    }
    
    // MARK:
    
    private func containsTouches(touches: Set<UITouch>) -> Bool {
        guard let scene = scene else {
            fatalError("ButtonNode must be used within a scene.")
        }
        
        return touches.contains {
            (touch) in
            
            let touchPoint = touch.location(in: scene)
            let touchedNode = scene.atPoint(touchPoint)
            
            return touchedNode === self || touchedNode.inParentHierarchy(self)
        }
    }
}
