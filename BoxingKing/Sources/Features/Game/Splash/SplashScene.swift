import SpriteKit


// MARK: -

class SplashScene: SKScene {
	
    // MARK:
	
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
	
    override init(size: CGSize) {
        super.init(size:size)
		
        createBackground()
    }
	
    // MARK:
	
    override func didMove(to view: SKView) {
        super.didMove(to: view)
		
        // New code start
        // AudioHelper.SharedInstance.playIntroEffect()
        // New code end

        runEntranceActions()		        
    }
	
    // MARK:
	
    private func createBackground() {
        // New code start
        self.backgroundColor = .black
        // Use this screen as the same as iOS splash, and fade out it
        let backgroundTextureName = "logo"
        // let backgroundTextureName = UIDevice.current.userInterfaceIdiom == .pad ?
        //         "bg_splash~ipad.png" : "bg_splash.png"
        // New code end
        let backgroundSprite = BKSpriteNode(imageNamed: backgroundTextureName)
        backgroundSprite.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        // New Code Start
        //backgroundSprite.size = CGSize(width: 258, height: 192)
          let scale = 258 /  backgroundSprite.texture!.size().width
          backgroundSprite.xScale = scale
          backgroundSprite.yScale = scale
//        backgroundSprite.xScale = size.width / backgroundSprite.texture!.size().width
//        backgroundSprite.yScale = size.height / backgroundSprite.texture!.size().height
        // New Code End
        backgroundSprite.zPosition = 0
        addChild(backgroundSprite)
    }
	
    // MARK:
	
    private func runEntranceActions() {
        // New code start
        // shorter wait
		let waitAction = SKAction.wait(forDuration: 0.1)
        // let waitAction = SKAction.wait(forDuration: 0.5)
        // New code End
        run(waitAction) {
            [weak self] in
			
            self?.openMainMenu()
        }
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
        // New Code Start

        // New Code Start
        // use common constant
        let transition = SKTransition.fade(withDuration: AppConfig.FadeDuration)
        // let transition = SKTransition.fade(withDuration: 0.3)
        // New Code End
        view.presentScene(nextScene, transition: transition)
	}
}
