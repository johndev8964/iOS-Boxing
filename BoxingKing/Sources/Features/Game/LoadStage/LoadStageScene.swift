import SpriteKit

struct stageVar {
    static var currentStage = 1
}

// MARK: -

class LoadStageScene: SKScene {
    // New Code Start
    private var stage: Int = 1
    private var cumulativeScore: Int = 0
//    private let stage: Int
//    private let cumulativeScore: Int
    private var nextButton: ButtonNode!
    private var nextButtonWholeScreen: ButtonNode!
    private var nextButtonAnimateAction: SKAction!
    // New Code End
    private var loadingBar: LoadingBarNode!
	
    // MARK:
	
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
	
    override init(size: CGSize /*, stage: Int, cumulativeScore: Int*/ ) {
        // New Code Start
        // move opening depended actions to separate func
        // self.stage = stage
        // self.cumulativeScore = cumulativeScore
        // New Code End

        super.init(size: size)
		
        createBackground()
        // New Code Start
        createDarkOverlayNode()
        // New Code End
        createChampionsLogo()
        // New Code Start
        // move opening depended actions to separate func
        // createOpponentPortraits()
        // New Code End
        createLoadingBar()
		
        NotificationCenter.default.addObserver(self, selector: #selector(onPlayerLoaded),
               name: NSNotification.Name(AppConfig.PlayerLoadedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onOpponentLoaded),
               name: NSNotification.Name(AppConfig.OpponentLoadedNotification), object: nil)
    }
    
    // New Code Start
    func openFor(stage: Int, cumulativeScore: Int) {
        stageVar.currentStage = stage
        self.stage = stage
        self.cumulativeScore = cumulativeScore
        if nextButton != nil {
            nextButton.isHidden = true
            nextButton.removeAllActions()
        }
        createOpponentPortraits()
    }
    // New Code End

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
	
    // MARK:
	
    override func didMove(to view: SKView) {
        super.didMove(to: view)
		
        // New Code Start
        // still play main menu music
        // AudioHelper.SharedInstance.playLoadStageMusic()
        // New Code End

        GameImageCache.SharedInstance.preloadPlayerAtlas()
    }
	
    override func willMove(from view: SKView) {
        // New Code Start
        // stop main menu music
        // AudioHelper.SharedInstance.stopLoadStageMusic()
        AudioHelper.SharedInstance.stopMainMenuMusic()
        // New Code End

        super.willMove(from: view)
    }
	
    // MARK:
	
    private func createBackground() {
        let backgroundTextureName = "bg_load_stage.png"
        let backgroundSprite = BKSpriteNode(imageNamed: backgroundTextureName)
        backgroundSprite.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        backgroundSprite.xScale = size.width / backgroundSprite.texture!.size().width
        backgroundSprite.yScale = size.height / backgroundSprite.texture!.size().height
        backgroundSprite.zPosition = 0
        addChild(backgroundSprite)
    }
	
    // New Code Start
    private func createDarkOverlayNode() {
        // New Code Start
        if !AppConfig.SelectStageDarkOverlay {
            return
        }
        // New Code End
        let darkOverlayNode = SKShapeNode(rectOf: size)
        darkOverlayNode.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        darkOverlayNode.fillColor = UIColor.black
        darkOverlayNode.strokeColor = UIColor.clear
        darkOverlayNode.zPosition = 1
        darkOverlayNode.alpha = 0.7
        addChild(darkOverlayNode)
    }
    // New Code End
    
    private func createChampionsLogo() {
    	let championsLogoSprite = BKSpriteNode(imageNamed: "logo_champions.png")
    	championsLogoSprite.setScale(championsLogoSprite.percentFitScale(referSize: size,
											widthPercent: 0.88, heightPercent: 0.18))
    	championsLogoSprite.anchorPoint = CGPoint(x: 0.5, y: 1)
    	championsLogoSprite.position = CGPoint(x: size.width * 0.5, y: size.height * 0.97)
    	championsLogoSprite.zPosition = 3
    	championsLogoSprite.name = "championsLogoSprite"
    	addChild(championsLogoSprite)
	}
	
    private func createOpponentPortraits() {
    	guard let championsLogoNode = childNode(withName: "championsLogoSprite") else {
    		fatalError("Champions logo not created.")
		}
        
        // New Code Start
        // remove previous sprites
        let opponents = self.children.filter { (node) -> Bool in
            return node is OpponentPortraitNode
        }
        for opponent in opponents {
            opponent.removeAllActions()
            opponent.removeFromParent()
        }
        // New Code End
		
		let championsLogoSprite = championsLogoNode as! BKSpriteNode
		
		for i in 0..<9 {
			var anchorX: CGFloat
			var positionX: CGFloat
			
			switch (i % 3) {
			case 0:
				anchorX = 0
				positionX = size.width * 0.5 - championsLogoSprite.frame.width * 0.5
				
			case 2:
				anchorX = 1
				positionX = size.width * 0.5 + championsLogoSprite.frame.width * 0.5
				
			default:
				anchorX = 0.5
				positionX = size.width * 0.5
			}
		
			let opponentPortrait = OpponentPortraitNode(opponent: i + 1)
            // New Code Start
            let wPercent: CGFloat = size.height < 500 ? 0.18 : 0.24
            let hPercent: CGFloat = size.height < 500 ? 0.12 : 0.16
            // New Code End
			opponentPortrait.setScale(opponentPortrait.percentFitScale(referSize: size,
											widthPercent: wPercent, heightPercent: hPercent))
			opponentPortrait.anchorPoint = CGPoint(x: anchorX, y: 0.5)
			opponentPortrait.position = CGPoint(x: positionX,
											y: size.height * (0.69 - CGFloat(i / 3) * 0.19))
			opponentPortrait.zPosition = 3
			addChild(opponentPortrait)
			
			if i + 1 < stage {
				opponentPortrait.markDefeated()
			}
			else if i + 1 == stage {
				opponentPortrait.markNext()
			}
			else {
				opponentPortrait.markSecret()
			}
		}
	}
	
	private func createLoadingBar() {
        loadingBar = LoadingBarNode(size: CGSize(width: size.width, height: size.height * 0.01))
        loadingBar.position = CGPoint(x: size.width * 0.5, y: size.height * 0.005)
        loadingBar.zPosition = 5
        addChild(loadingBar)
    }
	
    // MARK:
	
    @objc private func onPlayerLoaded() {
        loadingBar.setProgress(0.5, animated: true)
		
        let texture = GameImageCache.SharedInstance.getPlayerTexture(textureName: "idle_0.png")
        ShaderManager.SharedInstance.updatePlayerShaders(texture: texture!)
		
        GameImageCache.SharedInstance.preloadOpponentAtlas(forStage: stage)
    }
	
    @objc private func onOpponentLoaded() {
        loadingBar.setProgress(1, animated: true)
		
		let texture = GameImageCache.SharedInstance.getOpponentTexture(textureName: "idle_0.png")
		ShaderManager.SharedInstance.updateOpponentShaders(texture: texture!)
		
        let waitAction = SKAction.wait(forDuration: 0.3)
        run(waitAction) {
            [weak self] in
			
            self?.showNextButton()
        }
    }
	
    // MARK:
	
    private func showNextButton() {
        // New Code Start
//        let nextButton = ButtonNode(imageNamed: "btn_next_0.png")
//        nextButton.setScale(nextButton.percentFitScale(referSize: size,
//                                                       widthPercent: 0.24, heightPercent: 0.16))
//        nextButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.12)
//        nextButton.zPosition = 5
//        nextButton.clickHandler = { [weak self] in self?.onClickNext(sender: $0) }
//        addChild(nextButton)
//        let nextButtonTextures = [SKTexture(imageNamed: "btn_next_0.png"),
//                                  SKTexture(imageNamed: "btn_next_1.png")]
//        let animateAction = SKAction.animate(with: nextButtonTextures, timePerFrame: 0.5)
//        nextButton.run(SKAction.repeatForever(animateAction))
        if nextButton == nil {
            nextButton = ButtonNode(imageNamed: "finger.png")
            nextButton.setScale(nextButton.percentFitScale(referSize: size,
                                                         widthPercent: 0.24, heightPercent: 0.16))
            nextButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.12)
            nextButton.zPosition = 5
            nextButton.clickHandler = { [weak self] in self?.onClickNext(sender: $0) }
            addChild(nextButton)
            // use image instead of imageNamed
            let image0 = UIImage(named: "finger.png")
            let image1 = UIImage(named: "finger_tap.png")
            let nextButtonTextures = [SKTexture(image: image0!), SKTexture(image: image1!)]
            nextButtonAnimateAction = SKAction.animate(with: nextButtonTextures, timePerFrame: 0.5)
        } else {
            nextButton.isHidden = false
        }
        nextButton.run(SKAction.repeatForever(nextButtonAnimateAction))
        // New Code End

        // New Code Start
        // Create transparent button
        if nextButtonWholeScreen == nil {
            nextButtonWholeScreen = ButtonNode(color: .clear, size: size)
            nextButtonWholeScreen.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
            nextButtonWholeScreen.zPosition = 5
            nextButtonWholeScreen.clickHandler = { [weak self] in self?.onClickNext(sender: $0) }
            addChild(nextButtonWholeScreen)
        } else {
            nextButtonWholeScreen.color = .clear
            nextButtonWholeScreen.isHidden = false
        }
        // New Code End
    }
	
    // MARK:
	
    private func onClickNext(sender: ButtonNode) {
        guard let view = view else {
            return
        }
		
        // New Code Start
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let nextScene = appDelegate.getScene(kind: .gamePlay, size: view.bounds.size)
        if let scene = nextScene as? GamePlayScene {
            scene.openFor(stage: stage, cumulativeScore: cumulativeScore)
        }
//        let nextScene = GamePlayScene(size: view.bounds.size, stage: stage,
//                                      cumulativeScore: cumulativeScore)
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
