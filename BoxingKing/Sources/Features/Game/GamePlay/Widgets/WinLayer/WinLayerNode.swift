import SpriteKit


// MARK: -

class WinLayerNode: SKShapeNode, ScoreBoardDelegate {
    weak var delegate: WinLayerDelegate?

	private let size: CGSize
    private var scoreBoard: ScoreBoardNode!
    private var nextButton: ButtonNode!
    private var nextWholeScreenButton: ButtonNode!
	private var shareButton: ButtonNode!
	private var rateButton: ButtonNode!

    // MARK:

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }

    required init(size: CGSize, timeLeft: Int, healthLeft: Int) {
		self.size = size
		
        super.init()

        let path = CGMutablePath()
		path.addLines(between: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: size.width, y: 0),
                CGPoint(x: size.width, y: size.height),
                CGPoint(x: 0, y: size.height),
                CGPoint(x: 0, y: 0)
            ])

        self.path = path
        fillColor = UIColor.clear
        strokeColor = UIColor.clear
        lineWidth = 1
        lineCap = .round
        lineJoin = .round
        isAntialiased = true
        isUserInteractionEnabled = true
		
        createScoreBoard(timeLeft: timeLeft, healthLeft: healthLeft)
        createShareButton()
        createRateButton()
        createNextButton()
    }
	
    // MARK:
	
    func scoreBoardDidChangeTimeLeft(_ sender: ScoreBoardNode, timeLeft: Int) {
		delegate?.winLayerDidChangeTimeLeft(self, timeLeft: timeLeft)
	}
	
	func scoreBoardDidChangeHealthLeft(_ sender: ScoreBoardNode, healthLeft: Int) {
		delegate?.winLayerDidChangeHealthLeft(self, healthLeft: healthLeft)
	}
	
	func scoreBoardDidFinishCalculation(_ sender: ScoreBoardNode) {
		AudioHelper.SharedInstance.playCalculateEndEffect()
        AudioHelper.SharedInstance.stopCalculateEffect()        
	}
	
    // MARK:
	
    func runEntranceActions() {
		let colorComponents = AppConfig.WinOverlayColor.cgColor.components
		let overlayFadeInAction = SKAction.customAction(withDuration: 0.3) {
			(node, elapsedTime) in

			let fraction = CGFloat(elapsedTime / CGFloat(0.3))
			let transColor = UIColor(red: colorComponents![0] * fraction,
							 green: colorComponents![1] * fraction,
							 blue: colorComponents![2] * fraction,
							 alpha: colorComponents![3] * fraction * AppConfig.WinOverlayStrength)
			(node as! SKShapeNode).fillColor = transColor
		}
		run(overlayFadeInAction) {
			[weak self] in
			
			guard let size = self?.size else {
				return
			}
			
			let scoreBoardMoveAction = SKAction.moveTo(y: size.height * 0.83, duration: 0.3)
			scoreBoardMoveAction.timingMode = .easeOut
			
			self?.scoreBoard.run(scoreBoardMoveAction) {
				[weak self] in
				
				AudioHelper.SharedInstance.playCalculateEffect()
				
				self?.scoreBoard.calculateTotalScore()
			}
			
			let playButtonMoveAction = SKAction.moveTo(y: size.height * 0.09, duration: 0.3)
			playButtonMoveAction.timingMode = .easeOut
			self?.nextButton.run(playButtonMoveAction)
		
			let shareButtonMoveAction = SKAction.moveTo(y: size.height * 0.09, duration: 0.3)
			shareButtonMoveAction.timingMode = .easeOut
			self?.shareButton.run(shareButtonMoveAction)
			
			let rateButtonMoveAction = SKAction.moveTo(y: size.height * 0.09, duration: 0.3)
			rateButtonMoveAction.timingMode = .easeOut
			self?.rateButton.run(rateButtonMoveAction)
		}
	}

    // MARK:

    private func createScoreBoard(timeLeft: Int, healthLeft: Int) {
        
        // Added By Blake -- Issue 3
        
        var yCor: CGFloat = 1.1;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            yCor = 0.8;
        }
        scoreBoard = ScoreBoardNode(timeLeft: timeLeft, healthLeft: healthLeft)
        scoreBoard.setScale(scoreBoard.percentFitScale(referSize: size,
                                           widthPercent: 0.44, heightPercent: 0.22) * yCor)
        
        
        
        scoreBoard.position = CGPoint(x: size.width * 0.5,
                                      y: size.height + scoreBoard.size.height / 2)
        scoreBoard.zPosition = 1
        scoreBoard.delegate = self
        addChild(scoreBoard)
    }
	
    private func createShareButton() {
        shareButton = ButtonNode(imageNamed: "btn_share.png")
        shareButton.position = CGPoint(x: size.width * 0.14, y: size.height * -0.1)
        shareButton.setScale(shareButton.percentFitScale(referSize: size,
                                                         widthPercent: 0.21, heightPercent: 0.15))
        // New Code Start
        shareButton.zPosition = 50
        // New Code End
        shareButton.clickHandler = { [weak self] in self?.onClickShare(sender: $0) }
        addChild(shareButton)
    }
	
    private func createRateButton() {
        rateButton = ButtonNode(imageNamed: "btn_rate.png")
        rateButton.position = CGPoint(x: size.width * 0.86, y: size.height * -0.1)
        rateButton.setScale(rateButton.percentFitScale(referSize: size,
                                                         widthPercent: 0.21, heightPercent: 0.15))
        // New Code Start
        rateButton.zPosition = 50
        // New Code End
        rateButton.clickHandler = { [weak self] in self?.onClickRate(sender: $0) }
        addChild(rateButton)
    }
	
    private func createNextButton() {
		guard shareButton != nil else {
			fatalError("Share button not found.")
		}
		
        nextButton = ButtonNode(imageNamed: "finger.png")
        nextButton.position = CGPoint(x: size.width * 0.5, y: size.height * -0.1)
        nextButton.setScale(shareButton.frame.height / nextButton.texture!.size().height)
        // New Code Start
        nextButton.zPosition = 50
        let image0 = UIImage(named: "finger.png")
        let image1 = UIImage(named: "finger_tap.png")
        let textures = [SKTexture(image: image0!), SKTexture(image: image1!)]
        let animateAction = SKAction.animate(with: textures, timePerFrame: 0.5)
        nextButton.run(SKAction.repeatForever(animateAction))
        // New Code End
        nextButton.clickHandler = { [weak self] in self?.onClickNext(sender: $0) }
        addChild(nextButton)
        
        // New Code Start
        nextWholeScreenButton = ButtonNode(color: .clear, size: size)
        nextWholeScreenButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        nextWholeScreenButton.zPosition = 49
        nextWholeScreenButton.clickHandler = { [weak self] in self?.onClickNext(sender: $0) }
        addChild(nextWholeScreenButton)
        // New Code End
    }
	
    // MARK:
	
    private func onClickNext(sender: ButtonNode) {
		AudioHelper.SharedInstance.stopCalculateEffect()
		
        delegate?.winLayerDidClickNext(self)
    }
	
    private func onClickShare(sender: ButtonNode) {
        delegate?.winLayerDidClickShare(self)
    }
	
    private func onClickRate(sender: ButtonNode) {
        delegate?.winLayerDidClickRate(self)
    }
}
