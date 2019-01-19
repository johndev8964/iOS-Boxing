import SpriteKit


// MARK: -

class CommandDebugNode: BKSpriteNode {
    private var commandLabels = [SKLabelNode]()
    
    // MARK:
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clear, size: size)
    }
    
    // MARK:
    
    func addCommand(command: GameCommand) {
        commandLabels.last?.fontColor = UIColor.blue
        
        let commandText = getCommandText(from: command)
        
        let commandLabel = SKLabelNode(text: commandText)
        commandLabel.fontName = "Arial Bold"
        commandLabel.fontColor = UIColor.cyan
        commandLabel.fontSize = 12
        commandLabel.verticalAlignmentMode = .center
        commandLabel.zPosition = 1
        addChild(commandLabel)
        
        commandLabels.append(commandLabel)
        
        while commandLabels.count > 10 {
            let firstLabel = commandLabels.removeFirst()
            firstLabel.removeFromParent()
        }
        
        for (i, label) in commandLabels.enumerated() {
            label.position = CGPoint(x: 0, y: size.height * (0.45 - 0.1 * CGFloat(i)))
        }
    }
    
    // MARK:
    
    private func getCommandText(from command: GameCommand) -> String {
        switch command {
        case .attackDamage(damage: let damage):
            return "D:\(damage)"
        
        case .opponentAttackSpeed(attackSpeed: let attackSpeed):
            return "S:\(attackSpeed)"
            
        case .opponentAttack(type: let type, direction: let direction):
            switch (type, direction) {
            case (.punch, .topLeft):
                return "PTL"
                
            case (.punch, .topRight):
                return "PTR"
                
            case (.punch, .bottomLeft):
                return "PBL"
                
            case (.punch, .bottomRight):
                return "PBR"
                
                // New Code Start
            case (.punch, .s1):
                return "PS1"

            case (.punch, .s2):
                return "PS2"

            case (.punch, .s3):
                return "PS3"

            case (.punch, .s4):
                return "PS4"

            case (.punch, .s5):
                return "PS5"

                // New Code End
                
            case (.hook, .topLeft):
                return "HTL"
                
            case (.hook, .topRight):
                return "HTR"
                
            case (.hook, .bottomLeft):
                return "HBL"
                
            case (.hook, .bottomRight):
                return "HBR"
                
            // New Code Start
            case (.hook, .s1):
                return "H1"
                
            case (.hook, .s2):
                return "H2"
                
            case (.hook, .s3):
                return "H3"
                
            case (.hook, .s4):
                return "H4"
                
            case (.hook, .s5):
                return "H5"
                
                // New Code End
            }
            
        case .opponentBlock(direction: let direction, duration: let duration):
            switch direction {
            case .top:
                return "BT:\(duration)"
                
            case .bottom:
                return "BB:\(duration)"
                
            case .all:
                return "BA:\(duration)"
            }
            
        case .opponentIdle(kind: let kind, duration: let duration):
            return "I\(kind):\(duration)"
        
        case .opponentTired(duration: let duration):
            return "T:\(duration)"
        }
    }
}
