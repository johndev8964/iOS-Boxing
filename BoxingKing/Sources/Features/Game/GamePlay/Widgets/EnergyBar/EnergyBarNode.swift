import SpriteKit


// MARK: -

class EnergyBarNode: BKSpriteNode {
    var energy = 0 {
        didSet {
            guard oldValue != energy else {
                return
            }
            
            if energy <= 0 {
                energy = 0
            }
            else if energy > maxEnergy {
                energy = maxEnergy
            }

            // New Code Start
            // use image instead of imageNamed
//            for i in 0..<maxEnergy {
//                segmentSprites[i].texture = i >= energy ? SKTexture(imageNamed: "heart_empty.png") :
//                        SKTexture(imageNamed: "heart_full.png")
//            }
            let imageEmpty = UIImage(named: "heart_empty.png")
            let imageFull = UIImage(named: "heart_full.png")
            let textureEmpty = SKTexture(image: imageEmpty!)
            let textureFull = SKTexture(image: imageFull!)
            for i in 0..<maxEnergy {
                segmentSprites[i].texture = i >= energy ? textureEmpty : textureFull
            }
            // New Code End
        }
    }
    private let maxEnergy: Int
    private var segmentSprites = [BKSpriteNode]()
    
    // MARK:
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(size: CGSize, maxEnergy: Int) {
    	if maxEnergy <= 0 {
    		fatalError("Max energy cannot be negative")
		}
		
    	self.maxEnergy = maxEnergy
    	
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        for i in 0..<maxEnergy {
            let segmentSprite = BKSpriteNode(imageNamed: "heart_full.png")
            segmentSprite.xScale = size.width / segmentSprite.texture!.size().width / CGFloat(maxEnergy)
            segmentSprite.yScale = size.height / segmentSprite.texture!.size().height
            
            // Added By Blake -- Issue 1
            
            var yCor: Float = 0;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
                yCor = -8;
            }
            
            segmentSprite.position = CGPoint(x: size.width * CGFloat(1 - i) / CGFloat(maxEnergy), y: CGFloat(yCor))
            segmentSprite.zPosition = 1
            addChild(segmentSprite)
            
            segmentSprites.append(segmentSprite)
        }

        energy = maxEnergy
    }
}
