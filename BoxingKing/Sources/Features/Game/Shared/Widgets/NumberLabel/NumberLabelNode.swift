import SpriteKit


// MARK: -

class NumberLabelNode: SKNode
{
	public var text: String = "" {
		didSet {
			guard oldValue != text else {
				return
			}
			
			layoutFontSprites()
		}
	}
	
	public var horizontalAlignment: NumberHorizontalAlignment = .Center {
		didSet {
			guard oldValue != horizontalAlignment else {
				return
			}
			
			layoutFontSprites()
		}
	}
	
	public var fontScale: CGFloat = 1 {
		didSet {
			guard oldValue != fontScale else {
				return
			}
			
			layoutFontSprites()
		}
	}
	
	public private(set) var width: CGFloat = 0
	private let fontAtlas: SKTextureAtlas
	
    // MARK:
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
	
    required init(fontType: NumberFontType) {
    	switch fontType {
    	case .Blue:
			fontAtlas = SKTextureAtlas(named: "blue")
			
		case .Green:
			fontAtlas = SKTextureAtlas(named: "green")
			
		case .Red:
			fontAtlas = SKTextureAtlas(named: "red")
		
		case .Yellow:
			fontAtlas = SKTextureAtlas(named: "yellow")
            
        case .White:
            fontAtlas = SKTextureAtlas(named: "white")
		}
		
        super.init()
    }
	
    // MARK:
	
    private func layoutFontSprites() {
    	removeAllChildren()
		
    	width = 0
		var characterSprites = [BKSpriteNode]()
		
		for char in text {
			let textureName = char == " " ? "space.png" : "\(char).png"
			let characterSprite = BKSpriteNode(texture: fontAtlas.textureNamed(textureName))
			characterSprite.setScale(fontScale)
			characterSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
			characterSprite.zPosition = 1
			addChild(characterSprite)
			
			characterSprites.append(characterSprite)
			
			width = width + characterSprite.frame.width
		}
		
		var nextX: CGFloat = 0
		
		switch horizontalAlignment {
		case .Left:
			nextX = 0
			
    	case .Center:
			nextX = -width / 2
			
		case .Right:
			nextX = -width
		}
		
		for characterSprite in characterSprites {
			characterSprite.position = CGPoint(x: nextX, y: 0)
		
			nextX = nextX + characterSprite.frame.width
		}
	}
}
