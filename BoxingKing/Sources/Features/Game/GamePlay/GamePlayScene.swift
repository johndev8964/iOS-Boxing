import SpriteKit


// MARK: -

class GamePlayScene: SKScene, PlayerNodeDelegate, OpponentNodeDelegate,
GameControlLayerDelegate, WinLayerDelegate, LoseLayerDelegate {
    func playerNodeDidContactWithPunchS1(_ playerNode: PlayerNode) {
        opponentNode.getPunchS1(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithPunchS2(_ playerNode: PlayerNode) {
        opponentNode.getPunchS2(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithPunchS3(_ playerNode: PlayerNode) {
        opponentNode.getPunchS3(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithPunchS4(_ playerNode: PlayerNode) {
        opponentNode.getPunchS4(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithPunchS5(_ playerNode: PlayerNode) {
        opponentNode.getPunchS5(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithHookS1(_ playerNode: PlayerNode) {
        opponentNode.getHookS1(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithHookS2(_ playerNode: PlayerNode) {
        opponentNode.getHookS2(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithHookS3(_ playerNode: PlayerNode) {
        opponentNode.getHookS3(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithHookS4(_ playerNode: PlayerNode) {
        opponentNode.getHookS4(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithHookS5(_ playerNode: PlayerNode) {
        opponentNode.getHookS5(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    
    // New Code Start
    func opponentNodeDidContactWithPunchS1(_ opponentNode: OpponentNode) {
        playerNode.getPunchS1(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithPunchS2(_ opponentNode: OpponentNode) {
        playerNode.getPunchS2(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithPunchS3(_ opponentNode: OpponentNode) {
        playerNode.getPunchS3(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithPunchS4(_ opponentNode: OpponentNode) {
        playerNode.getPunchS4(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithPunchS5(_ opponentNode: OpponentNode) {
        playerNode.getPunchS5(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithHookS1(_ opponentNode: OpponentNode) {
        playerNode.getHookS1(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithHookS2(_ opponentNode: OpponentNode) {
        playerNode.getHookS2(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithHookS3(_ opponentNode: OpponentNode) {
        playerNode.getHookS3(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithHookS4(_ opponentNode: OpponentNode) {
        playerNode.getHookS4(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithHookS5(_ opponentNode: OpponentNode) {
        playerNode.getHookS5(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    // New Code End
    
    enum GameStatus {
        case awaitTap
        case play
        case gameOver
    }
    
    // New Code Start
    private var stage: Int = 1
    private var cumulativeScore: Int = 0
    private var winLayer: WinLayerNode!
    private var loseLayer: LoseLayerNode!
    private var playStageButton: ButtonNode!
    private var playStageWholeScreenButton: ButtonNode!
//    private let stage: Int
//    private let cumulativeScore: Int
    // New Code End
    private var gameStatus: GameStatus = .awaitTap
    private var lastUpdateTime: TimeInterval?
    private var attackDamage = 10
    private var opponentActionTime: TimeInterval?
    private var timeLeft: TimeInterval = AppConfig.clockTime
    private var getAttackTimes = [TimeInterval]()
    
    private var commandSequenceHandler: CommandSequenceHandler!
    
    private var timer: Timer?
    
    private var crowdAnimSprite: BKSpriteNode!
    private var darkOverlayNode: SKShapeNode!
    // New Code Start
    private var timeLeftLabel: NumberLabelNode!
    //private var timeLeftLabel: SKLabelNode!
    // New Code End
    private var playerHealthBar: PlayerHealthBarNode!
    private var opponentHealthBar: OpponentHealthBarNode!
    private var playerEnergyBar: EnergyBarNode!
    private var playerNode: PlayerNode!
    private var opponentNode: OpponentNode!
    
    private var gameControlNode: GameControlLayerNode!
    
    private var commandDebugNode: CommandDebugNode?
    
    // MARK:
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    override init(size: CGSize /*, stage: Int, cumulativeScore: Int*/ ) {
        // New Code Start
//        self.stage = stage
//        self.cumulativeScore = cumulativeScore
        // New Code End
        
        super.init(size:size)
        
        // New Code Start
//        commandSequenceHandler = CommandSequenceHandler(stage: stage)
        // New Code End

        // New Code Start
        // createBackground()
        // createCrowdAnim()
        // New Code End
        createDarkOverlayNode()
        createPlayStageButton()
        createPlayerHealthBar()
        // New Code Start
        // createOpponentHealthBar()
        // New Code End
        createPlayerEnergyBar()
        createTimeLeftLabel()
        // New Code Start
//        createPlayer()
//        createOpponent()
//        createGameControlLayer()
        // New Code End

        createCommandDebugNode()
    }
    
    // New Code Start
    func openFor(stage: Int, cumulativeScore: Int) {
        self.stage = stage
        self.cumulativeScore = cumulativeScore
        
        commandSequenceHandler = CommandSequenceHandler(stage: stage)
        createBackground()
        createCrowdAnim()
        createOpponentHealthBar()
        createPlayer()
        createOpponent()
        createGameControlLayer()
        setInitialState()
    }
    
    func setInitialState() {
        gameStatus = .awaitTap
        lastUpdateTime = nil
        attackDamage = 10
        opponentActionTime = nil
        timeLeft = AppConfig.clockTime
        getAttackTimes = [TimeInterval]()
        playStageButton.isHidden = false
        // New Code Start
        playStageWholeScreenButton.color = .clear
        playStageWholeScreenButton.isHidden = false
        // New Code End
        // New Code Start
        runPlayStageButtonAnimation()
        // New Code End
        playerHealthBar.setProgress(1, animated: false)
        opponentHealthBar.setProgress(1, animated: false)
        timeLeftLabel.text = "\(Int(timeLeft))"
        darkOverlayNode.isHidden = false
        darkOverlayNode.alpha = 0.7
        // New Code Start
        AudioHelper.SharedInstance.playStageMusic(stage: stage)
        // TODO: change back!
        AudioHelper.SharedInstance.playCrowdNormalEffect()
        // New Code End
    }
    
    // New Code Start
    private func runPlayStageButtonAnimation() {
        playStageButton.removeAllActions()
        let image0 = UIImage(named: "finger.png")
        let image1 = UIImage(named: "finger_tap.png")
        let playStageButtonTextures = [SKTexture(image: image0!), SKTexture(image: image1!)]
        let animateAction = SKAction.animate(with: playStageButtonTextures, timePerFrame: 0.5)
        playStageButton.run(SKAction.repeatForever(animateAction))
    }
    // New Code End
    
    func setFinishState() {
        stopTimer()
        if loseLayer != nil {
            loseLayer.delegate = nil
            loseLayer.removeAllActions()
            loseLayer.removeFromParent()
            loseLayer = nil
        }
        if winLayer != nil {
            winLayer.delegate = nil
            winLayer.removeAllActions()
            winLayer.removeFromParent()
            winLayer = nil
        }
    }
    
    // New Code End

    deinit {
        stopTimer()
    }
    
    // MARK:
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
		
        view.isMultipleTouchEnabled = true
        
        // AudioHelper.SharedInstance.playStageMusic(stage: stage)
        // AudioHelper.SharedInstance.playCrowdNormalEffect()
		
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.hideBannerAd()
    }
    
    override func willMove(from view: SKView) {
        // New Code Start
        setFinishState()
        // New Code End
		view.isMultipleTouchEnabled = false
		
        AudioHelper.SharedInstance.stopStageMusic(stage: stage)
        AudioHelper.SharedInstance.stopCrowdNormalEffect()
        AudioHelper.SharedInstance.stopCrowdWinEffect()
        AudioHelper.SharedInstance.stopCrowdLoseEffect()
        
        super.willMove(from: view)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        let deltaTime = lastUpdateTime != nil ? currentTime - lastUpdateTime! : 0
        lastUpdateTime = currentTime
        
        playerNode.update(deltaTime: deltaTime)
        opponentNode.update(deltaTime: deltaTime)
		gameControlNode.update(deltaTime: deltaTime)
        
        if gameStatus != .play {
            return
        }
        
        if opponentActionTime != nil {
            opponentActionTime! -= deltaTime
            
            if opponentActionTime! < 0 {
                opponentActionTime = nil
                
                commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
                commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
                
                _ = opponentNode.makeIdle(kind: 1)
            }
        }
        
        handleGameCommand()
    }
    
    // MARK:
    
    func playerNodeDidContactWithPunchTopLeft(_ playerNode: PlayerNode) {
        opponentNode.getPunchTopLeft(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithPunchTopRight(_ playerNode: PlayerNode) {
        opponentNode.getPunchTopRight(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithPunchBottomLeft(_ playerNode: PlayerNode) {
        opponentNode.getPunchBottomLeft(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithPunchBottomRight(_ playerNode: PlayerNode) {
        opponentNode.getPunchBottomRight(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithHookTopLeft(_ playerNode: PlayerNode) {
        opponentNode.getHookTopLeft(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithHookTopRight(_ playerNode: PlayerNode) {
        opponentNode.getHookTopRight(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithHookBottomLeft(_ playerNode: PlayerNode) {
        opponentNode.getHookBottomLeft(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidContactWithHookBottomRight(_ playerNode: PlayerNode) {
        opponentNode.getHookBottomRight(damage: gameStatus == .play ? attackDamage : 0)
    }
    
    func playerNodeDidBlock(_ playerNode: PlayerNode) {
        AudioHelper.SharedInstance.playPlayerBlockEffect()
        
        // New Code Start
        if !AppConfig.holdBlock {
            _ = playerNode.releaseBlock()
        }
        // New Code End
    }
    
    func playerNodeDidGetAttack(_ playerNode: PlayerNode, hook: Bool, blocked: Bool) {
        if blocked {
            AudioHelper.SharedInstance.playPlayerBlockEffect()
        } else {
            AudioHelper.SharedInstance.playPlayerHitEffect()
        }
        
        let progress = Float(playerNode.health) / 100
        playerHealthBar.setProgress(progress, animated: true)
		
        if attackDamage >= 15 {
            
            if #available(iOS 10.0, *)
            {
                print("ios 10")
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                
                shakeScene()
                //shakeSceneHorizontal()
                
            }
            else
            {
                shakeSceneHorizontal()
            }
		}
    }
    
    func playerNodeDidKnockOut(_ playerNode: PlayerNode) {
        AudioHelper.SharedInstance.playPlayerKnockOutEffect()
        
        playerHealthBar.setProgress(0, animated: true)
        
        stopTimer()
        
        handleKnockOut()
    }
    
    func playerNodeDidFinishKnockOut(_ playerNode: PlayerNode) {
        AudioHelper.SharedInstance.playHitFloorEffect()
        AudioHelper.SharedInstance.stopStageMusic(stage: stage)
		
        
        if #available(iOS 10.0, *)
        {
            shakeScene()
            
            print("ios 10")
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        }
        else
        {
            shakeScene()
        }
		
        animateCrowdEnd(playerWin: false)
        
        let bellWaitAction = SKAction.wait(forDuration: 0.5)
        let bellRunAction = SKAction.run {
			AudioHelper.SharedInstance.playBellEffect()
		}
        let celebrateWaitAction = SKAction.wait(forDuration: 1)
        run(SKAction.sequence([bellWaitAction, bellRunAction, celebrateWaitAction])) {
            [weak self] in
            
            self?.makeOpponentCelebrate()
        }
    }
    
    func playerNodeDidFinishCelebration(_ playerNode: PlayerNode) {
        // New Code Start
//        self.playerNode.zPosition = 10
//        playerHealthBar.zPosition = 10
//        opponentHealthBar.zPosition = 10
//        timeLeftLabel.zPosition = 10
        self.playerNode.zPosition = 100
        playerHealthBar.zPosition = 100
        opponentHealthBar.zPosition = 90
        timeLeftLabel.zPosition = 100
        // New Code End

        showWinLayer()
    }
    
    func playerNodeDidRecoverEnergy(_ playerNode: PlayerNode) {
        playerEnergyBar.energy = playerNode.energy
    }
    
    // MARK:
    
    func opponentNodeDidContactWithPunchTopLeft(_ opponentNode: OpponentNode) {
        playerNode.getPunchTopLeft(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithPunchTopRight(_ opponentNode: OpponentNode) {
        playerNode.getPunchTopRight(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithPunchBottomLeft(_ opponentNode: OpponentNode) {
        playerNode.getPunchBottomLeft(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithPunchBottomRight(_ opponentNode: OpponentNode) {
        playerNode.getPunchBottomRight(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithHookTopLeft(_ opponentNode: OpponentNode) {
        playerNode.getHookTopLeft(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithHookTopRight(_ opponentNode: OpponentNode) {
        playerNode.getHookTopRight(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithHookBottomLeft(_ opponentNode: OpponentNode) {
        playerNode.getHookBottomLeft(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidContactWithHookBottomRight(_ opponentNode: OpponentNode) {
        playerNode.getHookBottomRight(damage: attackDamage)
        
        commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
        commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
    }
    
    func opponentNodeDidBlock(_ opponentNode: OpponentNode) {
        AudioHelper.SharedInstance.playOpponentBlockEffect()
        
        playerNode.consumeEnergy()
        
        playerEnergyBar.energy = playerNode.energy
    }
    
    func opponentNodeDidGetAttack(_ opponentNode: OpponentNode, hook: Bool) {
        AudioHelper.SharedInstance.playOpponentHitEffect()
        
        let progress = Float(opponentNode.health) / 100
        opponentHealthBar.setProgress(progress, animated: true)
		
		if hook {
    		shakeSceneHorizontal()
		}
		
        getAttackTimes.append(timeLeft)
		
        if getAttackTimes.count >= 3 && getAttackTimes[getAttackTimes.count - 3] - timeLeft <= 1 {
            //AudioHelper.SharedInstance.playCrowdExcitedEffect()
            animateCrowdWin()
            //shakeScene()

        }
        else if attackDamage >= 10
        {
    		//AudioHelper.SharedInstance.playCrowdExcitedEffect()
            if #available(iOS 10.0, *)
            {
                print("ios 10")
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()

                animateCrowdWin()
                shakeScene()
                
            }
            else
            {
                animateCrowdWin()
                shakeScene()
            }
		}
       
    }
    
    private func animateCrowdWin()
    {
        AudioHelper.SharedInstance.playCrowdExcitedEffect()
        //AudioHelper.SharedInstance.stopCrowdNormalEffect()
        //AudioHelper.SharedInstance.playCrowdWinEffect()
        
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
        
        let animateAction = SKAction.animate(with: crowdAnimTextures, timePerFrame: 0.15)
        crowdAnimSprite.run(SKAction.repeat(animateAction, count:1))
    }
    
    
    
    func opponentNodeDidKnockOut(_ opponentNode: OpponentNode) {
        AudioHelper.SharedInstance.playOpponentKnockOutEffect()
        
        opponentHealthBar.setProgress(0, animated: true)
        
        stopTimer()
        
        handleKnockOut()
    }
    
    func opponentNodeDidFinishKnockOut(_ opponentNode: OpponentNode) {
       
        AudioHelper.SharedInstance.stopStageMusic(stage: stage)
		
        
        if #available(iOS 10.0, *)
        {
            submitScore()
            showKnockOut()
            AudioHelper.SharedInstance.playHitFloorEffect()
            shakeScene()
            
            print("ios 10")
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        }
        else
        {
            submitScore()
            showKnockOut()
            AudioHelper.SharedInstance.playHitFloorEffect()
            shakeScene()
        }
	
		
        animateCrowdEnd(playerWin: true)
        
        let bellWaitAction = SKAction.wait(forDuration: 0.5)
        let bellRunAction = SKAction.run {
			AudioHelper.SharedInstance.playBellEffect()
		}
        let celebrateWaitAction = SKAction.wait(forDuration: 1)
        run(SKAction.sequence([bellWaitAction, bellRunAction, celebrateWaitAction])) {
            [weak self] in
			
            self?.makePlayerCelebrate()
        }
    }
    
    func opponentNodeDidFinishCelebration(_ opponentNode: OpponentNode) {
		showLoseLayer()
        // New Code Start
        // show Ad
        showBannerAd()
        // New Code End
    }
	
    // MARK:
    
    func gameControlLayerDidRequestPunchTopLeft(_ sender: GameControlLayerNode) {
        if playerNode.punchTopLeft() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
        else {if playerNode.getEnergyValue() == 0 { AudioHelper.SharedInstance.playPlayerTiredEffect()}}
    }
    
    func gameControlLayerDidRequestPunchTopRight(_ sender: GameControlLayerNode) {
        if playerNode.punchTopRight() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
        else {if playerNode.getEnergyValue() == 0 { AudioHelper.SharedInstance.playPlayerTiredEffect()}}
    }
    
    func gameControlLayerDidRequestPunchBottomLeft(_ sender: GameControlLayerNode) {
        if playerNode.punchBottomLeft() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
        else {if playerNode.getEnergyValue() == 0 { AudioHelper.SharedInstance.playPlayerTiredEffect()}}
    }
    
    func gameControlLayerDidRequestPunchBottomRight(_ sender: GameControlLayerNode) {
        if playerNode.punchBottomRight() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
        else {if playerNode.getEnergyValue() == 0 { AudioHelper.SharedInstance.playPlayerTiredEffect()}}
    }
    
    func gameControlLayerDidRequestHookTopLeft(_ sender: GameControlLayerNode) {
        if playerNode.hookTopLeft() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestHookTopRight(_ sender: GameControlLayerNode) {
        if playerNode.hookTopRight() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestHookBottomLeft(_ sender: GameControlLayerNode) {
        if playerNode.hookBottomLeft() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestHookBottomRight(_ sender: GameControlLayerNode) {
        if playerNode.hookBottomRight() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    // New Code Start
    func gameControlLayerDidRequestPunchS1(_ sender: GameControlLayerNode) {
        if playerNode.punchS1() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestPunchS2(_ sender: GameControlLayerNode) {
        if playerNode.punchS2() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestPunchS3(_ sender: GameControlLayerNode) {
        if playerNode.punchS3() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestPunchS4(_ sender: GameControlLayerNode) {
        if playerNode.punchS4() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestPunchS5(_ sender: GameControlLayerNode) {
        if playerNode.punchS5() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestHookS1(_ sender: GameControlLayerNode) {
        if playerNode.hookS1() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }

    func gameControlLayerDidRequestHookS2(_ sender: GameControlLayerNode) {
        if playerNode.hookS2() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestHookS3(_ sender: GameControlLayerNode) {
        if playerNode.hookS3() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestHookS4(_ sender: GameControlLayerNode) {
        if playerNode.hookS4() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    func gameControlLayerDidRequestHookS5(_ sender: GameControlLayerNode) {
        if playerNode.hookS5() { AudioHelper.SharedInstance.playPlayerAttackEffect() }
    }
    
    // New Code End
    
    func gameControlLayerDidRequestDodgeLeft(_ sender: GameControlLayerNode, long: Bool) {
        if playerNode.dodgeLeft(long: long) {
            AudioHelper.SharedInstance.playPlayerDodgeEffect()
            slideBackground(toLeft: false)
        }
    }
    
    func gameControlLayerDidRequestDodgeRight(_ sender: GameControlLayerNode, long: Bool) {
        if playerNode.dodgeRight(long: long) {
            AudioHelper.SharedInstance.playPlayerDodgeEffect()
            slideBackground(toLeft: true)
        }
    }
    
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

    func gameControlLayerDidRequestHoldBlock(_ sender: GameControlLayerNode) {
        _ = playerNode.block()
    }
    
    func gameControlLayerDidRequestReleaseBlock(_ sender: GameControlLayerNode) {
        _ = playerNode.releaseBlock()
    }
	
    // MARK:
	
    func winLayerDidChangeTimeLeft(_ sender: WinLayerNode, timeLeft: Int) {
		timeLeftLabel.text = "\(Int(timeLeft))"
	}
	
	func winLayerDidChangeHealthLeft(_ sender: WinLayerNode, healthLeft: Int) {
		let progress = Float(healthLeft) / 100
        playerHealthBar.setProgress(progress, animated: false)
	}
	
	func winLayerDidClickNext(_ sender: WinLayerNode) {
		guard let view = view else {
            return
        }

		let newCumulativeScore = cumulativeScore + Int(timeLeft) * 100 + playerNode.health * 100
        // New Code Start
//        let nextScene = stage < 9 ? LoadStageScene(size: view.bounds.size, stage: stage + 1,
//                                                   cumulativeScore: newCumulativeScore)
//            : FinalScene(size: view.bounds.size)
        let nextScene: SKScene
        if stage < 9 {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            nextScene = appDelegate.getScene(kind: .loadStage, size: view.bounds.size)
            if let scene = nextScene as? LoadStageScene {
                scene.openFor(stage: stage + 1, cumulativeScore: newCumulativeScore)
            }
        } else {
            nextScene = FinalScene(size: view.bounds.size)
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
	
	func winLayerDidClickShare(_ sender: WinLayerNode) {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.shareApp()
	}
	
	func winLayerDidClickRate(_ sender: WinLayerNode) {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.openRateUrl()
	}
	
	// MARK:
	
	func loseLayerDidWatchAd(_ sender: LoseLayerNode) {
		hideBannerAd()
		reopenGameStage()
	}
	
	func loseLayerDidSpendContinue(_ sender: LoseLayerNode) {
		hideBannerAd()
		reopenGameStage()
	}
	
	func loseLayerDidPurchaseContinue(_ sender: LoseLayerNode) {
		hideBannerAd()
		reopenGameStage()
	}
	
	func loseLayerDidResign(_ sender: LoseLayerNode) {
		hideBannerAd()
		openMainMenu()
	}
    
    // MARK:
    
    private func createBackground() {
        // New Code Start
        if let previous = self.childNode(withName: "crowdSprite") {
            previous.removeAllActions()
            previous.removeFromParent()
        }
        // New Code End
        let crowdTextureName = "crowd.png"
        let crowdSprite = BKSpriteNode(texture: GameImageCache.SharedInstance
                .getOpponentTexture(textureName: crowdTextureName))
        crowdSprite.anchorPoint = CGPoint(x: 0.5, y: 1)
        crowdSprite.position = CGPoint(x: size.width * 0.5, y: size.height)
        crowdSprite.xScale = (size.width + 2 * AppConfig.DodgeSlideSize) / crowdSprite.texture!.size().width
        crowdSprite.zPosition = 0
        crowdSprite.name = "crowdSprite"
        addChild(crowdSprite)
        
        // New Code Start
        if let previous = self.childNode(withName: "ringSprite") {
            previous.removeAllActions()
            previous.removeFromParent()
        }
        // New Code End
        let ringTextureName = "ring.png"
        let ringSprite = BKSpriteNode(texture: GameImageCache.SharedInstance
                .getOpponentTexture(textureName: ringTextureName))
        ringSprite.anchorPoint = CGPoint(x: 0.5, y: 0)
        ringSprite.position = CGPoint(x: size.width * 0.5, y: 0)
        ringSprite.xScale = size.width / ringSprite.texture!.size().width
        // New Code Start
        // ringSprite.zPosition = 1
        ringSprite.zPosition = 9
        // New Code End
        ringSprite.name = "ringSprite"
        addChild(ringSprite)
        
        let totalHeight = crowdSprite.texture!.size().height + ringSprite.texture!.size().height
        let crowdPercent = crowdSprite.texture!.size().height / totalHeight
        let ringPercent = ringSprite.texture!.size().height / totalHeight
        
        crowdSprite.yScale = size.height / crowdSprite.texture!.size().height * crowdPercent
        ringSprite.yScale = size.height / ringSprite.texture!.size().height * ringPercent
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
		
        // New Code Start
        if let previous = self.childNode(withName: "crowdAnimSprite") {
            previous.removeAllActions()
            previous.removeFromParent()
        }
        // New Code End
        crowdAnimSprite = crowdSprite.copy() as! BKSpriteNode
        crowdAnimSprite.texture = crowdAnimTextures.first
        // New Code Start
        // crowdAnimSprite.zPosition = 1
        crowdAnimSprite.zPosition = 10
        crowdAnimSprite.name = "crowdAnimSprite"
        // New Code End
        addChild(crowdAnimSprite)
        
        let animateAction = SKAction.animate(with: crowdAnimTextures, timePerFrame: 0.25)
        crowdAnimSprite.run(SKAction.repeatForever(animateAction))
    }
    
    private func createDarkOverlayNode() {
        darkOverlayNode = SKShapeNode(rectOf: size)
        darkOverlayNode.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        darkOverlayNode.fillColor = UIColor.black
        darkOverlayNode.strokeColor = UIColor.clear
        // New Code Start
        // darkOverlayNode.zPosition = 80
        darkOverlayNode.zPosition = 101
        // New Code End
        darkOverlayNode.alpha = 0.7
        addChild(darkOverlayNode)
    }
    
    private func createPlayStageButton() {
        playStageButton = ButtonNode(imageNamed: "finger.png")
        // New Code Start
        playStageButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.12)
        // playStageButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.18)
        playStageButton.setScale(playStageButton.percentFitScale(referSize: size,
                                               widthPercent: 0.24, heightPercent: 0.16))
        // playStageButton.setScale(playStageButton.percentFitScale(referSize: size,
        //                                                         widthPercent: 0.18, heightPercent: 0.12))
        // playStageButton.zPosition = 101
        playStageButton.zPosition = 1010
        // New Code End
        playStageButton.clickHandler = { [weak self] in self?.onClickPlayStage(sender: $0) }
        addChild(playStageButton)
        
        // New Code Start
        playStageWholeScreenButton = ButtonNode(color: .clear, size: size)
        playStageWholeScreenButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        playStageWholeScreenButton.zPosition = 1020
        playStageWholeScreenButton.clickHandler = { [weak self] in self?.onClickPlayStage(sender: $0) }
        addChild(playStageWholeScreenButton)
        // New Code End
    }
    
    private func createPlayerHealthBar() {
        playerHealthBar = PlayerHealthBarNode()
        playerHealthBar.setScale(size.width / playerHealthBar.size.width * 0.41)
        playerHealthBar.position = CGPoint(x: size.width * 0.22,
                                         y: size.height - playerHealthBar.frame.height / 2)
        // New Code Start
        // playerHealthBar.zPosition = 5
        playerHealthBar.zPosition = 50
        // New Code End
        addChild(playerHealthBar)
        
        playerHealthBar.setProgress(1, animated: false)
    }
    
    private func createOpponentHealthBar() {
        // New Code Start
        if opponentHealthBar != nil {
            opponentHealthBar.removeAllActions()
            opponentHealthBar.removeFromParent()
            opponentHealthBar = nil
        }
        // New Code End
        opponentHealthBar = OpponentHealthBarNode()
        opponentHealthBar.setScale(size.width / opponentHealthBar.size.width * 0.41)
        opponentHealthBar.position = CGPoint(x: size.width * 0.78,
                                     y: size.height - opponentHealthBar.frame.height / 2)
        // New Code Start
        // opponentHealthBar.zPosition = 5
        opponentHealthBar.zPosition = 50
        // New Code End
        addChild(opponentHealthBar)
        
        opponentHealthBar.setProgress(1, animated: false)
    }
    
    private func createPlayerEnergyBar() {
    	playerEnergyBar = EnergyBarNode(size: CGSize(width: size.width * 0.2,
													 height: size.height * 0.02), maxEnergy: 5)
        // New Code Start
        let hCoef: CGFloat = size.height < 500 ? 0.92 : 0.93
        playerEnergyBar.position = CGPoint(x: size.width * 0.35, y: size.height * hCoef + 5)
        // playerEnergyBar.position = CGPoint(x: size.width * 0.35, y: size.height * 0.915)
        // playerEnergyBar.zPosition = 5
        playerEnergyBar.zPosition = 50
        // New Code End
        addChild(playerEnergyBar)

//        playerEnergyBar = EnergyBarNode(size: CGSize(width: size.width * 0.16,
//													 height: size.height * 0.016), maxEnergy: 5)
//        playerEnergyBar.position = CGPoint(x: size.width * 0.35, y: size.height * 0.92)
//        playerEnergyBar.zPosition = 5
//        addChild(playerEnergyBar)
    }
	
    private func createTimeLeftLabel() {
        // New Code Start
    	timeLeftLabel = NumberLabelNode(fontType: .White)
        // timeLeftLabel = SKLabelNode()
        // timeLeftLabel.fontName = "ArcadeClassic"
        // timeLeftLabel.fontColor = .white
        // timeLeftLabel.fontSize = 40
        // New Code End
		timeLeftLabel.text = "\(Int(timeLeft))"
        // New Code Start
		timeLeftLabel.horizontalAlignment = .Center
		timeLeftLabel.position = CGPoint(x: size.width * 0.5, y: playerHealthBar.position.y)
        // timeLeftLabel.position = CGPoint(x: size.width * 0.5, y: playerHealthBar.position.y * 0.98)
        // New Code End
        // New Code Start
        // timeLeftLabel.zPosition = 5
		timeLeftLabel.zPosition = 50
        // New Code End
		addChild(timeLeftLabel)
		
		timeLeftLabel.fontScale = size.width / timeLeftLabel.width * 0.09
    }
    
    private func createPlayer() {
        // New Code Start
        if playerNode != nil {
            playerNode.delegate = nil
            playerNode.removeAllActions()
            playerNode.removeFromParent()
        }
        // New Code End
        playerNode = PlayerNode(maxEnergy: 5)
        playerNode.position = CGPoint(x: size.width * PlayerConfig.percentX(forStage: stage),
                                      y: size.height * PlayerConfig.percentY(forStage: stage))
        playerNode.setScale(playerNode.percentFitScale(referSize: size, widthPercent: 100,
                                       heightPercent: PlayerConfig.percentHeight(forStage: stage)))
        // New Code Start
        // playerNode.zPosition = 3
        playerNode.zPosition = 30
        // New Code End
        playerNode.delegate = self
        addChild(playerNode)
    }
    
    private func createOpponent() {
        // New Code Start
        if opponentNode != nil {
            opponentNode.delegate = nil
            opponentNode.removeAllActions()
            opponentNode.removeFromParent()
        }
        // New Code End
        opponentNode = OpponentNode(stage: stage)
        opponentNode.position = CGPoint(x: size.width * OpponentConfig.percentX(forStage: stage),
									y: size.height * OpponentConfig.percentY(forStage: stage))
        opponentNode.setScale(opponentNode.percentFitScale(referSize: size, widthPercent: 100,
								 heightPercent: OpponentConfig.percentHeight(forStage: stage)))
        // New Code Start
        // opponentNode.zPosition = 2
        opponentNode.zPosition = 20
        // New Code End
        opponentNode.delegate = self
        addChild(opponentNode)
    }
    
    private func createGameControlLayer() {
		guard let ringSprite = childNode(withName: "ringSprite") as? BKSpriteNode else {
            fatalError("Ring sprite not found.")
        }
		
        // New Code Start
        // delete node is exists
        if gameControlNode != nil {
            gameControlNode.removeAllActions()
            gameControlNode.removeFromParent()
            gameControlNode = nil
        }
        // New Code End
        gameControlNode = GameControlLayerNode(size: ringSprite.frame.size,
						backgroundColor: GameControlConfig.backgroundColor(forStage: stage),
						normalColor: GameControlConfig.normalColor(forStage: stage),
						highlightedColor: GameControlConfig.highlightedColor(forStage: stage),
						controlWidth: GameControlConfig.ControlWidth,
						controlGap: GameControlConfig.ControlGap,
                        ring: ringSprite,
                        touchPadOverlayColor: GameControlConfig.touchPadOverlayColor(forStage: stage))
        // New Code Start
        // gameControlNode.zPosition = 100
        gameControlNode.zPosition = 15
        // New Code End
        gameControlNode.delegate = self
        gameControlNode.isHidden = true
        gameControlNode.isUserInteractionEnabled = false
        addChild(gameControlNode)
    }
    
    private func createCommandDebugNode() {
        guard AppConfig.DebugMode else {
            return
        }
        /*
        commandDebugNode = CommandDebugNode(size: CGSize(width: size.width * 0.2,
                                                         height: size.height * 0.3))
        commandDebugNode!.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        // New Code Start
        // commandDebugNode!.zPosition = 4
        commandDebugNode!.zPosition = 40
        // New Code End
        addChild(commandDebugNode!)
        
        // New Code Start
        // workaround for debug mode
        if commandSequenceHandler != nil {
            commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
        }
        // New Code End*/
    }
    
    // MARK:
    
    private func handleGameCommand() {
        switch commandSequenceHandler.getCurrentCommand() {
        case .attackDamage(damage: let damage):
            attackDamage = damage
            
            commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
            commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
            
            handleGameCommand()
            
        case .opponentAttackSpeed(attackSpeed: let attackSpeed):
            opponentNode.attackSpeed = attackSpeed
            
            commandSequenceHandler.moveToNextCommand(timeLeft: timeLeft)
            commandDebugNode?.addCommand(command: commandSequenceHandler.getCurrentCommand())
            
            handleGameCommand()
            
        case .opponentAttack(type: let type, direction: let direction):
            var onAttack = false
            
            switch (type, direction) {
            case (.punch, .topLeft):
                onAttack = opponentNode.punchTopLeft()
            
            case (.punch, .topRight):
                onAttack = opponentNode.punchTopRight()
                
            case (.punch, .bottomLeft):
                onAttack = opponentNode.punchBottomLeft()
                
            case (.punch, .bottomRight):
                onAttack = opponentNode.punchBottomRight()
                
                // New Code Start
            case (.punch, .s1):
                onAttack = opponentNode.punchS1()

            case (.punch, .s2):
                onAttack = opponentNode.punchS2()

            case (.punch, .s3):
                onAttack = opponentNode.punchS3()

            case (.punch, .s4):
                onAttack = opponentNode.punchS4()

            case (.punch, .s5):
                onAttack = opponentNode.punchS5()
                // New Code End
                
            case (.hook, .topLeft):
                onAttack = opponentNode.hookTopLeft()
                
            case (.hook, .topRight):
                onAttack = opponentNode.hookTopRight()
                
            case (.hook, .bottomLeft):
                onAttack = opponentNode.hookBottomLeft()
                
            case (.hook, .bottomRight):
                onAttack = opponentNode.hookBottomRight()
                
            // New Code Start
            case (.hook, .s1):
                onAttack = opponentNode.hookS1()
                
            case (.hook, .s2):
                onAttack = opponentNode.hookS2()
                
            case (.hook, .s3):
                onAttack = opponentNode.hookS3()
                
            case (.hook, .s4):
                onAttack = opponentNode.hookS4()
                
            case (.hook, .s5):
                onAttack = opponentNode.hookS5()
                // New Code End
            }
            
            if onAttack { AudioHelper.SharedInstance.playOpponentAttackEffect() }
            
        case .opponentBlock(direction: let direction, duration: let duration):
            if opponentActionTime == nil {
                opponentActionTime = duration
                
                switch direction {
                case .top:
                    _ = opponentNode.makeBlockTop()
                    
                case .bottom:
                    _ = opponentNode.makeBlockBottom()
                    
                case .all:
                    _ = opponentNode.makeBlockAll()
                }
            }
            
        case .opponentIdle(kind: let kind, duration: let duration):
            if opponentActionTime == nil {
                opponentActionTime = duration
            
                _ = opponentNode.makeIdle(kind: kind)
            }
            
        case .opponentTired(duration: let duration):
            if opponentActionTime == nil {
                opponentActionTime = duration
            
                _ = opponentNode.makeTired()
            }
        }
    }
    
    private func handleTimeOut() {
        gameStatus = .gameOver
        
        gameControlNode.isHidden = true
        gameControlNode.isUserInteractionEnabled = false
        
        AudioHelper.SharedInstance.playBellEffect()
        AudioHelper.SharedInstance.stopStageMusic(stage: stage)
        
//        showTimeOut()
        animateCrowdEnd(playerWin: false)
        
        let waitAction = SKAction.wait(forDuration: 1)
        run(waitAction) {
            [weak self] in
            
            self?.makeOpponentCelebrate()
        }
    }
    
    private func handleKnockOut() {
        gameStatus = .gameOver
        
        gameControlNode.isHidden = true
        gameControlNode.isUserInteractionEnabled = false
    }
    

	
    private func showKnockOut() {
        let knockOutSprite = BKSpriteNode(imageNamed: "knock_out.png")
        knockOutSprite.setScale(0)
        knockOutSprite.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
        // New Code Start
        // knockOutSprite.zPosition = 9
        knockOutSprite.zPosition = 90
        // New Code End
        addChild(knockOutSprite)
        
        let scaleUpAction = SKAction.scale(to: size.width
            / knockOutSprite.texture!.size().width * 0.5, duration: 0.3)
        let scaleDownAction = SKAction.scale(to: size.width
            / knockOutSprite.texture!.size().width * 0.4, duration: 0.1)
        let waitAction = SKAction.wait(forDuration: 1)
        knockOutSprite.run(SKAction.sequence([scaleUpAction, scaleDownAction, waitAction])) {
            knockOutSprite.removeFromParent()
        }
    }
    
    private func animateCrowdEnd(playerWin: Bool) {
        AudioHelper.SharedInstance.stopCrowdNormalEffect()
        playerWin ? AudioHelper.SharedInstance.playCrowdWinEffect()
                : AudioHelper.SharedInstance.playCrowdLoseEffect()
		
        let crowdAnimTextureNames: [String]
		
		if playerWin {
				crowdAnimTextureNames = [
                    "100_cheer_01.png",
                    "100_cheer_02.png",
                    "100_cheer_03.png",
                    "100_cheer_04.png",
                    "100_cheer_05.png",
                    "100_cheer_06.png",
                    "100_cheer_07.png",
                    "100_cheer_08.png",
                    "100_cheer_09.png",
                    "100_cheer_10.png"
					]
		}
		else {
				crowdAnimTextureNames = [
                    "Sad_01.png",
                    "Sad_02.png",
                    "Sad_03.png",
                    "Sad_04.png",
                    "Sad_05.png",
                    "Sad_06.png",
                    "Sad_07.png",
                    "Sad_08.png",
                    "Sad_09.png",
                    "Sad_10.png",
            ]
					
        }
		
        let crowdAnimTextures = crowdAnimTextureNames.map {
            (textureName) -> SKTexture in
			
			return GameImageCache.SharedInstance.getOpponentTexture(textureName: textureName)!
        }
        
        let animateAction = SKAction.animate(with: crowdAnimTextures, timePerFrame: 0.25)
        crowdAnimSprite.run(SKAction.repeatForever(animateAction))
    }
	
    private func submitScore() {
		let newCumulativeScore = cumulativeScore + Int(timeLeft) * 100 + playerNode.health * 100

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.submitScoreToLeaderboard(score: newCumulativeScore)

        if newCumulativeScore > DataHelper.getBestScore() {
            DataHelper.setBestScore(bestScore: newCumulativeScore)
        }
	}
    
    private func showWinLayer() {
        winLayer = WinLayerNode(size: size, timeLeft: Int(timeLeft),
                                    healthLeft: playerNode.health)
		winLayer.position = CGPoint(x: 0, y: 0)
        // New Code Start
        // winLayer.zPosition = 8
        winLayer.zPosition = 95
        // New Code End
        winLayer.delegate = self
        addChild(winLayer)
		
        winLayer.runEntranceActions()
    }
	
    private func showLoseLayer() {
        loseLayer = LoseLayerNode(size: size, stage: stage)
		loseLayer.position = CGPoint(x: 0, y: 0)
        // New Code Start
        // loseLayer.zPosition = 8
        loseLayer.zPosition = 101
        // New Code End
        loseLayer.delegate = self
        addChild(loseLayer)
		
        loseLayer.runEntranceActions()
    }
    
    private func shakeOpponent() {
        let originalPosition = CGPoint(x: size.width * OpponentConfig.percentX(forStage: stage),
                                       y: size.height * OpponentConfig.percentY(forStage: stage))
        var moveActions = [SKAction]()
        
        for _ in 0..<6 {
            let dx = CGFloat(randomInt(min: -5, max: 5))
            let dy = CGFloat(randomInt(min: -5, max: 5))
            
            let moveAction = SKAction.move(to: CGPoint(x: originalPosition.x + dx,
                                                       y: originalPosition.y + dy), duration: 0.03)
            moveAction.timingMode = .easeInEaseOut
            
            moveActions.append(moveAction)
        }
        
        moveActions.append(SKAction.move(to: originalPosition, duration: 0.03))
        
        opponentNode.run(SKAction.sequence(moveActions))
    }
	
	private func shakeScene() {
		guard let view = view else {
			return
		}				
		
        var values: [Any] = []
		
		for _ in 0..<5 {
			let dx = CGFloat(randomInt(min: -4, max: 4))
            let dy = CGFloat(randomInt(min: -4, max: 4))
			
			values.append(NSValue(caTransform3D:
					CATransform3DTranslate(CATransform3DIdentity, dx, dy, 0)))
        }
		
		let shakeAnimation = CAKeyframeAnimation(keyPath: "transform")
		shakeAnimation.values = values
		shakeAnimation.duration = 0.15
		shakeAnimation.autoreverses = true
		
		view.layer.add(shakeAnimation, forKey: "transform")
    }
	
	private func shakeSceneHorizontal() {
		guard let view = view else {
			return
		}
		
        var values: [Any] = []
        values.append(NSValue(caTransform3D: CATransform3DTranslate(CATransform3DIdentity, -4, 0, 0)))
		values.append(NSValue(caTransform3D: CATransform3DTranslate(CATransform3DIdentity, 4, 0, 0)))
		
		let shakeAnimation = CAKeyframeAnimation(keyPath: "transform")
		shakeAnimation.values = values
		shakeAnimation.duration = 0.06
		shakeAnimation.autoreverses = true
		
		view.layer.add(shakeAnimation, forKey: "transform")
    }
	
    private func makePlayerCelebrate() {
		if !playerNode.celebrate() {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
				[weak self] in
				
				self?.makePlayerCelebrate()
			})
		}
	}
	
	private func makeOpponentCelebrate() {
		if !opponentNode.celebrate() {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
				[weak self] in
				
				self?.makeOpponentCelebrate()
			})
		}
	}
	
	private func showBannerAd() {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showBannerAd()
	}
	
	private func hideBannerAd() {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.hideBannerAd()
	}
	
	private func reopenGameStage() {
        // New Code Start
        setFinishState()
        self.openFor(stage: stage, cumulativeScore: cumulativeScore)
        // code below does not needed
        /*
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
//                cumulativeScore: cumulativeScore)
//        nextScene.scaleMode = .aspectFill
        // New Code End
        
        // New Code Start
        // use common constant
        let transition = SKTransition.fade(withDuration: AppConfig.FadeDuration)
        // let transition = SKTransition.fade(withDuration: 0.3)
        // New Code End
        view.presentScene(nextScene, transition: transition)
        */
        // New Code End
	}
	
	private func openMainMenu() {
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
    
    private func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                     selector: #selector(didTriggerTimer), userInfo: nil, repeats: true)
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func didTriggerTimer() {
        guard let timer = timer else {
            return
        }
        
        guard timer.isValid else {
            return
        }
        
        if gameStatus == .play && timeLeft > 0 {
            timeLeft -= 0.1
            
            timeLeftLabel.text = "\(Int(timeLeft))"
            
            if (timeLeft <= 0) {
                stopTimer()
                
                handleTimeOut()
            }
        }
    }
    
    // MARK:
    
    private func onClickPlayStage(sender: ButtonNode) {
        // New Code Start
        // sender.removeFromParent()
        playStageButton.isHidden = true
        playStageWholeScreenButton.isHidden = true
        // New Code End

        if gameStatus == .awaitTap {
            gameStatus = .play
            
            AudioHelper.SharedInstance.playBellEffect()
            
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.3)
            darkOverlayNode.run(fadeOutAction, completion: {
                [weak self] in
                
                self?.gameControlNode.isHidden = false
                self?.gameControlNode.isUserInteractionEnabled = true
                
                self?.startTimer()
            })
        }
    }
    
    // New Code Start
    // handle touches and provide them to Control Node if needed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let touchLocation = t.location(in: self)
            if !gameControlNode.isHidden &&
                gameControlNode.isUserInteractionEnabled &&
                gameControlNode.frame.contains(touchLocation) {
                gameControlNode.touchesBegan(touches, with: event)
                break
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let touchLocation = t.location(in: self)
            if !gameControlNode.isHidden &&
                gameControlNode.isUserInteractionEnabled &&
                gameControlNode.frame.contains(touchLocation) {
                gameControlNode.touchesEnded(touches, with: event)
                break
            }
        }
    }
    // New Code End

}
