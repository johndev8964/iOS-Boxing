import SpriteKit


// MARK: -

class ContinueMenuNode: SKShapeNode, TimerBarDelegate {
	weak var delegate: ContinueMenuDelegate?
	
	private let size: CGSize
    // New Code Start
    private let stage: Int
    // New Code End

    private var continueCountLabel: SKLabelNode!
    private var timerBar: TimerBarNode!
	
    // MARK:
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(size: CGSize, stage: Int) {
    	self.size = size
        self.stage = stage

        super.init()
		
        // New Code Start
       if stage == 1 {
            createFreeContinueButton()
        } else {
        // New Code End
            createWatchAdButton()
            createContinueButton()
            createContinueCountLabel()
        }
        createBackButton()
        createTimerBar()
    }
	
    // MARK:
	
    func countdown() {
        timerBar.countdown(duration: 5)
    }
	
    func updateContinueCount() {
		continueCountLabel.text = "\(DataHelper.getContinueCount())"
	}
    
    // MARK:
    
    private func createWatchAdButton() {
        let watchAdButton = ButtonNode(imageNamed: "btn_watch_ad.png")
        watchAdButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.6)
        watchAdButton.setScale(watchAdButton.percentFitScale(referSize: size,
                                                     widthPercent: 0.46, heightPercent: 0.28))
        watchAdButton.zPosition = 5
        watchAdButton.clickHandler = { [weak self] in self?.onClickWatchAd(sender: $0) }
        addChild(watchAdButton)
    }
    
    private func createContinueButton() {
        let continueButton = ButtonNode(imageNamed: "btn_continue.png")
        continueButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
        continueButton.setScale(continueButton.percentFitScale(referSize: size,
                                                     widthPercent: 0.46, heightPercent: 0.28))
        continueButton.zPosition = 5
        continueButton.clickHandler = { [weak self] in self?.onClickContinue(sender: $0) }
        continueButton.name = "continueButton"
        addChild(continueButton)
    }
    
    // New Code Start
    private func createFreeContinueButton() {
        let continueButton = ButtonNode(imageNamed: "btn_replay.png")
        continueButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        continueButton.setScale(continueButton.percentFitScale(referSize: size,
                                                               widthPercent: 0.46, heightPercent: 0.28))
        continueButton.zPosition = 5
        continueButton.clickHandler = { [weak self] in self?.onClickFreeContinue(sender: $0) }
        continueButton.name = "freeContinueButton"
        addChild(continueButton)
    }
    // New Code End

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
    
    private func createContinueCountLabel() {
        guard let continueNode = childNode(withName: "continueButton") else {
            fatalError("Continue button not created.")
        }
        
        let continueButton = continueNode as! ButtonNode
        
        continueCountLabel = SKLabelNode(text: "00")
        // New Code Start
        // continueCountLabel.fontName = "Jeebz Bold"
        continueCountLabel.fontName = "ArcadeClassic"
        // New Code End
        continueCountLabel.fontColor = UIColor.yellow
        continueCountLabel.verticalAlignmentMode = .center
        continueCountLabel.position = CGPoint(x: 0, y: 0)
        continueCountLabel.zPosition = 6
        
        
        
        continueButton.addChild(continueCountLabel)
        
        continueCountLabel.fontSize *= continueButton.texture!.size().width
            / continueCountLabel.frame.width * 0.25
        continueCountLabel.text = "\(DataHelper.getContinueCount())"
    }
    
    private func createTimerBar() {
        timerBar = TimerBarNode()
        timerBar.setScale(size.width / timerBar.texture!.size().width * 0.42)
        timerBar.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
        timerBar.zPosition = 6
        timerBar.delegate = self
        addChild(timerBar)
    }
    
    // MARK:
    
    func timerBarDidFinishCountdown(_ sender: TimerBarNode) {
		delegate?.continueMenuDidFinishCountdown(self)
    }
    
    // MARK:
    
    private func onClickWatchAd(sender: ButtonNode) {
        timerBar.stopCountdown()
        
        delegate?.continueMenuDidClickWatchAd(self)
    }
    
    private func onClickContinue(sender: ButtonNode) {
        timerBar.stopCountdown()
        
        delegate?.continueMenuDidClickContinue(self)
    }
    
    // New Code Start
    private func onClickFreeContinue(sender: ButtonNode) {
        timerBar.stopCountdown()
        
        delegate?.continueMenuDidClickContinue(self)
    }
    // New Code End

    private func onClickBack(sender: ButtonNode) {
        delegate?.continueMenuDidClickBack(self)
    }
}
