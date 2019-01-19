import SpriteKit


// MARK: -

class FinalScene: SKScene {
    
    // MARK:
    var playerNode: PlayerNode?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    override init(size: CGSize) {
        super.init(size:size)
        
        // New Code Start
        createBackground()
        createCrowdAnim()
        createPlayer()
        // New Code End
        
        createRateButton()
        createShareButton()
        createBackButton()
    }
    
    // MARK:
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // AudioHelper.SharedInstance.playFinalMusic()
        AudioHelper.SharedInstance.playChampionMusic()

        // New Code Start
        addConfetti()
        champion()
        // New Code End
    }
    
    override func willMove(from view: SKView) {
        // AudioHelper.SharedInstance.stopFinalMusic()
        AudioHelper.SharedInstance.stopChampionMusic()
        
        super.willMove(from: view)
    }
    
    // MARK:
    
    private func createBackground() {

        GameImageCache.SharedInstance.preloadOpponentAtlas(forStage: 9)
        if let previous = self.childNode(withName: "crowdSprite") {
            previous.removeAllActions()
            previous.removeFromParent()
        }
        let crowdTextureName = "crowd.png"
        let crowdSprite = BKSpriteNode(texture: GameImageCache.SharedInstance
            .getOpponentTexture(textureName: crowdTextureName))
        crowdSprite.anchorPoint = CGPoint(x: 0.5, y: 1)
        crowdSprite.position = CGPoint(x: size.width * 0.5, y: size.height)
        crowdSprite.xScale = size.width / crowdSprite.texture!.size().width
        crowdSprite.zPosition = 0
        crowdSprite.name = "crowdSprite"
        addChild(crowdSprite)
        
        if let previous = self.childNode(withName: "ringSprite") {
            previous.removeAllActions()
            previous.removeFromParent()
        }
        let ringTextureName = "ring.png"
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
        let playerNode = PlayerNode(maxEnergy: 5)
        playerNode.texture = SKTexture(image: UIImage(named: "celebrate.png")!)
        playerNode.position = CGPoint(x: size.width * PlayerConfig.percentX(forStage: 9),
                                      y: size.height * PlayerConfig.percentY(forStage: 9))
        playerNode.setScale(playerNode.percentFitScale(referSize: size, widthPercent: 100,
                                                       heightPercent: PlayerConfig.percentHeight(forStage: 9)))
        playerNode.zPosition = 30
        addChild(playerNode)
        
        self.playerNode = playerNode
    }
    
    private func champion() {
            if let t0 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_0.png"),
                let t1 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_1.png"),
                let t2 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_2.png"),
                let t3 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_3.png"),
                let t4 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_4.png"),
                let t5 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_5.png"),
                let t6 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_6.png"),
                let t7 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_7.png"),
                let t8 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_8.png"),
                let t9 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_9.png"),
                let t10 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_10.png"),
                let t11 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_11.png"),
                let t12 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_12.png"),
                let t13 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_13.png"),
                let t14 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_14.png"),
                let t15 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_15.png"),
                let t16 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_16.png"),
                let t17 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_17.png"),
                let t18 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_18.png"),
                let t19 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_19.png"),
                let t20 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_20.png"),
                let t21 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_21.png"),
                let t22 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_22.png"),
                let t23 = GameImageCache.SharedInstance.getPlayerTexture(textureName: "champion_23.png")
        
        
        {
            let action = SKAction.animate(with: [t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21, t22, t23], timePerFrame: 0.1)
            
            playerNode?.run(action)
        }
    }
    
    private func createCrowdAnim() {
        guard let crowdSprite = childNode(withName: "crowdSprite") else {
            return
        }
        
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
                "100_cheer_10.png"
            ]
        let crowdAnimTextures = crowdAnimTextureNames.map {
            (textureName) -> SKTexture in
            
            return GameImageCache.SharedInstance.getOpponentTexture(textureName: textureName)!
        }
        
        let animateAction = SKAction.animate(with: crowdAnimTextures, timePerFrame: 0.25)
        crowdSprite.run(SKAction.repeatForever(animateAction))
    }
    // New Code End

    private func createRateButton() {
        let rateButton = ButtonNode(imageNamed: "btn_rate.png")
        rateButton.position = CGPoint(x: size.width * 0.86, y: size.height * 0.09)
        rateButton.setScale(rateButton.percentFitScale(referSize: size,
                                                 widthPercent: 0.21, heightPercent: 0.15))
        rateButton.zPosition = 5000
        rateButton.clickHandler = { [weak self] in self?.onClickRate(sender: $0) }
        addChild(rateButton)
    }
    
    private func createShareButton() {
        let shareButton = ButtonNode(imageNamed: "btn_share.png")
        shareButton.position = CGPoint(x: size.width * 0.14, y: size.height * 0.09)
        shareButton.setScale(shareButton.percentFitScale(referSize: size,
                                                   widthPercent: 0.21, heightPercent: 0.15))
        shareButton.zPosition = 5000
        shareButton.clickHandler = { [weak self] in self?.onClickShare(sender: $0) }
        addChild(shareButton)
    }
    
    private func createBackButton() {
        let backButton = ButtonNode(imageNamed: "btn_back.png")
        backButton.anchorPoint = CGPoint(x: 0, y: 1)
        backButton.position = CGPoint(x: size.width * 0.06, y: size.height * 0.95)
        backButton.setScale(backButton.percentFitScale(referSize: size,
                                             widthPercent: 0.18, heightPercent: 0.12))
        backButton.zPosition = 5000
        backButton.clickHandler = { [weak self] in self?.onClickBack(sender: $0) }
        addChild(backButton)
    }
    
    // MARK:
    
    private func onClickRate(sender: ButtonNode) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.openRateUrl()
    }
    
    private func onClickShare(sender: ButtonNode) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.shareApp(final: true)
    }
    
    private func onClickBack(sender: ButtonNode) {
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
    
    // New Code Start
    
    let emitter = SKEmitterNode(fileNamed: "confetti")
    let colors = [SKColor.white, SKColor.yellow, SKColor.green, SKColor.red,
                  SKColor.blue, SKColor.orange, SKColor.cyan, SKColor.magenta, SKColor.purple ]
    
    private func addConfetti() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        
        emitter!.position = CGPoint(x: self.size.width/2.0, y:self.size.height)
        
        emitter!.particleColorSequence = nil
        emitter!.particleColorBlendFactor = 1.0
        emitter?.zPosition = 500
        
        self.addChild(emitter!)
        
        let action = SKAction.run({
            [unowned self] in
            let random = Int(arc4random_uniform(UInt32(self.colors.count)))
            
            self.emitter!.particleColor = self.colors[random];
        })
        
        let wait = SKAction.wait(forDuration: 0.1)
        
        self.run(SKAction.repeatForever( SKAction.sequence([action,wait])))
    }
    
    // New Code End
    
}
