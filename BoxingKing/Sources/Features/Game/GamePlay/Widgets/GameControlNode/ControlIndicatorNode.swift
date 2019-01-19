import SpriteKit


// MARK: -

class ControlIndicatorNode: SKShapeNode {
	private let normalColor: UIColor
	private let highlightedColor: UIColor
    private(set) var isHighlighted = false {
        didSet {
            guard oldValue != isHighlighted else {
                return
            }
            
            if isHighlighted {
                fillColor = highlightedColor
            }
            else {
                fillColor = normalColor
            }
        }
    }
    
    // MARK:
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(path: CGPath, normalColor: UIColor, highlightedColor: UIColor) {
		self.normalColor = normalColor
		self.highlightedColor = highlightedColor
		
        super.init()
		
		self.path = path
        fillColor = self.normalColor
        strokeColor = UIColor.clear
        lineWidth = 1
        lineCap = .round
        lineJoin = .round
        isAntialiased = true
    }
    
    // MARK:
    
    func tap() {
        removeAllActions()
        
        isHighlighted = true
        
        let waitAction = SKAction.wait(forDuration: 0.1)
        run(waitAction) {
            [weak self] in
            
            self?.isHighlighted = false
        }
    }
    
    func holdPress() {
        removeAllActions()
        
        isHighlighted = true
    }
    
    func releasePress() {
        removeAllActions()
        
        isHighlighted = false
    }
}
