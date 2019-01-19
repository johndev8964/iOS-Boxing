import SpriteKit


// MARK: -

class ScoreBoardNode: BKSpriteNode {
    weak var delegate: ScoreBoardDelegate?
    
    private var timeLeft = 0
    private var healthLeft = 0
    private var totalScore = 0
    
    private var timer: Timer?
    
    // New Code Start
    private var timeLeftLabel: NumberLabelNode!
    private var healthLeftLabel: NumberLabelNode!
    private var totalScoreLabel: NumberLabelNode!
    // private var timeLeftLabel: SKLabelNode!
    // private var healthLeftLabel: SKLabelNode!
    // private var totalScoreLabel: SKLabelNode!

    private var useScale: CGFloat = 1
// New Code End
    
    // MARK:
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(timeLeft: Int, healthLeft: Int) {
        // New Code Start
        // use image instead of imageNamed
        // let texture = SKTexture(imageNamed: "score_board.png")
        let image = UIImage(named: "score_board.png")
        let texture = SKTexture(image: image!)
        // New Code End
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.timeLeft = timeLeft
        self.healthLeft = healthLeft
		
        createTotalScoreLabel()
        createTimeMultiplierLabel()
        createHealthMultiplierLabel()
        createTimeLeftLabel()
        createHealthLeftLabel()
		
        createTimeIcon()
        createHealthIcon()
        createTotalIcon()
    }
    
    deinit {
        stopTimer()
    }
    
    // MARK:
    
    func calculateTotalScore() {
        startTimer()
    }
    
    // MARK:
    
    private func createTotalScoreLabel() {
        // New Code Start
		totalScoreLabel = NumberLabelNode(fontType: .Red)
        // totalScoreLabel = SKLabelNode()
        // New Code End
		totalScoreLabel.text = "000000000"
        // New Code Start
		totalScoreLabel.horizontalAlignment = .Right
        // totalScoreLabel.horizontalAlignmentMode = .right
        // totalScoreLabel.fontName = "ArcadeClassic"
        // totalScoreLabel.fontColor = .yellow
        // totalScoreLabel.fontSize = 110
		// totalScoreLabel.position = CGPoint(x: size.width * 0.45, y: size.height * -0.38)
//        var yCor: CGFloat = 0;
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
//            yCor = -12;
//        }
        
        totalScoreLabel.position = CGPoint(x: size.width * 0.45, y: size.height * -0.3)
        // New Code End
		totalScoreLabel.zPosition = 1
		addChild(totalScoreLabel)
		
        // 
        useScale = texture!.size().width / totalScoreLabel.width * 0.82
		totalScoreLabel.fontScale = useScale
		totalScoreLabel.text = "\(totalScore)"
    }
	
    private func createTimeMultiplierLabel() {
        // New Code Start
		let timeMultiplierLabel = NumberLabelNode(fontType: .Green)
        // let timeMultiplierLabel = SKLabelNode()
        // New Code End
		timeMultiplierLabel.text = " * 100"
        // New Code Start
        // timeMultiplierLabel.horizontalAlignmentMode = .right
        // timeMultiplierLabel.fontName = "ArcadeClassic"
        // timeMultiplierLabel.fontColor = .green
        // timeMultiplierLabel.fontSize = 110
        timeMultiplierLabel.fontScale = useScale
        timeMultiplierLabel.horizontalAlignment = .Right
        timeMultiplierLabel.position = CGPoint(x: size.width * 0.45, y: size.height * 0.3)
		// timeMultiplierLabel.position = CGPoint(x: size.width * 0.45, y: size.height * 0.22)
        // New Code End
        timeMultiplierLabel.zPosition = 1
        timeMultiplierLabel.name = "timeMultiplierLabel"
        addChild(timeMultiplierLabel)
	}
	
	private func createHealthMultiplierLabel() {
        // New Code Start
		let healthMultiplierLabel = NumberLabelNode(fontType: .Green)
        // let healthMultiplierLabel = SKLabelNode()
        // New Code End
		healthMultiplierLabel.text = " * 100"
        // healthMultiplierLabel.horizontalAlignmentMode = .right
        // healthMultiplierLabel.fontName = "ArcadeClassic"
        // healthMultiplierLabel.fontColor = .green
        // healthMultiplierLabel.fontSize = 110
        // New Code Start
		healthMultiplierLabel.fontScale = useScale
		healthMultiplierLabel.horizontalAlignment = .Right
        healthMultiplierLabel.position = CGPoint(x: size.width * 0.45, y: 0)
		// healthMultiplierLabel.position = CGPoint(x: size.width * 0.45, y: size.height * -0.08)
        // New Code End
        healthMultiplierLabel.zPosition = 1
        healthMultiplierLabel.name = "healthMultiplierLabel"
        addChild(healthMultiplierLabel)
	}
	
    private func createTimeLeftLabel() {
		guard let timeMultiplierNode = childNode(withName: "timeMultiplierLabel") else {
			fatalError("Time multiplier label not found.")
		}
		// New Code Start
		let timeMultiplierLabel = timeMultiplierNode as! NumberLabelNode
        // let timeMultiplierLabel = timeMultiplierNode as! SKLabelNode

		timeLeftLabel = NumberLabelNode(fontType: .Yellow)
        // timeLeftLabel = SKLabelNode()
        // New Code End
		timeLeftLabel.text = "\(timeLeft)"
        // New Code Start
        // timeLeftLabel.horizontalAlignmentMode = .right
        // timeLeftLabel.fontName = "ArcadeClassic"
        // timeLeftLabel.fontColor = .red
        // timeLeftLabel.fontSize = 110
        timeLeftLabel.fontScale = useScale
        timeLeftLabel.horizontalAlignment = .Right
        timeLeftLabel.position =
         CGPoint(x: timeMultiplierLabel.position.x - timeMultiplierLabel.width,
                y: timeMultiplierLabel.position.y)
		// timeLeftLabel.position =
		// 		CGPoint(x: timeMultiplierLabel.position.x - timeMultiplierLabel.frame.width,
		// 		        y: timeMultiplierLabel.position.y)
        // New Code End
        timeLeftLabel.zPosition = 1
        addChild(timeLeftLabel)
    }
	
    private func createHealthLeftLabel() {
		guard let healthMultiplierNode = childNode(withName: "healthMultiplierLabel") else {
			fatalError("Health multiplier label not found.")
		}
		
        // New Code Start
		let healthMultiplierLabel = healthMultiplierNode as! NumberLabelNode
        // let healthMultiplierLabel = healthMultiplierNode as! SKLabelNode

		healthLeftLabel = NumberLabelNode(fontType: .Yellow)
        // healthLeftLabel = SKLabelNode()
        // New Code End
		healthLeftLabel.text = "\(healthLeft)"
        // New Code Start
        // healthLeftLabel.horizontalAlignmentMode = .right
        // healthLeftLabel.fontName = "ArcadeClassic"
        // healthLeftLabel.fontColor = .red
        // healthLeftLabel.fontSize = 110
        healthLeftLabel.fontScale = useScale
        healthLeftLabel.horizontalAlignment = .Right
        healthLeftLabel.position =
            CGPoint(x: healthMultiplierLabel.position.x - healthMultiplierLabel.width,
                    y: healthMultiplierLabel.position.y)
		// healthLeftLabel.position =
		// 		CGPoint(x: healthMultiplierLabel.position.x - healthMultiplierLabel.frame.width,
		// 		        y: healthMultiplierLabel.position.y)
        // New Code End
        healthLeftLabel.zPosition = 1
        addChild(healthLeftLabel)
    }
	
    private func createTimeIcon() {
		let iconSprite = BKSpriteNode(imageNamed: "ic_time.png")
        iconSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
        iconSprite.position = CGPoint(x: size.width * -0.45, y: size.height * 0.3)
        iconSprite.setScale(texture!.size().width / iconSprite.texture!.size().width * 0.14)
        iconSprite.zPosition = 1
        addChild(iconSprite)
	}
	
	private func createHealthIcon() {
		let iconSprite = BKSpriteNode(imageNamed: "ic_health.png")
        iconSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
        iconSprite.position = CGPoint(x: size.width * -0.45, y: 0)
        iconSprite.setScale(texture!.size().width / iconSprite.texture!.size().width * 0.14)
        iconSprite.zPosition = 1
        addChild(iconSprite)
	}
	
	private func createTotalIcon() {
		let iconSprite = BKSpriteNode(imageNamed: "ic_total.png")
        iconSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
        iconSprite.position = CGPoint(x: size.width * -0.45, y: size.height * -0.3)
        iconSprite.setScale(texture!.size().width / iconSprite.texture!.size().width * 0.14)
        iconSprite.zPosition = 1
        addChild(iconSprite)
	}
    
    // MARK:
    
    private func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self,
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
        
        if timeLeft > 0 {
            timeLeft -= 1
            totalScore += 100
            
            timeLeftLabel.text = "\(timeLeft)"
            totalScoreLabel.text = "\(totalScore)"
			
            delegate?.scoreBoardDidChangeTimeLeft(self, timeLeft: timeLeft)
        }
        else if healthLeft > 0 {
            healthLeft -= 1
            totalScore += 100
            
            healthLeftLabel.text = "\(healthLeft)"
            totalScoreLabel.text = "\(totalScore)"
			
			delegate?.scoreBoardDidChangeHealthLeft(self, healthLeft: healthLeft)
        }
        else {
            stopTimer()
            
            delegate?.scoreBoardDidFinishCalculation(self)
        }
    }
}
