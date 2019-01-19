import SpriteKit
import GLKit


// MARK: -

// New Code Start
enum RingTouchArea: Int {
    case attackTopLeft
    case attackTopRight
    case attackBottomLeft
    case attackBottomRight
    case dodgeLeft
    case dodgeRight
    case block
}
// New Code End

class GameControlLayerNode: SKShapeNode, Updatable {
    weak var delegate: GameControlLayerDelegate?
    
    private let size: CGSize
    private let backgroundColor: UIColor
    private let normalColor: UIColor
    private let highlightedColor: UIColor
    private let touchPadOverlayColor: GLKVector4
    private let controlWidth: CGFloat
    private let controlGap: CGFloat

    private var timeCharged: TimeInterval = 0
    
    private var attackTopLeftIndicator: ControlIndicatorNode!
    private var attackTopRightIndicator: ControlIndicatorNode!
    private var attackBottomLeftIndicator: ControlIndicatorNode!
    private var attackBottomRightIndicator: ControlIndicatorNode!
    private var dodgeLeftIndicator: ControlIndicatorNode!
    private var dodgeRightIndicator: ControlIndicatorNode!
    private var blockIndicator: ControlIndicatorNode!
    
    // New Code Start
    // Overlay sprites of the current touch pad
    private var attackTopLeftSquare: BKSpriteNode!
    private var attackTopRightSquare: BKSpriteNode!
    private var attackBottomLeftSquare: BKSpriteNode!
    private var attackBottomRightSquare: BKSpriteNode!
    private var dodgeLeftSquare: BKSpriteNode!
    private var dodgeRightSquare: BKSpriteNode!
    private var blockSquare: BKSpriteNode!
    
    private weak var ring: BKSpriteNode?
    // New Code End
    
    // MARK:
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(size: CGSize, backgroundColor: UIColor,
                  normalColor: UIColor, highlightedColor: UIColor,
                  controlWidth: CGFloat, controlGap: CGFloat,
                  ring: BKSpriteNode?, touchPadOverlayColor: GLKVector4) {
		self.size = size
        self.backgroundColor = backgroundColor
        self.normalColor = normalColor
        self.highlightedColor = highlightedColor
        self.controlWidth = controlWidth
        self.controlGap = controlGap
        self.touchPadOverlayColor = touchPadOverlayColor

        super.init()
        
        let path = CGMutablePath()
		path.addLines(between: [			
                CGPoint(x: -self.controlWidth, y: size.height),
                CGPoint(x: -self.controlWidth, y: -self.controlWidth),
                CGPoint(x: size.width + self.controlWidth, y: -self.controlWidth),
                CGPoint(x: size.width + self.controlWidth, y: size.height),
                CGPoint(x: size.width - self.controlWidth, y: size.height),
                CGPoint(x: size.width - self.controlWidth, y: self.controlWidth),
                CGPoint(x: self.controlWidth, y: self.controlWidth),
                CGPoint(x: self.controlWidth, y: size.height),
                CGPoint(x: -self.controlWidth, y: size.height)
            ])
		
        self.path = path
        fillColor = self.backgroundColor
        strokeColor = UIColor.clear
        lineWidth = 1
        lineCap = .round
        lineJoin = .round
        isAntialiased = true
        
        // New Code Start
        self.ring = ring
        // New Code End

        createAttackTopLeftIndicator()
        createAttackTopRightIndicator()
        createAttackBottomLeftIndicator()
        createAttackBottomRightIndicator()
        createDodgeLeftIndicator()
        createDodgeRightIndicator()
        createBlockIndicator()

        isUserInteractionEnabled = true
    }
    
    // MARK:
    
    func handleTouchBegan(_ touchPoint: CGPoint) {
        // New Code Start
        // 4. Fix touch pad change from 30/30/30 to 40/40/20 height.
        let area: RingTouchArea
        /*
        if touchPoint.y < size.height / 5 {
            if touchPoint.x < size.width / 3 {
                area = .dodgeLeft
                dodgeLeftIndicator.holdPress()
            }
            else if touchPoint.x < size.width * 2 / 3 {
                area = .block
                blockIndicator.holdPress()
                
                delegate?.gameControlLayerDidRequestHoldBlock(self)
            }
            else {
                area = .dodgeRight
                dodgeRightIndicator.holdPress()
            }
        }
        else if touchPoint.y < size.height * 6 / 10 {
            if touchPoint.x < size.width / 2 {
                area = .attackBottomLeft
                attackBottomLeftIndicator.holdPress()
            }
            else {
                area = .attackBottomRight
                attackBottomRightIndicator.holdPress()
            }
        }
        else {
            if touchPoint.x < size.width / 2 {
                area = .attackTopLeft
                attackTopLeftIndicator.holdPress()
            }
            else {
                area = .attackTopRight
                attackTopRightIndicator.holdPress()
            }
        }
        */
        
        if touchPoint.y < size.height / 3 {
            if touchPoint.x < size.width / 3 {
                area = .dodgeLeft
                dodgeLeftIndicator.holdPress()
            }
            else if touchPoint.x < size.width * 2 / 3 {
                area = .block
                blockIndicator.holdPress()
         
                delegate?.gameControlLayerDidRequestHoldBlock(self)
            }
            else {
                area = .dodgeRight
                dodgeRightIndicator.holdPress()
            }
        }
        else if touchPoint.y < size.height * 2 / 3 {
            if touchPoint.x < size.width / 2 {
                area = .attackBottomLeft
                attackBottomLeftIndicator.holdPress()
            }
            else {
                area = .attackBottomRight
               attackBottomRightIndicator.holdPress()
            }
        }
        else {
            if touchPoint.x < size.width / 2 {
                area = .attackTopLeft
                attackTopLeftIndicator.holdPress()
            }
            else {
                area = .attackTopRight
                attackTopRightIndicator.holdPress()
            }
        }
 
        // 5. Add highlight overlay to touch pad.
        self.addLightNode(area: area)
        
        // New Code End
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchPoint = touch.location(in: self)
            handleTouchBegan(touchPoint)
        }
    }

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if attackTopLeftIndicator.isHighlighted {
			attackTopLeftIndicator.releasePress()

			if timeCharged >= GameControlConfig.HookChargeTime {
				delegate?.gameControlLayerDidRequestHookTopLeft(self)
			}
			else {
				delegate?.gameControlLayerDidRequestPunchTopLeft(self)
			}
		}
		else if attackTopRightIndicator.isHighlighted {
			attackTopRightIndicator.releasePress()

			if timeCharged >= GameControlConfig.HookChargeTime {
				delegate?.gameControlLayerDidRequestHookTopRight(self)
			}
			else {
				delegate?.gameControlLayerDidRequestPunchTopRight(self)
			}
		}
		else if attackBottomLeftIndicator.isHighlighted {
			attackBottomLeftIndicator.releasePress()

			if timeCharged >= GameControlConfig.HookChargeTime {
				delegate?.gameControlLayerDidRequestHookBottomLeft(self)
			}
			else {
				delegate?.gameControlLayerDidRequestPunchBottomLeft(self)
			}
		}
		else if attackBottomRightIndicator.isHighlighted {
			attackBottomRightIndicator.releasePress()

			if timeCharged >= GameControlConfig.HookChargeTime {
				delegate?.gameControlLayerDidRequestHookBottomRight(self)
			}
			else {
				delegate?.gameControlLayerDidRequestPunchBottomRight(self)
			}
		}
		else if dodgeLeftIndicator.isHighlighted {
			dodgeLeftIndicator.releasePress()

            delegate?.gameControlLayerDidRequestDodgeLeft(self, long: touches.count > 1)
		}
		else if dodgeRightIndicator.isHighlighted {
			dodgeRightIndicator.releasePress()

            delegate?.gameControlLayerDidRequestDodgeRight(self, long: touches.count > 1)
		}
		else if blockIndicator.isHighlighted {
			blockIndicator.releasePress()

			delegate?.gameControlLayerDidRequestReleaseBlock(self)
        }

        timeCharged = 0
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }

    // MARK:

    func update(deltaTime seconds: TimeInterval) {
		if attackTopLeftIndicator.isHighlighted || attackTopRightIndicator.isHighlighted
			|| attackBottomLeftIndicator.isHighlighted || attackBottomRightIndicator.isHighlighted {
			timeCharged += seconds
		}
	}
    
    // MARK:
    private func createAttackTopLeftIndicator() {
        let path = CGMutablePath()

        path.addLines(between: [
                CGPoint(x: -controlWidth, y: size.height),
                CGPoint(x: -controlWidth, y: size.height * 2 / 3 + controlGap / 2),
                CGPoint(x: controlWidth, y: size.height * 2 / 3 + controlGap / 2),
                CGPoint(x: controlWidth, y: size.height),
                CGPoint(x: -controlWidth, y: size.height)
            ])
        attackTopLeftIndicator = ControlIndicatorNode(path: path, normalColor: normalColor,
                                                      highlightedColor: highlightedColor)
        addChild(attackTopLeftIndicator)

        attackTopLeftSquare = getSubSquare(area: .attackTopLeft)
        addChild(attackTopLeftSquare)
        attackTopLeftIndicator.zPosition = attackTopLeftSquare.zPosition + 1
        
        attackTopLeftSquare.isHidden = !DataHelper.isTouchPadEnabled()
        attackTopLeftIndicator.isHidden = attackTopLeftSquare.isHidden

    }
    
    private func createAttackTopRightIndicator() {
        let path = CGMutablePath()

        path.addLines(between: [
            CGPoint(x: size.width + controlWidth, y: size.height),
            CGPoint(x: size.width + controlWidth, y: size.height * 2 / 3 + controlGap / 2),
            CGPoint(x: size.width - controlWidth, y: size.height * 2 / 3 + controlGap / 2),
            CGPoint(x: size.width - controlWidth, y: size.height),
            CGPoint(x: size.width + controlWidth, y: size.height)
            ])

        attackTopRightIndicator = ControlIndicatorNode(path: path, normalColor: normalColor,
                                                       highlightedColor: highlightedColor)
        addChild(attackTopRightIndicator)
    
        attackTopRightSquare = getSubSquare(area: .attackTopRight)
        addChild(attackTopRightSquare)
        attackTopRightIndicator.zPosition = attackTopRightSquare.zPosition + 1
        
        attackTopRightSquare.isHidden = !DataHelper.isTouchPadEnabled()
        attackTopRightIndicator.isHidden = attackTopRightSquare.isHidden
        
    }
    
    private func createAttackBottomLeftIndicator() {
        let path = CGMutablePath()

        path.addLines(between: [
            CGPoint(x: -controlWidth, y: size.height * 2 / 3 - controlGap / 2),
            CGPoint(x: -controlWidth, y: size.height / 3 + controlGap / 2),
            CGPoint(x: controlWidth, y: size.height / 3 + controlGap / 2),
            CGPoint(x: controlWidth, y: size.height * 2 / 3 - controlGap / 2),
            CGPoint(x: -controlWidth, y: size.height * 2 / 3 - controlGap / 2)
            ])
        // New Code End

        attackBottomLeftIndicator = ControlIndicatorNode(path: path, normalColor: normalColor,
                                                         highlightedColor: highlightedColor)
        addChild(attackBottomLeftIndicator)
     
        attackBottomLeftSquare = getSubSquare(area: .attackBottomLeft)
        addChild(attackBottomLeftSquare)
        attackBottomLeftIndicator.zPosition = attackBottomLeftSquare.zPosition + 1
        
        attackBottomLeftSquare.isHidden = !DataHelper.isTouchPadEnabled()
        attackBottomLeftIndicator.isHidden = attackBottomLeftSquare.isHidden
    
    }
    
    private func createAttackBottomRightIndicator() {
        let path = CGMutablePath()

        path.addLines(between: [
            CGPoint(x: size.width + controlWidth, y: size.height * 2 / 3 - controlGap / 2),
            CGPoint(x: size.width + controlWidth, y: size.height / 3 + controlGap / 2),
            CGPoint(x: size.width - controlWidth, y: size.height / 3 + controlGap / 2),
            CGPoint(x: size.width - controlWidth, y: size.height * 2 / 3 - controlGap / 2),
            CGPoint(x: size.width + controlWidth, y: size.height * 2 / 3 - controlGap / 2)
            ])
        
        attackBottomRightIndicator = ControlIndicatorNode(path: path, normalColor: normalColor,
                                                          highlightedColor: highlightedColor)
        addChild(attackBottomRightIndicator)
       
        attackBottomRightSquare = getSubSquare(area: .attackBottomRight)
        addChild(attackBottomRightSquare)
        attackBottomRightIndicator.zPosition = attackBottomRightSquare.zPosition + 1
        
        attackBottomRightSquare.isHidden = !DataHelper.isTouchPadEnabled()
       attackBottomRightIndicator.isHidden = attackBottomRightSquare.isHidden
   
    }
    
    private func createDodgeLeftIndicator() {
        let path = CGMutablePath()

        path.addLines(between: [
            CGPoint(x: -controlWidth, y: size.height / 3 - controlGap / 2),
            CGPoint(x: -controlWidth, y: -controlWidth),
            CGPoint(x: size.width / 3 - controlGap / 2, y: -controlWidth),
            CGPoint(x: size.width / 3 - controlGap / 2, y: controlWidth),
            CGPoint(x: controlWidth, y: controlWidth),
            CGPoint(x: controlWidth, y: size.height / 3 - controlGap / 2),
            CGPoint(x: -controlWidth, y: size.height / 3 - controlGap / 2)
            ])
        // New Code End

        dodgeLeftIndicator = ControlIndicatorNode(path: path, normalColor: normalColor,
                                                   highlightedColor: highlightedColor)
        addChild(dodgeLeftIndicator)
        // New Code Start
        dodgeLeftSquare = getSubSquare(area: .dodgeLeft)
        addChild(dodgeLeftSquare)
        dodgeLeftIndicator.zPosition = dodgeLeftSquare.zPosition + 1
        
        dodgeLeftSquare.isHidden = !DataHelper.isTouchPadEnabled()
        dodgeLeftIndicator.isHidden = dodgeLeftSquare.isHidden
       
    }
    
    private func createDodgeRightIndicator() {
        let path = CGMutablePath()

        path.addLines(between: [
            CGPoint(x: size.width + controlWidth, y: size.height / 3 - controlGap / 2),
            CGPoint(x: size.width + controlWidth, y: -controlWidth),
            CGPoint(x: size.width * 2 / 3 + controlGap / 2, y: -controlWidth),
            CGPoint(x: size.width * 2 / 3 + controlGap / 2, y: controlWidth),
            CGPoint(x: size.width - controlWidth, y: controlWidth),
            CGPoint(x: size.width - controlWidth, y: size.height / 3 - controlGap / 2),
            CGPoint(x: size.width + controlWidth, y: size.height / 3 - controlGap / 2)
            ])
        // New Code End

        dodgeRightIndicator = ControlIndicatorNode(path: path, normalColor: normalColor,
                                                   highlightedColor: highlightedColor)
        addChild(dodgeRightIndicator)
        // New Code Start
        dodgeRightSquare = getSubSquare(area: .dodgeRight)
        addChild(dodgeRightSquare)
        dodgeRightIndicator.zPosition = dodgeRightSquare.zPosition + 1
        
        dodgeRightSquare.isHidden = !DataHelper.isTouchPadEnabled()
        dodgeRightIndicator.isHidden = dodgeRightSquare.isHidden
     
    }
    
    private func createBlockIndicator() {
        let path = CGMutablePath()
        path.addLines(between: [
                CGPoint(x: size.width / 3 + controlGap / 2, y: -controlWidth),
                CGPoint(x: size.width * 2 / 3 - controlGap / 2, y: -controlWidth),
                CGPoint(x: size.width * 2 / 3 - controlGap / 2, y: controlWidth),
                CGPoint(x: size.width / 3 + controlGap / 2, y: controlWidth),
                CGPoint(x: size.width / 3 + controlGap / 2, y: -controlWidth)
            ])
        
        blockIndicator = ControlIndicatorNode(path: path, normalColor: normalColor,
                                              highlightedColor: highlightedColor)
        addChild(blockIndicator)
     
        blockSquare = getSubSquare(area: .block)
        addChild(blockSquare)
        blockIndicator.zPosition = blockSquare.zPosition + 1
        
        blockSquare.isHidden = !DataHelper.isTouchPadEnabled()
        blockIndicator.isHidden = blockSquare.isHidden

    }

    private func addLightNode(area: RingTouchArea) {
        if !AppConfig.TouchPadLightArea {
            return
        }
        if #available(iOS 9.0, *) {
            let selectedNode: BKSpriteNode?
            switch area {
            case .dodgeLeft:
                selectedNode = dodgeLeftSquare
            case .dodgeRight:
                selectedNode = dodgeRightSquare
            case .block:
                selectedNode = blockSquare
            case .attackBottomLeft:
                selectedNode = attackBottomLeftSquare
            case .attackBottomRight:
                selectedNode = attackBottomRightSquare
            case .attackTopLeft:
                selectedNode = attackTopLeftSquare
            case .attackTopRight:
                selectedNode = attackTopRightSquare
            }
            
            if let node = selectedNode, let shader = ShaderManager.SharedInstance.touchPadHitShader?[area.rawValue] {
                node.shader = shader
                let waitAction = SKAction.wait(forDuration: 0.3)
                run(waitAction) {
                    node.shader = nil
                }
            }
        } else {
            let sz: CGSize
            let point: CGPoint
            switch area {
            case .dodgeLeft:
                sz = CGSize(width: size.width / 3, height: size.height / 3)
                point = CGPoint(x: size.width / 6, y: size.height / 3)
            case .dodgeRight:
                sz = CGSize(width: size.width / 3, height: size.height / 3)
                point = CGPoint(x: 5 * size.width / 6, y: size.height / 3)
            case .block:
                sz = CGSize(width: size.width / 3, height: size.height / 3)
                point = CGPoint(x: 3 * size.width / 6, y: size.height / 3)
            case .attackBottomLeft:
                sz = CGSize(width: size.width / 2, height: size.height / 3)
                point = CGPoint(x: size.width / 4, y: 2 * size.height / 3)
            case .attackBottomRight:
                sz = CGSize(width: size.width / 2, height: size.height / 3)
                point = CGPoint(x: 3 * size.width / 4, y: 2 * size.height / 3)
            case .attackTopLeft:
                sz = CGSize(width: size.width / 2, height: size.height / 3)
                point = CGPoint(x: size.width / 4, y: size.height)
            case .attackTopRight:
                sz = CGSize(width: size.width / 2, height: size.height / 3)
                point = CGPoint(x: 3 * size.width / 4, y: size.height)
            }
            let light = SKShapeNode(rectOf: sz)
            light.position = point
            light.fillColor = UIColor(red: CGFloat(self.touchPadOverlayColor.x),
                                      green: CGFloat(self.touchPadOverlayColor.y),
                                      blue: CGFloat(self.touchPadOverlayColor.z),
                                      alpha: CGFloat(self.touchPadOverlayColor.w))
            light.alpha = 0
            self.addChild(light)
            light.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.5, duration: 0.1),
                                               SKAction.fadeAlpha(to: 0.0, duration: 0.1),])) {
                light.removeAllActions()
                light.removeFromParent()
            }
        }
    }
    
   func getSubSquare(area: RingTouchArea) -> BKSpriteNode {
        if #available(iOS 10.0, *) {
            let textureSize = self.ring!.texture!.size()
            let cropSize: CGSize
            let cropOrigin: CGPoint
            let origin: CGPoint
            switch area {
            case .dodgeLeft:
                cropSize = CGSize(width: textureSize.width / 3, height: textureSize.height / 3)
                cropOrigin = CGPoint(x: 0, y: 2 * textureSize.height / 3)
                origin = CGPoint(x: size.width / 6, y: size.height / 6)
            case .dodgeRight:
                cropSize = CGSize(width: textureSize.width / 3, height: textureSize.height / 3)
                cropOrigin = CGPoint(x: 4 * textureSize.width / 6, y: 2 * textureSize.height / 3)
                origin = CGPoint(x: 5 * size.width / 6, y: size.height / 6)
            case .block:
                cropSize = CGSize(width: textureSize.width / 3, height: textureSize.height / 3)
                cropOrigin = CGPoint(x: 2 * textureSize.width / 6, y: 2 * textureSize.height / 3)
                origin = CGPoint(x: 3 * size.width / 6, y: size.height / 6)
            case .attackBottomLeft:
                cropSize = CGSize(width: textureSize.width / 2, height: textureSize.height / 3)
                cropOrigin = CGPoint(x: 0, y: textureSize.height / 3)
                origin = CGPoint(x: size.width / 4, y: 3 * size.height / 6)
            case .attackBottomRight:
                cropSize = CGSize(width: textureSize.width / 2, height: textureSize.height / 3)
                cropOrigin = CGPoint(x: textureSize.width / 2, y: textureSize.height / 3)
                origin = CGPoint(x: 3 * size.width / 4, y: 3 * size.height / 6)
            case .attackTopLeft:
                cropSize = CGSize(width: textureSize.width / 2, height: textureSize.height / 3)
                cropOrigin = CGPoint(x: 0, y: 0)
                origin = CGPoint(x: size.width / 4, y: 5 * size.height / 6)
            case .attackTopRight:
                cropSize = CGSize(width: textureSize.width / 2, height: textureSize.height / 3)
                cropOrigin = CGPoint(x: textureSize.width / 2, y: 0)
                origin = CGPoint(x: 3 * size.width / 4, y: 5 * size.height / 6)
            }
            
            if let image = self.ring?.texture?.cgImage().cropping(to: CGRect(origin: cropOrigin, size: cropSize)) {
                let texture = SKTexture(cgImage: image)
                ShaderManager.SharedInstance.updateTouchPadHitShader(area: area, texture: texture, overlayColor: self.touchPadOverlayColor)
                let node = BKSpriteNode(texture: texture)
                node.position = origin
                node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                if let xScale = self.ring?.xScale {
                    node.xScale = xScale
                }
                if let yScale = self.ring?.yScale {
                    node.yScale = yScale
                }

                return node
            }
        }
        return BKSpriteNode()
    }
    
   /* func getSubSquare(area: RingTouchArea) -> BKSpriteNode {
        
        let textureSize = self.ring!.texture!.size()
        let cropSize: CGSize
        let cropOrigin: CGPoint
        let origin: CGPoint
        
        switch area {
            
        case .dodgeLeft:
            cropSize = CGSize(width: textureSize.width / 3, height: textureSize.height / 3)
            cropOrigin = CGPoint(x: 0, y: 2 * textureSize.height / 3)
            origin = CGPoint(x: size.width / 6, y: size.height / 6)
        case .dodgeRight:
            cropSize = CGSize(width: textureSize.width / 3, height: textureSize.height / 3)
            cropOrigin = CGPoint(x: 4 * textureSize.width / 6, y: 2 * textureSize.height / 3)
            origin = CGPoint(x: 5 * size.width / 6, y: size.height / 6)
        case .block:
            cropSize = CGSize(width: textureSize.width / 3, height: textureSize.height / 3)
            cropOrigin = CGPoint(x: 2 * textureSize.width / 6, y: 2 * textureSize.height / 3)
            origin = CGPoint(x: 3 * size.width / 6, y: size.height / 6)
        case .attackBottomLeft:
            cropSize = CGSize(width: textureSize.width / 2, height: textureSize.height / 3)
            cropOrigin = CGPoint(x: 0, y: textureSize.height / 3)
            origin = CGPoint(x: size.width / 4, y: 3 * size.height / 6)
        case .attackBottomRight:
            cropSize = CGSize(width: textureSize.width / 2, height: textureSize.height / 3)
            cropOrigin = CGPoint(x: textureSize.width / 2, y: textureSize.height / 3)
            origin = CGPoint(x: 3 * size.width / 4, y: 3 * size.height / 6)
        case .attackTopLeft:
            cropSize = CGSize(width: textureSize.width / 2, height: textureSize.height / 3)
            cropOrigin = CGPoint(x: 0, y: 0)
            origin = CGPoint(x: size.width / 4, y: 5 * size.height / 6)
        case .attackTopRight:
            cropSize = CGSize(width: textureSize.width / 2, height: textureSize.height / 3)
            cropOrigin = CGPoint(x: textureSize.width / 2, y: 0)
            origin = CGPoint(x: 3 * size.width / 4, y: 5 * size.height / 6)
        }
        
        var cgImage:CGImage?
        
        if #available(iOS 9.0, *) {
            cgImage = self.ring?.texture?.cgImage().cropping(to: CGRect(origin: cropOrigin, size: cropSize))
        } else {
            cgImage = self.imageFromNode(node: self.ring!)?.cgImage?.cropping(to:  CGRect(origin: cropOrigin, size: cropSize))
        }
        
        
        guard let image = cgImage else{
            fatalError("Are you running in iOS 8.0?")
            return BKSpriteNode()
        }
        
        let texture = SKTexture(cgImage: image)
        ShaderManager.SharedInstance.updateTouchPadHitShader(area: area, texture: texture, overlayColor: self.touchPadOverlayColor)
        let node = BKSpriteNode(texture: texture)
        node.position = origin
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        if let xScale = self.ring?.xScale {
            node.xScale = xScale
        }
        if let yScale = self.ring?.yScale {
            node.yScale = yScale
        }
        
        return node
        
    }
    
    func imageWithView(view : UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    
    func imageFromNode(node : SKNode) -> UIImage? {
        if let tex = self.scene?.view?.texture(from: node) {
            let view = SKView(frame:CGRect(x: 0, y: 0, width: tex.size().width, height: tex.size().height))
            let scene = SKScene(size: tex.size())
            let sprite  = SKSpriteNode(texture: tex)
            sprite.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
            scene.addChild(sprite)
            view.presentScene(scene)
            return self.imageWithView(view: view)
        }
        return nil
    }*/

    // New Code End
}
