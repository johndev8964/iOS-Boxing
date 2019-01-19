import SpriteKit


// MARK: -

class MainMenuScene: SKScene {
	private var settingsOpen = false
    private var firstOpen = true

	private var menuAnimSprite: BKSpriteNode!
    // New Code Start
	private var bestScoreLabel: NumberLabelNode!
    // private var bestScoreLabel: SKLabelNode!
    // New Code End
    private var playButton: ButtonNode!
	private var shareButton: ButtonNode!
	private var rateButton: ButtonNode!
    private var settingsButton: ButtonNode!
    private var leaderboardButton: ButtonNode!
	private var effectsToggle: ToggleNode!
	private var musicsToggle: ToggleNode!
	private var helpButton: ButtonNode!
    //private var vibrateToggle: ToggleNode!
    // New Code Start
    private var touchPadToggle: ToggleNode!
    private var crowdAnimSprite: BKSpriteNode!
    // New Code End

    // MARK:
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    override init(size: CGSize) {
        super.init(size:size)
        
        createBackground()
        createMenuAnim()
        createBestScoreLabel()
        createShareButton()
        createRateButton()
        createPlayButton()
        createSettingsButton()
        createLeaderboardButton()
        createEffectsToggle()
        createMusicsToggle()
        createHelpButton()
        // New Code Start
        createTouchPadToggle()
        //createVibrateToggle()
        // New Code End

        NotificationCenter.default.addObserver(self, selector: #selector(onBestScoreFetched),
			   name: NSNotification.Name(AppConfig.BestScoreFetchedNotification), object: nil)
    }
	
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        AudioHelper.SharedInstance.playMainMenuMusic()
        // New Code Start
        // AudioHelper.SharedInstance.playCrowdNormalEffect()
        // New Code End

        ShaderManager.SharedInstance.preloadShaders()
        
        // New Code Start
        // comment these lines - no sense
        // GameImageCache.SharedInstance.preloadPlayerAtlas()
        // GameImageCache.SharedInstance.clearOpponentAtlas()
        
        // since we don't slide out items, we need these actions only on first appearing
//        if firstOpen {
//            firstOpen = false
//            runEntranceActions()
//        }
        // New Code End
        
        // and back to entrance animations
        runEntranceActions()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.hideBannerAd()
    }
    
    override func willMove(from view: SKView) {
        // New Code Start
        // non stop main music
        // AudioHelper.SharedInstance.stopMainMenuMusic()
        // New Code End
        
        // New Code Start
        // AudioHelper.SharedInstance.stopCrowdNormalEffect()
        AudioHelper.SharedInstance.stopCrowdWinEffect()
        // New Code End

        super.willMove(from: view)
    }
    
    // MARK:
    
    private func createBackground() {
        // New Code Start
        GameImageCache.SharedInstance.preloadOpponentAtlas(forStage: 1)
        let ringTextureName = "ring2.png"
        let ringSprite = BKSpriteNode(texture: GameImageCache.SharedInstance
            .getOpponentTexture(textureName: ringTextureName))
        ringSprite.anchorPoint = CGPoint(x: 0.5, y: 0)
        ringSprite.position = CGPoint(x: size.width * 0.5, y: 0)
        ringSprite.xScale = size.width / ringSprite.texture!.size().width
        ringSprite.zPosition = 0
        ringSprite.name = "ringSprite"
        addChild(ringSprite)
        
        let crowdTextureName = "crowd.png"
        let crowdSprite = BKSpriteNode(texture: GameImageCache.SharedInstance
            .getOpponentTexture(textureName: crowdTextureName))
        crowdSprite.anchorPoint = CGPoint(x: 0.5, y: 1)
        crowdSprite.position = CGPoint(x: size.width * 0.5, y: size.height)
        crowdSprite.xScale = (size.width + 2 * AppConfig.DodgeSlideSize) / crowdSprite.texture!.size().width
        crowdSprite.zPosition = 0
        crowdSprite.name = "crowdSprite"
        addChild(crowdSprite)

        let totalHeight = crowdSprite.texture!.size().height + ringSprite.texture!.size().height
        let crowdPercent = crowdSprite.texture!.size().height / totalHeight
        let ringPercent = ringSprite.texture!.size().height / totalHeight
        ringSprite.yScale = size.height / ringSprite.texture!.size().height * ringPercent
        crowdSprite.yScale = size.height / crowdSprite.texture!.size().height * crowdPercent

    }
    
    
    
    
    
    private func createMenuAnim() {
        let menuAnimAtlas = SKTextureAtlas(named: "menu_anim")
        let menuAnimTexturesArray = menuAnimAtlas.textureNames.sorted().map {
            (textureName) -> SKTexture in
            
            return menuAnimAtlas.textureNamed(textureName)
        }
        
        menuAnimSprite = BKSpriteNode(texture: menuAnimTexturesArray.first)
        // New Code Start
        menuAnimSprite.position = CGPoint(x: size.width * 0.5, y: size.height * 1.3)
        menuAnimSprite.setScale(menuAnimSprite.percentFitScale(referSize: size,
                                                       widthPercent: 0.8, heightPercent: 0.46))
        // New Code End
        // New Code Start
        // menuAnimSprite.zPosition = 1
        menuAnimSprite.zPosition = 2
        // New Code End
        menuAnimSprite.name = "menuAnimSprite"
        addChild(menuAnimSprite)
        
        let animateAction = SKAction.animate(with: menuAnimTexturesArray, timePerFrame: 0.25)
        let waitAction = SKAction.wait(forDuration: 1)
        menuAnimSprite.run(SKAction.repeatForever(SKAction.sequence([animateAction, waitAction])))
    }
    
    private func createBestScoreLabel() {
        // New Code Start
		bestScoreLabel = NumberLabelNode(fontType: .Red)
        //bestScoreLabel = SKLabelNode()
        //bestScoreLabel.fontName = "ArcadeClassic"
        //bestScoreLabel.fontColor = .yellow
        //bestScoreLabel.fontSize = 64
        // New Code End
		bestScoreLabel.text = "0000000"
        // New Code Start
		bestScoreLabel.horizontalAlignment = .Center
		bestScoreLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.947)
        //bestScoreLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.914)
        // New Code End
		bestScoreLabel.zPosition = 2
		bestScoreLabel.alpha = 0
		addChild(bestScoreLabel)
		// New Code Start
		bestScoreLabel.fontScale = size.width / bestScoreLabel.width * 0.48
        // New Code End
    }
	
    private func createShareButton() {
        shareButton = ButtonNode(imageNamed: "btn_share.png")
        shareButton.position = CGPoint(x: size.width * 0.14, y: size.height * -0.1)
        shareButton.setScale(shareButton.percentFitScale(referSize: size,
                                                         widthPercent: 0.21, heightPercent: 0.15))
        shareButton.zPosition = 5
        shareButton.clickHandler = { [weak self] in self?.onClickShare(sender: $0) }
        addChild(shareButton)
    }
	
    private func createRateButton() {
        rateButton = ButtonNode(imageNamed: "btn_rate.png")
        rateButton.position = CGPoint(x: size.width * 0.86, y: size.height * -0.1)
        rateButton.setScale(rateButton.percentFitScale(referSize: size,
                                                         widthPercent: 0.21, heightPercent: 0.15))
        rateButton.zPosition = 5
        rateButton.clickHandler = { [weak self] in self?.onClickRate(sender: $0) }
        addChild(rateButton)
    }
	
    private func createPlayButton() {
		guard shareButton != nil else {
			fatalError("Share button not found.")
		}
		
        playButton = ButtonNode(imageNamed: "btn_play.png")
        playButton.position = CGPoint(x: size.width * 0.5, y: size.height * -0.1)
        playButton.setScale(shareButton.frame.height / playButton.texture!.size().height)
        playButton.zPosition = 5
        playButton.clickHandler = { [weak self] in self?.onClickPlay(sender: $0) }
        addChild(playButton)
    }
	
    private func createSettingsButton() {
        settingsButton = ButtonNode(imageNamed: "btn_settings.png")
        settingsButton.anchorPoint = CGPoint(x: 0, y: 1)
        settingsButton.position = CGPoint(x: size.width * 0.03, y: size.height * 1.1)
        settingsButton.setScale(settingsButton.percentFitScale(referSize: size,
													 widthPercent: 0.12, heightPercent: 0.09))
        settingsButton.zPosition = 5
        settingsButton.clickHandler = { [weak self] in self?.onClickSettings(sender: $0) }
        addChild(settingsButton)
    }
	
    private func createLeaderboardButton() {
        leaderboardButton = ButtonNode(imageNamed: "btn_leaderboard.png")
        leaderboardButton.anchorPoint = CGPoint(x: 1, y: 1)
        leaderboardButton.position = CGPoint(x: size.width * 0.97, y: size.height * 1.1)
        leaderboardButton.setScale(leaderboardButton.percentFitScale(referSize: size,
													 widthPercent: 0.12, heightPercent: 0.09))
        leaderboardButton.zPosition = 5
        leaderboardButton.clickHandler = { [weak self] in self?.onClickLeaderboard(sender: $0) }
        addChild(leaderboardButton)
    }
	
    private func createEffectsToggle() {
        effectsToggle = ToggleNode(firstImageName: "btn_sound_effects_on.png",
                                       secondImageName: "btn_sound_effects_off.png")
		effectsToggle.anchorPoint = CGPoint(x: 0, y: 1)
        effectsToggle.position = CGPoint(x: size.width * -0.15, y: size.height * 0.87)
        effectsToggle.setScale(effectsToggle.percentFitScale(referSize: size,
                                                   widthPercent: 0.12, heightPercent: 0.09))
        effectsToggle.zPosition = 5
        effectsToggle.toggleHandler = { [weak self] in self?.onToggleEffects(sender: $0) }
        addChild(effectsToggle)
		
        effectsToggle.selectedIndex = DataHelper.isEffectsEnabled() ? 0 : 1
    }
	
    private func createMusicsToggle() {
        musicsToggle = ToggleNode(firstImageName: "btn_musics_on.png",
                                       secondImageName: "btn_musics_off.png")
        musicsToggle.anchorPoint = CGPoint(x: 0, y: 1)
        musicsToggle.position = CGPoint(x: size.width * -0.15, y: size.height * 0.76)
        musicsToggle.setScale(musicsToggle.percentFitScale(referSize: size,
                                                   widthPercent: 0.12, heightPercent: 0.09))
        musicsToggle.zPosition = 5
        musicsToggle.toggleHandler = { [weak self] in self?.onToggleMusics(sender: $0) }
        addChild(musicsToggle)
		
        musicsToggle.selectedIndex = DataHelper.isMusicsEnabled() ? 0 : 1
    }
    
    private func createHelpButton() {
        helpButton = ButtonNode(imageNamed: "btn_help.png")
        helpButton.anchorPoint = CGPoint(x: 0, y: 1)
        helpButton.position = CGPoint(x: size.width * -0.15, y: size.height * 0.65)
        helpButton.setScale(helpButton.percentFitScale(referSize: size,
                                                       widthPercent: 0.12, heightPercent: 0.09))
        helpButton.zPosition = 5
        helpButton.clickHandler = { [weak self] in self?.onClickHelp(sender: $0) }
        addChild(helpButton)
    }
    
    // New Code Start
    private func createTouchPadToggle() {
        touchPadToggle = ToggleNode(firstImageName: "btn_musics_on.png",
                                    secondImageName: "btn_musics_off.png")
        touchPadToggle.anchorPoint = CGPoint(x: 0, y: 1)
        touchPadToggle.position = CGPoint(x: size.width * -0.15, y: size.height * 0.54)
        touchPadToggle.setScale(touchPadToggle.percentFitScale(referSize: size,
                                                           widthPercent: 0.12, heightPercent: 0.09))
        touchPadToggle.zPosition = 5
        touchPadToggle.toggleHandler = { [weak self] in self?.onToggleTouchPad(sender: $0) }
        addChild(touchPadToggle)
        
        touchPadToggle.selectedIndex = DataHelper.isTouchPadEnabled() ? 0 : 1
    }
    
    
   /* private func createVibrateToggle() {
        vibrateToggle = ToggleNode(firstImageName: "btn_musics_on.png",
                                    secondImageName: "btn_musics_off.png")
        vibrateToggle.anchorPoint = CGPoint(x: 0, y: 1)
        vibrateToggle.position = CGPoint(x: size.width * -0.15, y: size.height * 0.43)
        vibrateToggle.setScale(vibrateToggle.percentFitScale(referSize: size,
                                                               widthPercent: 0.12, heightPercent: 0.09))
        vibrateToggle.zPosition = 5
        vibrateToggle.toggleHandler = { [weak self] in self?.onToggleVibrate(sender: $0) }
        addChild(vibrateToggle)
        
        vibrateToggle.selectedIndex = DataHelper.isTouchPadEnabled() ? 0 : 1
    }*/

    
    
    
    private func animateCrowdNormal() {
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
        crowdAnimSprite = crowdSprite.copy() as! BKSpriteNode
        crowdAnimSprite.texture = crowdAnimTextures.first
        crowdAnimSprite.zPosition = 1
        crowdAnimSprite.name = "crowdAnimSprite"
        addChild(crowdAnimSprite)
        
        let animateAction = SKAction.animate(with: crowdAnimTextures, timePerFrame: 0.25)
        crowdAnimSprite.run(SKAction.repeatForever(animateAction))
    }
    
    private func animateCrowdWin() {
        AudioHelper.SharedInstance.stopCrowdNormalEffect()
        AudioHelper.SharedInstance.playCrowdWinEffect()
        
        let crowdAnimTextureNames = [
                "100_cheer_01.png",
                "100_cheer_02.png",
                "100_cheer_03.png",
                "100_cheer_04.png",
                "100_cheer_05.png",
                "100_cheer_06.png",
                "100_cheer_07.png",
                "100_cheer_08.png",
                "100_cheer_09.png",
                "100_cheer_10.png"]
        
        let crowdAnimTextures = crowdAnimTextureNames.map {
            (textureName) -> SKTexture in
            
            return GameImageCache.SharedInstance.getOpponentTexture(textureName: textureName)!
        }
        
        let animateAction = SKAction.animate(with: crowdAnimTextures, timePerFrame: 0.25)
        crowdAnimSprite.run(SKAction.repeatForever(animateAction))
    }
    
    // New Code End
    
    // MARK:
    
    private func runEntranceActions() {
        // New Code Start
        self.animateCrowdNormal()
        // New Code End

        let menuAnimMoveAction = SKAction.moveTo(y: size.height * 0.63, duration: 0.3)
        menuAnimMoveAction.timingMode = .easeOut
        menuAnimSprite.run(menuAnimMoveAction) {
			[weak self] in
			
			let bestScore = DataHelper.getBestScore()
			
			if bestScore > 0 {
				self?.bestScoreLabel.text = "\(bestScore)"
				
				let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
				self?.bestScoreLabel.run(fadeInAction)
			}
            // New Code Start
            AudioHelper.SharedInstance.playCrowdNormalEffect()
            // New Code End
		}
		
        let playButtonMoveAction = SKAction.moveTo(y: size.height * 0.09, duration: 0.3)
        playButtonMoveAction.timingMode = .easeOut
        playButton.run(playButtonMoveAction)
	
        let shareButtonMoveAction = SKAction.moveTo(y: size.height * 0.09, duration: 0.3)
        shareButtonMoveAction.timingMode = .easeOut
        shareButton.run(shareButtonMoveAction)
        
        let rateButtonMoveAction = SKAction.moveTo(y: size.height * 0.09, duration: 0.3)
        rateButtonMoveAction.timingMode = .easeOut
        rateButton.run(rateButtonMoveAction)
		
        let settingsButtonMoveAction = SKAction.moveTo(y: size.height * 0.98, duration: 0.3)
        settingsButtonMoveAction.timingMode = .easeOut
        settingsButton.run(settingsButtonMoveAction)
		
        let leaderboardButtonMoveAction = SKAction.moveTo(y: size.height * 0.98, duration: 0.3)
        leaderboardButtonMoveAction.timingMode = .easeOut
        leaderboardButton.run(leaderboardButtonMoveAction)
    }
	
    private func runExitActions() {
        // New Code Start
//        playButton.isEnabled = false
//        shareButton.isEnabled = false
//        rateButton.isEnabled = false
//        settingsButton.isEnabled = false
//        leaderboardButton.isEnabled = false
//        effectsToggle.isEnabled = false
//        musicsToggle.isEnabled = false
//        helpButton.isEnabled = false
        // New Code End

        // New Code Start
        // Just remove all animations for buttons and immediately go to the next screen
        // openSceneOnPlay()
        
        self.animateCrowdWin()

		let menuAnimMoveAction = SKAction.moveTo(y: size.height * 1.3, duration: 0.3)
        menuAnimMoveAction.timingMode = .easeOut
        menuAnimSprite.run(menuAnimMoveAction) {
			[weak self] in
			
			self?.openSceneOnPlay()
		}
		
		let bestScoreFadeAction = SKAction.fadeOut(withDuration: 0.3)
		bestScoreFadeAction.timingMode = .easeOut
		bestScoreLabel.run(bestScoreFadeAction)
		
        let playButtonMoveAction = SKAction.moveTo(y: size.height * -0.1, duration: 0.3)
        playButtonMoveAction.timingMode = .easeOut
        playButton.run(playButtonMoveAction)
	
        let shareButtonMoveAction = SKAction.moveTo(y: size.height * -0.1, duration: 0.3)
        shareButtonMoveAction.timingMode = .easeOut
        shareButton.run(shareButtonMoveAction)
		
        let rateButtonMoveAction = SKAction.moveTo(y: size.height * -0.1, duration: 0.3)
        rateButtonMoveAction.timingMode = .easeOut
        rateButton.run(rateButtonMoveAction)
		
        let settingsButtonMoveAction = SKAction.moveTo(y: size.height * 1.1, duration: 0.3)
        settingsButtonMoveAction.timingMode = .easeOut
        settingsButton.run(settingsButtonMoveAction)
		
        let leaderboardButtonMoveAction = SKAction.moveTo(y: size.height * 1.1, duration: 0.3)
        leaderboardButtonMoveAction.timingMode = .easeOut
        leaderboardButton.run(leaderboardButtonMoveAction)
		
        let effectsToggleMoveAction = SKAction.moveTo(x: size.width * -0.15, duration: 0.3)
		effectsToggleMoveAction.timingMode = .easeOut
		effectsToggle.run(effectsToggleMoveAction)
	
		let musicsToggleMoveAction = SKAction.moveTo(x: size.width * -0.15, duration: 0.3)
		musicsToggleMoveAction.timingMode = .easeOut
		musicsToggle.run(musicsToggleMoveAction)
	
		let helpButtonMoveAction = SKAction.moveTo(x: size.width * -0.15, duration: 0.3)
		helpButtonMoveAction.timingMode = .easeOut
		helpButton.run(helpButtonMoveAction)
        
        let touchPadToggleAction = SKAction.moveTo(x: size.width * -0.15, duration: 0.3)
        touchPadToggleAction.timingMode = .easeOut
        touchPadToggle.run(touchPadToggleAction)
        
        settingsOpen = false
        
        // New Code End
    }
	
    private func openSceneOnPlay() {
    	guard let view = view else {
            return
        }
		
        let nextScene: SKScene
		
        if AppConfig.DebugMode {
            nextScene = PickStageScene(size: view.bounds.size)
        }
        else if DataHelper.isTutorialEnabled() {
			nextScene = TutorialScene(size: view.bounds.size, pregame: true)
		}
        else {
            // New Code Start
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
            nextScene = appDelegate.getScene(kind: .loadStage, size: view.bounds.size)
            if let scene = nextScene as? LoadStageScene {
                scene.openFor(stage: 1, cumulativeScore: 0)
            }
            // nextScene = LoadStageScene(size: view.bounds.size, stage: 1, cumulativeScore: 0)
           // New Code End
        }
		
        nextScene.scaleMode = .aspectFill
		
        // New Code Start
        // use common constant
        let transition = SKTransition.fade(withDuration: AppConfig.FadeDuration)
        // let transition = SKTransition.fade(withDuration: 0.3)
        // New Code End
        view.presentScene(nextScene, transition: transition)
	}
	
	@objc private func onBestScoreFetched() {
		let bestScore = DataHelper.getBestScore()
        bestScoreLabel.text = "\(bestScore)"
        bestScoreLabel.alpha = bestScore > 0 ? 1 : 0
	}
    
    // MARK:
    
    private func onClickPlay(sender: ButtonNode) {
        // New Code Start
    	// AudioHelper.SharedInstance.playCrowdExcitedEffect()
        // New Code End

        runExitActions()
    }
    
    private func onClickSettings(sender: ButtonNode) {
        if settingsOpen {
			settingsOpen = false
			
			let effectsToggleMoveAction = SKAction.moveTo(x: size.width * -0.15, duration: 0.3)
			effectsToggleMoveAction.timingMode = .easeOut
			effectsToggle.run(effectsToggleMoveAction)
			
			let musicsToggleMoveAction = SKAction.moveTo(x: size.width * -0.15, duration: 0.3)
			musicsToggleMoveAction.timingMode = .easeOut
			musicsToggle.run(musicsToggleMoveAction)
			
			let helpButtonMoveAction = SKAction.moveTo(x: size.width * -0.15, duration: 0.3)
			helpButtonMoveAction.timingMode = .easeOut
			helpButton.run(helpButtonMoveAction)
            
            // New Code Start
            let touchPadToggleMoveAction = SKAction.moveTo(x: size.width * -0.15, duration: 0.3)
            touchPadToggleMoveAction.timingMode = .easeOut
            touchPadToggle.run(touchPadToggleMoveAction)
            // New Code End
		}
		else {
			settingsOpen = true
			
			let effectsToggleMoveAction = SKAction.moveTo(x: size.width * 0.03, duration: 0.3)
			effectsToggleMoveAction.timingMode = .easeOut
			effectsToggle.run(effectsToggleMoveAction)
			
			let musicsToggleMoveAction = SKAction.moveTo(x: size.width * 0.03, duration: 0.3)
			musicsToggleMoveAction.timingMode = .easeOut
			musicsToggle.run(musicsToggleMoveAction)
			
			let helpButtonMoveAction = SKAction.moveTo(x: size.width * 0.03, duration: 0.3)
			helpButtonMoveAction.timingMode = .easeOut
			helpButton.run(helpButtonMoveAction)
            
            // New Code Start
            let touchPadToggleMoveAction = SKAction.moveTo(x: size.width * 0.03, duration: 0.3)
            touchPadToggleMoveAction.timingMode = .easeOut
            touchPadToggle.run(touchPadToggleMoveAction)
            // New Code End
		}
    }
    
    private func onClickShare(sender: ButtonNode) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.shareApp()
    }
    
    private func onClickLeaderboard(sender: ButtonNode) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showLeaderboard()
    }
    
    private func onClickRate(sender: ButtonNode) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.openRateUrl()
    }
	
    private func onToggleEffects(sender: ToggleNode) {
        DataHelper.setEffectsEnabled(enabled: sender.selectedIndex == 0)
        AudioHelper.SharedInstance.setEffectsVolume(volume: sender.selectedIndex == 0 ? 1 : 0)
    }
	
    private func onToggleMusics(sender: ToggleNode) {
        DataHelper.setMusicsEnabled(enabled: sender.selectedIndex == 0)
        AudioHelper.SharedInstance.setMusicsVolume(volume: sender.selectedIndex == 0 ? 1 : 0)
    }
    
   /* private func onToggleVibrate(sender: ToggleNode) {
        DataHelper.setMusicsEnabled(enabled: sender.selectedIndex == 0)
        AudioHelper.SharedInstance.setMusicsVolume(volume: sender.selectedIndex == 0 ? 1 : 0)
    }*/
	
    // New Code Start
    private func onToggleTouchPad(sender: ToggleNode) {
        DataHelper.setTouchPadEnabled(enabled: sender.selectedIndex == 0)
    }
    // New Code End
    
    private func onClickHelp(sender: ButtonNode) {
        guard let view = view else {
            return
        }
		
        let nextScene = TutorialScene(size: view.bounds.size, pregame: false)
        nextScene.scaleMode = .aspectFill
		
        // New Code Start
        // use common constant
        let transition = SKTransition.fade(withDuration: AppConfig.FadeDuration)
        // let transition = SKTransition.fade(withDuration: 0.3)
        // New Code End
        view.presentScene(nextScene, transition: transition)
    }
}
