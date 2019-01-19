import SpriteKit


// MARK: -

class LoseLayerNode: SKShapeNode, ContinueMenuDelegate, PurchaseMenuDelegate {
	weak var delegate: LoseLayerDelegate?
	
	private let size: CGSize
    // New Code Start
    private let stage: Int
    // New Code End

	private var continueMenuNode: ContinueMenuNode!
	private var purchaseMenuNode: PurchaseMenuNode!
    private var noInternetButton: ButtonNode!
    private var noVideoButton: ButtonNode!
    private var darkOverlayNode: SKShapeNode!
	private var activityIndicator: UIActivityIndicatorView!
	
    // MARK:
	
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
	
    required init(size: CGSize, stage: Int) {
    	self.size = size
        self.stage = stage

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
		
        // New Code Start
        createContinueMenuNode(stage: stage)
        // New Code End
        createPurchaseMenuNode()
        createNoInternetButton()
        createNoVideoButton()
		createDarkOverlayNode()
		
        NotificationCenter.default.addObserver(self, selector: #selector(onWatchAd),
				name: NSNotification.Name(AppConfig.WatchAdNotification), object: nil)
        // New Code Start
        NotificationCenter.default.addObserver(self, selector: #selector(onWatchAdBack),
                                               name: NSNotification.Name(AppConfig.WatchAdBackNotification), object: nil)
        // New Code End
		NotificationCenter.default.addObserver(self, selector: #selector(onPurchaseSuccess),
				name: NSNotification.Name(AppConfig.PurchaseSuccessNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onPurchaseError),
				name: NSNotification.Name(AppConfig.PurchaseErrorNotification), object: nil)		
    }
	
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
	
    // MARK:
	
    func runEntranceActions() {
		let colorComponents = AppConfig.LoseOverlayColor.cgColor.components
		let overlayFadeInAction = SKAction.customAction(withDuration: 0.3) {
			(node, elapsedTime) in

			let fraction = CGFloat(elapsedTime / CGFloat(0.3))
			let transColor = UIColor(red: colorComponents![0] * fraction,
							 green: colorComponents![1] * fraction,
							 blue: colorComponents![2] * fraction,
							 alpha: colorComponents![3] * fraction * AppConfig.LoseOverlayStrength)
			(node as! SKShapeNode).fillColor = transColor
		}
		run(overlayFadeInAction) {
			[weak self] in
			
			let continueMenuMoveAction = SKAction.moveTo(x: 0, duration: 0.25)
			continueMenuMoveAction.timingMode = .easeOut
			
			self?.continueMenuNode.run(continueMenuMoveAction) {
				[weak self] in
				
				self?.continueMenuNode.countdown()
			}
		}
	}
	
	// MARK:
	
	func continueMenuDidClickWatchAd(_ sender: ContinueMenuNode) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // New Code Start
        AudioHelper.SharedInstance.stopCrowdLoseEffect()
        // New Code End

        if !isInternetAvailable() {
            showHideDarkOverlay()
            showHideNoInternetButton()
        }
        else {
            // New Code Start
            // According to config, display video or interstitial (video is in priority)
            var wayChoosed = false
            if (AppConfig.AdvertReward & AppConfig.AdvertRewardVideo == AppConfig.AdvertRewardVideo) {
                if !appDelegate.isRewardedVideoAvailable() {
                    appDelegate.loadRewardedVideoAd()
                } else {
                    wayChoosed = true
                    appDelegate.showRewardedVideoAd()
                }
            }
            
            if !wayChoosed && (AppConfig.AdvertReward & AppConfig.AdvertRewardInterstitial == AppConfig.AdvertRewardInterstitial) {
                if !appDelegate.isInterstitialAvailable() {
                    appDelegate.loadInterstitial()
                } else {
                    wayChoosed = true
                    appDelegate.showInterstitial()
                }
            }
            
            if !wayChoosed {
                showHideDarkOverlay()
                showHideNoVideoButton()
            }
            // New Code End
        }
	}
	
	func continueMenuDidClickContinue(_ sender: ContinueMenuNode) {
		let continueCount = DataHelper.getContinueCount()
		
        // New Code Start
        AudioHelper.SharedInstance.stopCrowdLoseEffect()
        if stage == 1 {
            delegate?.loseLayerDidSpendContinue(self)
        } else if continueCount > 0 {
            // New Code End
            DataHelper.setContinueCount(continueCount: continueCount - 1)
			
            continueMenuNode.updateContinueCount()

			delegate?.loseLayerDidSpendContinue(self)
        }
        else {
        	let continueMenuMoveAction = SKAction.moveTo(x: -size.width, duration: 0.25)
			continueMenuMoveAction.timingMode = .easeOut
			
			continueMenuNode.run(continueMenuMoveAction)
			
			let purchaseMenuMoveAction = SKAction.moveTo(x: 0, duration: 0.25)
			purchaseMenuMoveAction.timingMode = .easeOut
			
			purchaseMenuNode.run(purchaseMenuMoveAction)
        }
	}
	
	func continueMenuDidClickBack(_ sender: ContinueMenuNode) {
		delegate?.loseLayerDidResign(self)
	}
	
	func continueMenuDidFinishCountdown(_ sender: ContinueMenuNode) {
		delegate?.loseLayerDidResign(self)
	}
	
	// MARK:
	
	func purchaseMenuDidClickPurchaseContinue2(_ sender: PurchaseMenuNode) {
		if !isInternetAvailable() {
            showHideDarkOverlay()
            showHideNoInternetButton()
        }
        else {
            showActivityIndicator()
            showDarkOverlay()

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.purchaseContinue2()
        }
	}
	
	func purchaseMenuDidClickPurchaseContinue6(_ sender: PurchaseMenuNode) {
		if !isInternetAvailable() {
            showHideDarkOverlay()
            showHideNoInternetButton()
        }
        else {
            showActivityIndicator()
            showDarkOverlay()

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.purchaseContinue6()
        }
	}
	
	func purchaseMenuDidClickPurchaseContinue15(_ sender: PurchaseMenuNode) {
		if !isInternetAvailable() {
            showHideDarkOverlay()
            showHideNoInternetButton()
        }
        else {
            showActivityIndicator()
            showDarkOverlay()

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.purchaseContinue15()
        }
	}
	
	func purchaseMenuDidClickPurchaseContinue35(_ sender: PurchaseMenuNode) {
		if !isInternetAvailable() {
            showHideDarkOverlay()
            showHideNoInternetButton()
        }
        else {
            showActivityIndicator()
            showDarkOverlay()

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.purchaseContinue35()
        }
	}
	
	func purchaseMenuDidClickBack(_ sender: PurchaseMenuNode) {
		let continueMenuMoveAction = SKAction.moveTo(x: 0, duration: 0.25)
		continueMenuMoveAction.timingMode = .easeOut
	
		continueMenuNode.run(continueMenuMoveAction) {
			[weak self] in
			
			self?.continueMenuNode.countdown()
		}
	
		let purchaseMenuMoveAction = SKAction.moveTo(x: size.width, duration: 0.25)
		purchaseMenuMoveAction.timingMode = .easeOut
	
		purchaseMenuNode.run(purchaseMenuMoveAction)
	}
	
    // MARK:
	
    private func createContinueMenuNode(stage: Int) {
        continueMenuNode = ContinueMenuNode(size: size, stage: stage)
		continueMenuNode.position = CGPoint(x: size.width, y: 0)
		continueMenuNode.zPosition = 1
		continueMenuNode.delegate = self
		addChild(continueMenuNode)
	}
	
	private func createPurchaseMenuNode() {
		purchaseMenuNode = PurchaseMenuNode(size: size)
		purchaseMenuNode.position = CGPoint(x: size.width, y: 0)
		purchaseMenuNode.zPosition = 1
		purchaseMenuNode.delegate = self
		addChild(purchaseMenuNode)
	}
	
    private func createDarkOverlayNode() {
        darkOverlayNode = SKShapeNode(rectOf: size)
        darkOverlayNode.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        darkOverlayNode.fillColor = UIColor.black
        darkOverlayNode.strokeColor = UIColor.clear
        darkOverlayNode.zPosition = 8
        addChild(darkOverlayNode)
		
        darkOverlayNode.alpha = 0
        darkOverlayNode.isHidden = true
        darkOverlayNode.isUserInteractionEnabled = false
    }
	
    private func createNoInternetButton() {
        noInternetButton = ButtonNode(imageNamed: "btn_no_internet.png")
        noInternetButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        noInternetButton.setScale(noInternetButton.percentFitScale(referSize: size,
                                           widthPercent: 0.46, heightPercent: 0.28))
        noInternetButton.zPosition = 10
        noInternetButton.clickHandler = { [weak self] in self?.onClickNoInternet(sender: $0) }
        addChild(noInternetButton)
		
        noInternetButton.alpha = 0
        noInternetButton.isHidden = true
        noInternetButton.isUserInteractionEnabled = false
    }
	
    private func createNoVideoButton() {
        noVideoButton = ButtonNode(imageNamed: "btn_no_video.png")
        noVideoButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        noVideoButton.setScale(noVideoButton.percentFitScale(referSize: size,
                                           widthPercent: 0.46, heightPercent: 0.28))
        noVideoButton.zPosition = 10
        noVideoButton.clickHandler = { [weak self] in self?.onClickNoVideo(sender: $0) }
        addChild(noVideoButton)
		
        noVideoButton.alpha = 0
        noVideoButton.isHidden = true
        noVideoButton.isUserInteractionEnabled = false
    }
	
    // MARK:

    private func showDarkOverlay() {
        darkOverlayNode.removeAllActions()

        darkOverlayNode.alpha = 0
        darkOverlayNode.isHidden = false
        darkOverlayNode.isUserInteractionEnabled = true

        let fadeInAction = SKAction.fadeAlpha(to: 0.7, duration: 0.3)
        darkOverlayNode.run(fadeInAction)
    }

    private func hideDarkOverlay() {
        darkOverlayNode.removeAllActions()

        let fadeOutAction = SKAction.fadeOut(withDuration: 0.3)
        darkOverlayNode.run(fadeOutAction) {
            [weak self] in

            self?.darkOverlayNode.alpha = 0
            self?.darkOverlayNode.isHidden = true
            self?.darkOverlayNode.isUserInteractionEnabled = false
        }
    }

    private func showHideDarkOverlay() {
        darkOverlayNode.removeAllActions()

        darkOverlayNode.alpha = 0
        darkOverlayNode.isHidden = false
        darkOverlayNode.isUserInteractionEnabled = true

        let fadeInAction = SKAction.fadeAlpha(to: 0.7, duration: 0.3)
        let waitAction = SKAction.wait(forDuration: 2)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.3)
        darkOverlayNode.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction])) {
            [weak self] in

            self?.darkOverlayNode.alpha = 0
            self?.darkOverlayNode.isHidden = true
            self?.darkOverlayNode.isUserInteractionEnabled = false
        }
    }
	
    private func showHideNoInternetButton() {
        noInternetButton.removeAllActions()
		
        noInternetButton.alpha = 0
        noInternetButton.isHidden = false
        noInternetButton.isUserInteractionEnabled = true
		
        let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
        let waitAction = SKAction.wait(forDuration: 2)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.3)
        noInternetButton.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction])) {
            [weak self] in
			
            self?.noInternetButton.alpha = 0
            self?.noInternetButton.isHidden = true
            self?.noInternetButton.isUserInteractionEnabled = false
        }
    }
	
    private func showHideNoVideoButton() {
        noVideoButton.removeAllActions()
		
        noVideoButton.alpha = 0
        noVideoButton.isHidden = false
        noVideoButton.isUserInteractionEnabled = true
		
        let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
        let waitAction = SKAction.wait(forDuration: 2)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.3)
        noVideoButton.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction])) {
            [weak self] in
			
            self?.noVideoButton.alpha = 0
            self?.noVideoButton.isHidden = true
            self?.noVideoButton.isUserInteractionEnabled = false
        }
    }
	
	private func showActivityIndicator() {
		guard let view = scene?.view else {
			return
		}
	
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator!.center = view.center
            activityIndicator!.hidesWhenStopped = true
            view.addSubview(activityIndicator!)
        }

        activityIndicator!.startAnimating()
    }

    private func hideActivityIndicator() {
        activityIndicator?.stopAnimating()
    }
	
    // MARK:
	
    @objc private func onWatchAd() {
    	delegate?.loseLayerDidWatchAd(self)
    }
    
    // New Code Start
    @objc private func onWatchAdBack() {
        self.continueMenuNode.countdown()
    }
    // New Code End

    @objc private func onPurchaseSuccess() {
        hideActivityIndicator()
        hideDarkOverlay()

        delegate?.loseLayerDidPurchaseContinue(self)
    }

    @objc private func onPurchaseError() {
        hideActivityIndicator()
        hideDarkOverlay()
    }
	
    // MARK:
	
    private func onClickNoInternet(sender: ButtonNode) {
        darkOverlayNode.removeAllActions()
        noInternetButton.removeAllActions()
		
        darkOverlayNode.alpha = 0
        darkOverlayNode.isHidden = true
        darkOverlayNode.isUserInteractionEnabled = false
		
        noInternetButton.alpha = 0
        noInternetButton.isHidden = true
        noInternetButton.isUserInteractionEnabled = false
    }
	
    private func onClickNoVideo(sender: ButtonNode) {
        darkOverlayNode.removeAllActions()
        noInternetButton.removeAllActions()
		
        darkOverlayNode.alpha = 0
        darkOverlayNode.isHidden = true
        darkOverlayNode.isUserInteractionEnabled = false
		
        noVideoButton.alpha = 0
        noVideoButton.isHidden = true
        noVideoButton.isUserInteractionEnabled = false
        
        // New Code Start
        continueMenuNode.countdown()
        // New Code End
    }
    // New Code Start
    private func onReplay(sender: ButtonNode) {
        delegate?.loseLayerDidSpendContinue(self)
    }
    // New Code End

}
