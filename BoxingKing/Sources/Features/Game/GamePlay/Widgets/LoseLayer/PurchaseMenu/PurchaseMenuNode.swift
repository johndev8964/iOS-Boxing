import SpriteKit


// MARK: -

class PurchaseMenuNode: SKShapeNode {
	weak var delegate: PurchaseMenuDelegate?

	private let size: CGSize
	
    private var continue2PriceLabel: SKLabelNode!
    private var continue6PriceLabel: SKLabelNode!
    private var continue15PriceLabel: SKLabelNode!
    private var continue35PriceLabel: SKLabelNode!
	
    // MARK:
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(size: CGSize) {
    	self.size = size
        
        super.init()
		
        createPurchaseContinue2Button()
        createPurchaseContinue6Button()
        createPurchaseContinue15Button()
        createPurchaseContinue35Button()
        createBackButton()
        createContinue2PriceLabel()
        createContinue6PriceLabel()
        createContinue15PriceLabel()
        createContinue35PriceLabel()
    }
    
    // MARK:
    
    private func createPurchaseContinue2Button() {
        let purchaseContinue2Button = ButtonNode(imageNamed: "btn_purchase_continue_2.png")
        purchaseContinue2Button.position = CGPoint(x: size.width * 0.32, y: size.height * 0.61)
        purchaseContinue2Button.setScale(purchaseContinue2Button.percentFitScale(referSize: size,
                                         widthPercent: 0.29, heightPercent: 0.20))
        purchaseContinue2Button.zPosition = 5
        purchaseContinue2Button.clickHandler = { [weak self] in
            self?.onClickPurchaseContinue2(sender: $0) }
		purchaseContinue2Button.name = "continue2Button"
        addChild(purchaseContinue2Button)
		
        let continueCountLabel = SKLabelNode(text: "00")
        // New Code Start
        // continueCountLabel.fontName = "Jeebz Bold"
        continueCountLabel.fontName = "ArcadeClassic"
        // New Code End
        continueCountLabel.fontColor = UIColor.purple
        continueCountLabel.verticalAlignmentMode = .center
        continueCountLabel.position = CGPoint(x: 0, y: 0)
        continueCountLabel.zPosition = 1
        purchaseContinue2Button.addChild(continueCountLabel)
		
        continueCountLabel.fontSize *= purchaseContinue2Button.texture!.size().width
            / continueCountLabel.frame.width * 0.35
        continueCountLabel.text = "2"
    }
    
    private func createPurchaseContinue6Button() {
        let purchaseContinue6Button = ButtonNode(imageNamed: "btn_purchase_continue_6.png")
        purchaseContinue6Button.position = CGPoint(x: size.width * 0.68, y: size.height * 0.61)
        purchaseContinue6Button.setScale(purchaseContinue6Button.percentFitScale(referSize: size,
                                         widthPercent: 0.29, heightPercent: 0.20))
        purchaseContinue6Button.zPosition = 5
        purchaseContinue6Button.clickHandler = { [weak self] in
            self?.onClickPurchaseContinue6(sender: $0) }
		purchaseContinue6Button.name = "continue6Button"
        addChild(purchaseContinue6Button)
		
        let continueCountLabel = SKLabelNode(text: "00")
        // New Code Start
        // continueCountLabel.fontName = "Jeebz Bold"
        continueCountLabel.fontName = "ArcadeClassic"
        // New Code End
        continueCountLabel.fontColor = UIColor.purple
        continueCountLabel.verticalAlignmentMode = .center
        continueCountLabel.position = CGPoint(x: 0, y: 0)
        continueCountLabel.zPosition = 1
        purchaseContinue6Button.addChild(continueCountLabel)
		
        continueCountLabel.fontSize *= purchaseContinue6Button.texture!.size().width
            / continueCountLabel.frame.width * 0.35
        continueCountLabel.text = "6"
    }
    
    private func createPurchaseContinue15Button() {
        let purchaseContinue15Button = ButtonNode(imageNamed: "btn_purchase_continue_15.png")
        
        // Added By Blake -- Issue 2
        var yCor: CGFloat = 0;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            yCor = -30;
        }
        purchaseContinue15Button.position = CGPoint(x: size.width * 0.32, y: size.height * 0.39 + yCor)
        
        purchaseContinue15Button.setScale(purchaseContinue15Button.percentFitScale(referSize: size,
                                           widthPercent: 0.29, heightPercent: 0.20))
        purchaseContinue15Button.zPosition = 5
        purchaseContinue15Button.clickHandler = { [weak self] in
            self?.onClickPurchaseContinue15(sender: $0) }
		purchaseContinue15Button.name = "continue15Button"
        addChild(purchaseContinue15Button)
		
        let continueCountLabel = SKLabelNode(text: "00")
        // New Code Start
        // continueCountLabel.fontName = "Jeebz Bold"
        continueCountLabel.fontName = "ArcadeClassic"
        // New Code End
        continueCountLabel.fontColor = UIColor.purple
        continueCountLabel.verticalAlignmentMode = .center
        continueCountLabel.position = CGPoint(x: 0, y: 0)
        continueCountLabel.zPosition = 1
        purchaseContinue15Button.addChild(continueCountLabel)
		
        continueCountLabel.fontSize *= purchaseContinue15Button.texture!.size().width
            / continueCountLabel.frame.width * 0.35
        continueCountLabel.text = "15"
    }
    
    private func createPurchaseContinue35Button() {
        let purchaseContinue35Button = ButtonNode(imageNamed: "btn_purchase_continue_35.png")
        
        // Added By Blake -- Issue 2
        var yCor: CGFloat = 0;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            yCor = -30;
        }
        purchaseContinue35Button.position = CGPoint(x: size.width * 0.68, y: size.height * 0.39 + yCor)
        purchaseContinue35Button.setScale(purchaseContinue35Button.percentFitScale(referSize: size,
                                           widthPercent: 0.29, heightPercent: 0.20))
        purchaseContinue35Button.zPosition = 5
        purchaseContinue35Button.clickHandler = { [weak self] in
            self?.onClickPurchaseContinue35(sender: $0) }
		purchaseContinue35Button.name = "continue35Button"
        addChild(purchaseContinue35Button)
		
        let continueCountLabel = SKLabelNode(text: "00")
        // New Code Start
        // continueCountLabel.fontName = "Jeebz Bold"
        continueCountLabel.fontName = "ArcadeClassic"
        // New Code End
        continueCountLabel.fontColor = UIColor.purple
        continueCountLabel.verticalAlignmentMode = .center
        continueCountLabel.position = CGPoint(x: 0, y: 0)
        continueCountLabel.zPosition = 1
        purchaseContinue35Button.addChild(continueCountLabel)
		
        continueCountLabel.fontSize *= purchaseContinue35Button.texture!.size().width
            / continueCountLabel.frame.width * 0.35
        continueCountLabel.text = "35"
    }
	
    private func createBackButton() {
        let backButton = ButtonNode(imageNamed: "btn_back.png")
        
        
        // Added By Blake -- Issue 2
        
        var yCor: CGFloat = 0;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            yCor = -8;
        }
        backButton.anchorPoint = CGPoint(x: 0, y: 1)
        backButton.position = CGPoint(x: size.width * 0.06, y: size.height * 0.95 + yCor)
        backButton.setScale(backButton.percentFitScale(referSize: size,
                                                       widthPercent: 0.18, heightPercent: 0.12))
        backButton.zPosition = 5
        backButton.clickHandler = { [weak self] in self?.onClickBack(sender: $0) }
        addChild(backButton)
    }
	
	private func createContinue2PriceLabel() {
        guard let continueNode = childNode(withName: "continue2Button") else {
            fatalError("Continue button not created.")
        }
		
        let continueButton = continueNode as! ButtonNode
		
        continue2PriceLabel = SKLabelNode(text: "$0.00")
        // New Code Start
        // continue2PriceLabel.fontName = "Jeebz Bold"
        continue2PriceLabel.fontName = "ArcadeClassic"
        // New Code End
        continue2PriceLabel.fontColor = UIColor.yellow
        continue2PriceLabel.verticalAlignmentMode = .top
        
        
        
        continue2PriceLabel.position =
				CGPoint(x: 0, y: -continueButton.texture!.size().height * 0.55)
        continue2PriceLabel.zPosition = 1
        continueButton.addChild(continue2PriceLabel)
		
        continue2PriceLabel.fontSize *= continueButton.texture!.size().width
            / continue2PriceLabel.frame.width * 0.4
		continue2PriceLabel.text = DataHelper.getContinue2Price() ?? ""
    }
	
    private func createContinue6PriceLabel() {
        guard let continueNode = childNode(withName: "continue6Button") else {
            fatalError("Continue button not created.")
        }
		
        let continueButton = continueNode as! ButtonNode
		
        continue6PriceLabel = SKLabelNode(text: "$0.00")
        // New Code Start
        // continue6PriceLabel.fontName = "Jeebz Bold"
        continue6PriceLabel.fontName = "ArcadeClassic"
        // New Code End
        continue6PriceLabel.fontColor = UIColor.yellow
        continue6PriceLabel.verticalAlignmentMode = .top
        continue6PriceLabel.position =
				CGPoint(x: 0, y: -continueButton.texture!.size().height * 0.55)
        continue6PriceLabel.zPosition = 1
        continueButton.addChild(continue6PriceLabel)
		
        continue6PriceLabel.fontSize *= continueButton.texture!.size().width
            / continue6PriceLabel.frame.width * 0.4
		continue6PriceLabel.text = DataHelper.getContinue6Price() ?? ""
    }
	
    private func createContinue15PriceLabel() {
        guard let continueNode = childNode(withName: "continue15Button") else {
            fatalError("Continue button not created.")
        }
		
        let continueButton = continueNode as! ButtonNode
		
        continue15PriceLabel = SKLabelNode(text: "$0.00")
        // New Code Start
        // continue15PriceLabel.fontName = "Jeebz Bold"
        continue15PriceLabel.fontName = "ArcadeClassic"
        // New Code End
        continue15PriceLabel.fontColor = UIColor.yellow
        continue15PriceLabel.verticalAlignmentMode = .top
        continue15PriceLabel.position =
				CGPoint(x: 0, y: -continueButton.texture!.size().height * 0.55)
        continue15PriceLabel.zPosition = 1
        continueButton.addChild(continue15PriceLabel)
		
        continue15PriceLabel.fontSize *= continueButton.texture!.size().width
            / continue15PriceLabel.frame.width * 0.4
		continue15PriceLabel.text = DataHelper.getContinue15Price() ?? ""
    }
	
    private func createContinue35PriceLabel() {
        guard let continueNode = childNode(withName: "continue35Button") else {
            fatalError("Continue button not created.")
        }
		
        let continueButton = continueNode as! ButtonNode
		
        continue35PriceLabel = SKLabelNode(text: "$0.00")
        // New Code Start
        // continue35PriceLabel.fontName = "Jeebz Bold"
        continue35PriceLabel.fontName = "ArcadeClassic"
        // New Code End
        continue35PriceLabel.fontColor = UIColor.yellow
        continue35PriceLabel.verticalAlignmentMode = .top
        continue35PriceLabel.position =
				CGPoint(x: 0, y: -continueButton.texture!.size().height * 0.55)
        continue35PriceLabel.zPosition = 1
        continueButton.addChild(continue35PriceLabel)
		
        continue35PriceLabel.fontSize *= continueButton.texture!.size().width
            / continue35PriceLabel.frame.width * 0.4
		continue35PriceLabel.text = DataHelper.getContinue35Price() ?? ""
    }
    
    // MARK:
    
    private func onClickPurchaseContinue2(sender: ButtonNode) {
        delegate?.purchaseMenuDidClickPurchaseContinue2(self)
    }
    
    private func onClickPurchaseContinue6(sender: ButtonNode) {
        delegate?.purchaseMenuDidClickPurchaseContinue6(self)
    }
    
    private func onClickPurchaseContinue15(sender: ButtonNode) {
        delegate?.purchaseMenuDidClickPurchaseContinue15(self)
    }
    
    private func onClickPurchaseContinue35(sender: ButtonNode) {
        delegate?.purchaseMenuDidClickPurchaseContinue35(self)
    }
    
    private func onClickBack(sender: ButtonNode) {
        delegate?.purchaseMenuDidClickBack(self)
    }
}
