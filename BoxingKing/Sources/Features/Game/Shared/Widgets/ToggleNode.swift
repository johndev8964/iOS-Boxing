import SpriteKit


// MARK: -

class ToggleNode: BKSpriteNode
{
    typealias ToggleHandler = (_ sender: ToggleNode) -> Void
    
    public var toggleHandler: ToggleHandler?
    
    public var selectedIndex = 0 {
        didSet {
            guard oldValue != selectedIndex else {
                return
            }
            
            texture = selectedIndex == 0 ? firstTexture : secondTexture
        }
    }
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
    private var firstTexture: SKTexture!
    private var secondTexture: SKTexture!
    
    // MARK:
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        isUserInteractionEnabled = true
    }
    
    required init(firstImageName: String, secondImageName: String) {
        // New Code Start
        // use image instead of imageNamed
//        firstTexture = SKTexture(imageNamed: firstImageName)
//        secondTexture = SKTexture(imageNamed: secondImageName)
        let firstImage = UIImage(named: firstImageName)
        let secondImage = UIImage(named: secondImageName)
        firstTexture = SKTexture(image: firstImage!)
        secondTexture = SKTexture(image: secondImage!)
        
        // New Code End

        super.init(texture: firstTexture, color: UIColor.clear, size: firstTexture.size())
        
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
            selectedIndex = selectedIndex == 0 ? 1 : 0
            
            toggleHandler?(self)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        isHighlighted = false
    }
    
    // MARK:
    
    private func containsTouches(touches: Set<UITouch>) -> Bool {
        guard let scene = scene else {
            fatalError("ToggleNode must be used within a scene.")
        }
        
        return touches.contains {
            (touch) in
            
            let touchPoint = touch.location(in: scene)
            let touchedNode = scene.atPoint(touchPoint)
            
            return touchedNode === self || touchedNode.inParentHierarchy(self)
        }
    }
}
