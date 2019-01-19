import SpriteKit


// MARK: -

class TutorialScene: SKScene {
	private let pregame: Bool
	
    // New Code Start
    private var gameControlNode: GameControlLayerNode!
    private var playerNode: PlayerNode!
    private var lastUpdateTime: TimeInterval?
    // New Code End
    
    // MARK:
	
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
	
    required init(size: CGSize, pregame: Bool) {
		self.pregame = pregame
		
        super.init(size:size)
		
        // New Code Start
        createBackground()
        createPlayer()
        createCrowdAnim()
        createGameControlLayer()
        // New Code End

        // New Code Start
        // createSkipTutorialButton()
        // createPlayButton()
        // New Code End
        createCloseTutorialButton()
        createBackButton()
        
        // New Code Start
        playDemo()
        // New Code End
    }
	
    // MARK:
	
    private func createBackground() {

        GameImageCache.SharedInstance.preloadOpponentAtlas(forStage: 1)
        if let previous = self.childNode(withName: "crowdSprite") {
            previous.removeAllActions()
            previous.removeFromParent()
        }
        let crowdTextureName = "crowd.png"
        let crowdSprite = BKSpriteNode(texture: GameImageCache.SharedInstance
            .getOpponentTexture(textureName: crowdTextureName))
        crowdSprite.anchorPoint = CGPoint(x: 0.5, y: 1)
        crowdSprite.position = CGPoint(x: size.width * 0.5, y: size.height)
        crowdSprite.xScale = (size.width + 2 * AppConfig.DodgeSlideSize) / crowdSprite.texture!.size().width
        crowdSprite.zPosition = 0
        crowdSprite.name = "crowdSprite"
        addChild(crowdSprite)
        
        if let previous = self.childNode(withName: "ringSprite") {
            previous.removeAllActions()
            previous.removeFromParent()
        }
        let ringTextureName = "ring2.png"
        let ringSprite = BKSpriteNode(texture: GameImageCache.SharedInstance
            .getOpponentTexture(textureName: ringTextureName))
        ringSprite.anchorPoint = CGPoint(x: 0.5, y: 0)
        ringSprite.position = CGPoint(x: size.width * 0.5, y: 0)
        ringSprite.xScale = size.width / ringSprite.texture!.size().width
        ringSprite.zPosition = 9
        ringSprite.name = "ringSprite"
        addChild(ringSprite)
        
        let totalHeight = crowdSprite.texture!.size().height + ringSprite.texture!.size().height
        let crowdPercent = crowdSprite.texture!.size().height / totalHeight
        let ringPercent = ringSprite.texture!.size().height / totalHeight
        
        crowdSprite.yScale = size.height / crowdSprite.texture!.size().height * crowdPercent
        ringSprite.yScale = size.height / ringSprite.texture!.size().height * ringPercent
        // New Code End
    }
    
    // New Code Start
    private func createPlayer() {
        GameImageCache.SharedInstance.preloadPlayerAtlas()
        playerNode = PlayerNode(maxEnergy: 5)
        playerNode.position = CGPoint(x: size.width * PlayerConfig.percentX(forStage: 9),
                                      y: size.height * PlayerConfig.percentY(forStage: 9))
        playerNode.setScale(playerNode.percentFitScale(referSize: size, widthPercent: 100,
                                                       heightPercent: PlayerConfig.percentHeight(forStage: 9)))
        playerNode.zPosition = 30
        addChild(playerNode)
    }
    
    private func createCrowdAnim() {
        guard let crowdSprite = childNode(withName: "crowdSprite") else {
            return
        }
        
        let crowdAnimTextureNames = [
                "25_cheer_01.png",
                "25_cheer_02.png",
                "25_cheer_03.png",
                "25_cheer_04.png",
                "25_cheer_05.png",
                "25_cheer_06.png",
                "25_cheer_07.png",
                "25_cheer_08.png",
                "25_cheer_09.png",
                "25_cheer_10.png"
            ]
        
        let crowdAnimTextures = crowdAnimTextureNames.map {
            (textureName) -> SKTexture in
            
            return GameImageCache.SharedInstance.getOpponentTexture(textureName: textureName)!
        }
        
        if let previous = self.childNode(withName: "crowdAnimSprite") {
            previous.removeAllActions()
            previous.removeFromParent()
        }
        let crowdAnimSprite = crowdSprite.copy() as! BKSpriteNode
        crowdAnimSprite.texture = crowdAnimTextures.first
        crowdAnimSprite.zPosition = 10
        crowdAnimSprite.name = "crowdAnimSprite"
        addChild(crowdAnimSprite)
        
        let animateAction = SKAction.animate(with: crowdAnimTextures, timePerFrame: 0.25)
        crowdAnimSprite.run(SKAction.repeatForever(animateAction))
    }
    
    private func createGameControlLayer() {
        guard let ringSprite = childNode(withName: "ringSprite") as? BKSpriteNode else {
            fatalError("Ring sprite not found.")
        }
        
        gameControlNode = GameControlLayerNode(size: ringSprite.frame.size,
                                               backgroundColor: GameControlConfig.backgroundColor(forStage: 1),
                                               normalColor: GameControlConfig.normalColor(forStage: 1),
                                               highlightedColor: GameControlConfig.highlightedColor(forStage: 1),
                                               controlWidth: GameControlConfig.ControlWidth,
                                               controlGap: GameControlConfig.ControlGap,
                                               ring: ringSprite,
                                               touchPadOverlayColor: GameControlConfig.touchPadOverlayColor(forStage: 1))
        gameControlNode.zPosition = 15
        // gameControlNode.delegate = self
        gameControlNode.isHidden = false
        gameControlNode.isUserInteractionEnabled = false
        addChild(gameControlNode)
    }
    
    private func playDemo() {
        let fingerTexture = SKTexture(imageNamed: "finger.png")
        let fingerTapTexture = SKTexture(imageNamed: "finger_tap.png")
        let finger = BKSpriteNode(texture: fingerTexture)
        finger.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        finger.size = CGSize(width: 50, height: 50)
        finger.zPosition = 3000
        self.addChild(finger)
        
        let moveDuration = 1.0
        let allActions = SKAction.sequence([
                .move(to: CGPoint(x: self.size.width/4, y: self.size.height/2 - 30), duration: moveDuration),
                SKAction.setTexture(fingerTapTexture), // scale(to: 0.7, duration: 0.2),
                .run {
                    let point = self.convert(CGPoint(x: self.size.width/4 - 30, y: self.size.height/2 - 30), to: self.gameControlNode)
                    self.gameControlNode.handleTouchBegan(point)
                    if self.playerNode.punchTopLeft() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
                    },
                .wait(forDuration: 0.2),
                SKAction.setTexture(fingerTexture), // .scale(to: 1.0, duration: 0.2),
                .run {self.gameControlNode.touchesEnded([], with: nil)},
                .move(to: CGPoint(x: 3*self.size.width/4, y: self.size.height/2 - 30), duration: moveDuration),
                SKAction.setTexture(fingerTapTexture), // .scale(to: 0.7, duration: 0.2),
                .run {
                    let point = self.convert(CGPoint(x: 3*self.size.width/4 + 30, y: self.size.height/2 - 30), to: self.gameControlNode)
                    self.gameControlNode.handleTouchBegan(point)
                    if self.playerNode.punchTopRight() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
                },
                .wait(forDuration: 0.2),
                SKAction.setTexture(fingerTexture), // .scale(to: 1.0, duration: 0.2),
                .run {self.gameControlNode.touchesEnded([], with: nil)},
                .move(to: CGPoint(x: self.size.width/4, y: self.size.height/2 - 160), duration: moveDuration),
                SKAction.setTexture(fingerTapTexture), // .scale(to: 0.7, duration: 0.2),
                .run {
                    let point = self.convert(CGPoint(x: self.size.width/4 - 30, y: self.size.height/2 - 160), to: self.gameControlNode)
                    self.gameControlNode.handleTouchBegan(point)
                    if self.playerNode.punchBottomLeft() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
                },
                .wait(forDuration: 0.2),
                SKAction.setTexture(fingerTexture), // .scale(to: 1.0, duration: 0.2),
                .run {self.gameControlNode.touchesEnded([], with: nil)},
                .move(to: CGPoint(x: 3*self.size.width/4, y: self.size.height/2 - 160), duration: moveDuration),
                SKAction.setTexture(fingerTapTexture), // .scale(to: 0.7, duration: 0.2),
                .run {
                    let point = self.convert(CGPoint(x: 3*self.size.width/4 + 30, y: self.size.height/2 - 160), to: self.gameControlNode)
                    self.gameControlNode.handleTouchBegan(point)
                    if self.playerNode.punchBottomRight() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
                },
                .wait(forDuration: 0.2),
                SKAction.setTexture(fingerTexture), // .scale(to: 1.0, duration: 0.2),
                .run {self.gameControlNode.touchesEnded([], with: nil)},
                .move(to: CGPoint(x: self.size.width/6, y: self.size.height/2 - 290), duration: moveDuration),
                SKAction.setTexture(fingerTapTexture), // .scale(to: 0.7, duration: 0.2),
                .run {
                    let point = self.convert(CGPoint(x: self.size.width/4 - 30, y: self.size.height/2 - 290), to: self.gameControlNode)
                    self.gameControlNode.handleTouchBegan(point)
                    if self.playerNode.dodgeLeft(long: false) {
                        AudioHelper.SharedInstance.playPlayerDodgeEffect()
                        self.slideBackground(toLeft: false)
                    }
                },
                .wait(forDuration: 0.2),
                SKAction.setTexture(fingerTexture), // .scale(to: 1.0, duration: 0.2),
                .run {self.gameControlNode.touchesEnded([], with: nil)},
                .move(to: CGPoint(x: self.size.width/2, y: self.size.height/2 - 290), duration: moveDuration),
                SKAction.setTexture(fingerTapTexture), // .scale(to: 0.7, duration: 0.2),
                .run {
                    let point = self.convert(CGPoint(x: self.size.width/2, y: self.size.height/2 - 290), to: self.gameControlNode)
                    self.gameControlNode.handleTouchBegan(point)
                    _ = self.playerNode.block()
                },
                .wait(forDuration: 0.2),
                SKAction.setTexture(fingerTexture), // .scale(to: 1.0, duration: 0.2),
                .run {self.gameControlNode.touchesEnded([], with: nil)},
                .move(to: CGPoint(x: 5*self.size.width/6, y: self.size.height/2 - 290), duration: moveDuration),
                SKAction.setTexture(fingerTapTexture), // .scale(to: 0.7, duration: 0.2),
                .run {
                    _ = self.playerNode.releaseBlock()
                    let point = self.convert(CGPoint(x: 3*self.size.width/4 + 30, y: self.size.height/2 - 290), to: self.gameControlNode)
                    self.gameControlNode.handleTouchBegan(point)
                    if self.playerNode.dodgeRight(long: false) {
                        AudioHelper.SharedInstance.playPlayerDodgeEffect()
                        self.slideBackground(toLeft: true)
                    }
                },
                .wait(forDuration: 0.2),
                SKAction.setTexture(fingerTexture), // .scale(to: 1.0, duration: 0.2),
                .run {self.gameControlNode.touchesEnded([], with: nil)},

                .wait(forDuration: 1.0)
            ])
        
        finger.run(allActions) {
            self.onClickSkipTutorial(sender: ButtonNode())
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        let deltaTime = lastUpdateTime != nil ? currentTime - lastUpdateTime! : 0
        lastUpdateTime = currentTime
        
        playerNode.update(deltaTime: deltaTime)
        gameControlNode.update(deltaTime: deltaTime)
    }
    // New Code End
	
    // New Code Start
    private func slideBackground(toLeft: Bool) {
        let coef: CGFloat = toLeft ? -1 : 1
        if let crowdSprite = self.childNode(withName: "crowdSprite"), let animSprite = self.childNode(withName: "crowdAnimSprite") {
            crowdSprite.run(.sequence([SKAction.move(by: CGVector(dx: coef * AppConfig.DodgeSlideSize, dy: 0), duration: AppConfig.DodgeSlideSpeed),
                                       SKAction.move(by: CGVector(dx: coef * -1 * AppConfig.DodgeSlideSize, dy: 0), duration: AppConfig.DodgeSlideSpeed)]))
            animSprite.run(.sequence([SKAction.move(by: CGVector(dx: coef * AppConfig.DodgeSlideSize, dy: 0), duration: AppConfig.DodgeSlideSpeed),
                                      SKAction.move(by: CGVector(dx: coef * -1 * AppConfig.DodgeSlideSize, dy: 0), duration: AppConfig.DodgeSlideSpeed)]))
        }
        playerNode.run(.sequence([SKAction.move(by: CGVector(dx: coef * -0.5 * AppConfig.DodgeSlideSize, dy: 0), duration: AppConfig.DodgeSlideSpeed),
                                  SKAction.move(by: CGVector(dx: coef * 0.5 * AppConfig.DodgeSlideSize, dy: 0), duration: AppConfig.DodgeSlideSpeed)]))
    }
    // New Code End
    
    private func createSkipTutorialButton() {
		guard pregame else {
			return
		}
		
        let skipTutorialButton = ButtonNode(imageNamed: "btn_skip_tutorial.png")
        skipTutorialButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.18)
        skipTutorialButton.setScale(skipTutorialButton.percentFitScale(referSize: size,
                                                     widthPercent: 0.18, heightPercent: 0.12))
        skipTutorialButton.zPosition = 5000
        skipTutorialButton.clickHandler = { [weak self] in self?.onClickSkipTutorial(sender: $0) }
        addChild(skipTutorialButton)
    }
	
    private func createCloseTutorialButton() {
		guard pregame else {
			return
		}
		
        let closeTutorialButton = ButtonNode(imageNamed: "btn_close_tutorial.png")
        closeTutorialButton.anchorPoint = CGPoint(x: 1, y: 1)
        closeTutorialButton.position = CGPoint(x: size.width * 0.94, y: size.height * 0.96)
        closeTutorialButton.setScale(closeTutorialButton.percentFitScale(referSize: size,
                                                 widthPercent: 0.18, heightPercent: 0.12))
        closeTutorialButton.zPosition = 5000
        closeTutorialButton.clickHandler = { [weak self] in self?.onClickCloseTutorial(sender: $0) }
        addChild(closeTutorialButton)
    }
	
    // New Code Start
    private func createPlayButton() {
        guard pregame else {
            return
        }
        
        let playButton = ButtonNode(imageNamed: "btn_play.png")
        playButton.anchorPoint = CGPoint(x: 1, y: 1)
        playButton.position = CGPoint(x: size.width * 0.94, y: size.height * 0.86)
        playButton.setScale(playButton.percentFitScale(referSize: size,
                                                    widthPercent: 0.12, heightPercent: 0.09))
        playButton.zPosition = 5000
        playButton.clickHandler = { [weak self] in self?.onClickPlay(sender: $0) }
        addChild(playButton)
    }
    // New Code End

    private func createBackButton() {
		guard !pregame else {
			return
		}
		
        let backButton = ButtonNode(imageNamed: "btn_back.png")
        backButton.anchorPoint = CGPoint(x: 0, y: 1)
        backButton.position = CGPoint(x: size.width * 0.06, y: size.height * 0.95)
        backButton.setScale(backButton.percentFitScale(referSize: size,
                                                 widthPercent: 0.18, heightPercent: 0.12))
        backButton.zPosition = 5000
        backButton.clickHandler = { [weak self] in self?.onClickSkipTutorial(sender: $0) }
        addChild(backButton)
    }
	
    // MARK:
	
    private func openLoadStageScene() {
		guard let view = view else {
            return
        }
		
        // New Code Start
        // let nextScene = LoadStageScene(size: view.bounds.size, stage: 1, cumulativeScore: 0)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let nextScene = appDelegate.getScene(kind: .loadStage, size: view.bounds.size)
        if let scene = nextScene as? LoadStageScene {
            scene.openFor(stage: 1, cumulativeScore: 0)
        }
        // New Code End
        nextScene.scaleMode = .aspectFill
		
        // New Code Start
        // use common constant
        let transition = SKTransition.fade(withDuration: AppConfig.FadeDuration)
        // let transition = SKTransition.fade(withDuration: 0.3)
        // New Code End
        view.presentScene(nextScene, transition: transition)
	}
	
    // MARK:
	
    func onClickSkipTutorial(sender: ButtonNode) {
        if pregame {
            openLoadStageScene()
        } else {
            onClickBack(sender: sender)
        }
    }
	
    func onClickCloseTutorial(sender: ButtonNode) {
        // New Code Start
        // onClickBack(sender: sender)
		DataHelper.setTutorialEnabled(enabled: false)
		
        openLoadStageScene()
        // New Code End
    }
	
    func onClickPlay(sender: ButtonNode) {
        DataHelper.setTutorialEnabled(enabled: false)
        
        openLoadStageScene()
    }
    
    func onClickBack(sender: ButtonNode) {
        guard let view = view else {
            return
        }
		
        // New Code Start
        // global variables for reusable scenes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let nextScene = appDelegate.getScene(kind: .mainMenu, size: view.bounds.size)
//        let nextScene = MainMenuScene(size: view.bounds.size)
//        nextScene.scaleMode = .aspectFill
        // New Code End

        // New Code Start
        // use common constant
        let transition = SKTransition.fade(withDuration: AppConfig.FadeDuration)
        // let transition = SKTransition.fade(withDuration: 0.3)
        // New Code End
        view.presentScene(nextScene, transition: transition)
    }
}
