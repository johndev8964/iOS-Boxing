import SpriteKit


class PickStageScene: SKScene {
    
    // MARK:
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    override init(size: CGSize) {
        super.init(size:size)
        
        createBackground()
        
        createStageButtons()
        createFinalButton()
        createBackButton()
    }
    
    // MARK:
    
    private func createBackground() {
        let backgroundTextureName = "bg_pick_stage.png"
        let backgroundSprite = BKSpriteNode(imageNamed: backgroundTextureName)
        backgroundSprite.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        backgroundSprite.xScale = size.width / backgroundSprite.texture!.size().width
        backgroundSprite.yScale = size.height / backgroundSprite.texture!.size().height
        backgroundSprite.zPosition = 0
        addChild(backgroundSprite)
    }
    
    private func createStageButtons() {
        for i in 0..<9 {
            let stageButton = ButtonNode(imageNamed: "btn_stage_\(i + 1).png")
            stageButton.position = CGPoint(x: size.width * (0.25 + CGFloat(i % 3) * 0.25),
                                           y: size.height * (0.6 - CGFloat(i / 3) * 0.15))
            stageButton.setScale(stageButton.percentFitScale(referSize: size,
                                             widthPercent: 0.18, heightPercent: 0.12))
            stageButton.zPosition = 5
            stageButton.name = "stage\(i + 1)Button"
            stageButton.clickHandler = { [weak self] in self?.onClickStage(sender: $0) }
            addChild(stageButton)
        }
    }
    
    private func createFinalButton() {
        let finalButton = ButtonNode(imageNamed: "btn_final.png")
        finalButton.anchorPoint = CGPoint(x: 1, y: 1)
        finalButton.position = CGPoint(x: size.width * 0.94, y: size.height * 0.96)
        finalButton.setScale(finalButton.percentFitScale(referSize: size,
                                             widthPercent: 0.18, heightPercent: 0.12))
        finalButton.zPosition = 5
        finalButton.clickHandler = { [weak self] in self?.onClickFinal(sender: $0) }
        addChild(finalButton)
    }
    
    private func createBackButton() {
        let backButton = ButtonNode(imageNamed: "btn_back.png")
        backButton.anchorPoint = CGPoint(x: 0, y: 1)
        backButton.position = CGPoint(x: size.width * 0.06, y: size.height * 0.95)
        backButton.setScale(backButton.percentFitScale(referSize: size,
                                                     widthPercent: 0.18, heightPercent: 0.12))
        backButton.zPosition = 5
        backButton.clickHandler = { [weak self] in self?.onClickBack(sender: $0) }
        addChild(backButton)
    }
    
    // MARK:
    
    func onClickStage(sender: ButtonNode) {
        guard let view = view else {
            return
        }
        
        guard let buttonName = sender.name else {
            return
        }
        
        let stage: Int
        
        switch buttonName {
        case "stage1Button":
            stage = 1
        case "stage2Button":
            stage = 2
        case "stage3Button":
            stage = 3
        case "stage4Button":
            stage = 4
        case "stage5Button":
            stage = 5
        case "stage6Button":
            stage = 6
        case "stage7Button":
            stage = 7
        case "stage8Button":
            stage = 8
        case "stage9Button":
            stage = 9
        default:
            stage = 1
        }
        
        // New Code Start
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let nextScene = appDelegate.getScene(kind: .loadStage, size: view.bounds.size)
        if let scene = nextScene as? LoadStageScene {
            scene.openFor(stage: stage, cumulativeScore: 0)
        }
        // let nextScene = LoadStageScene(size: view.bounds.size, stage: stage, cumulativeScore: 0)
        // New Code End
        nextScene.scaleMode = .aspectFill
        
        // New Code Start
        // use common constant
        let transition = SKTransition.fade(withDuration: AppConfig.FadeDuration)
        // let transition = SKTransition.fade(withDuration: 0.3)
        // New Code End
        view.presentScene(nextScene, transition: transition)
    }
    
    func onClickFinal(sender: ButtonNode) {
        guard let view = view else {
            return
        }
        
        let nextScene = FinalScene(size: view.bounds.size)
        nextScene.scaleMode = .aspectFill
        
        // New Code Start
        // use common constant
        let transition = SKTransition.fade(withDuration: AppConfig.FadeDuration)
        // let transition = SKTransition.fade(withDuration: 0.3)
        // New Code End
        view.presentScene(nextScene, transition: transition)
    }
    
    func onClickBack(sender: ButtonNode) {
        guard let view = view else {
            return
        }
        
        // New Code Start
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
