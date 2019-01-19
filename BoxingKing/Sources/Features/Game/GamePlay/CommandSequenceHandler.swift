import Foundation


class CommandSequenceHandler {
    private var commandSequence = [GameCommand]()
    private var commandIndex = 0
    // New Code Start
    private var stage = 1
    private var timeLeft: TimeInterval = AppConfig.clockTime
    // New Code End

    // MARK:
    
    required init(stage: Int) {
        // New Code Start
        self.stage = stage
        self.refreshCommandSequence()
        // New Code End
        guard isValidSequence(commandSequence) else {
            fatalError("Invalid command sequence provided.")
        }
    }
    
    // MARK:
    
    func getCurrentCommand() -> GameCommand  {
        guard commandSequence.indices.contains(commandIndex) else {
            fatalError("Index out of bounds.")
        }
        // print("\(commandSequence[commandIndex])")
        return commandSequence[commandIndex]
    }
    
    func moveToNextCommand(timeLeft: TimeInterval) {
        self.timeLeft = timeLeft
        commandIndex += 1
        
        if commandIndex >= commandSequence.count {
            commandIndex = 0
            // New Code Start
            refreshCommandSequence()
            // New Code End
        }
    }
    
    // New Code Start
    private func refreshCommandSequence() {
        let commandCodes = getCommandCodes(forStage: stage)
        commandSequence.removeAll()
        for commandCode in commandCodes {
            let gameCommand = getGameCommand(from: commandCode)
            commandSequence.append(gameCommand)
        }
    }
    // New Code End

    private func getCommandCodes(forStage stage: Int) -> [String]
    {
        // New Code Start
        var randNum = Int(arc4random_uniform(4))
        //let options8 = Int(arc4random_uniform(8))
        let options4 = Int(arc4random_uniform(4))
        let options6 = Int(arc4random_uniform(6))
        let options2 = Int(arc4random_uniform(2))
        
        // different timeline rules
        if (timeLeft > 53)
        {
            randNum = 0
            print("Time Left:", timeLeft)
            print("Rand Num:", randNum)
        }
        else if (timeLeft > 46 && timeLeft <= 53)
        {
            randNum = 1
        }
        else if (timeLeft > 39 && timeLeft <= 46)
        {
            randNum = 2
        }
        else if (timeLeft > 32 && timeLeft <= 39)
        {
            randNum = 0
        }
        else if (timeLeft > 25 && timeLeft <= 32)
        {
            randNum = 1
        }
        else if (timeLeft > 18 && timeLeft <= 25)
        {
            randNum = 2
        }
        else if (timeLeft > 11 && timeLeft <= 18)
        {
            randNum = 0
        }
        else if (timeLeft > 4 && timeLeft <= 11)
        {
           randNum = 1
        }
        else
        {
            randNum = 2
        }
    
      
        // 
        switch stage {
        case 1:
            randNum = 0
            switch randNum {
            case 0:
              
                return ["D:51","I1:1"]
                
            default:
                return ["D:5", "I1:1"]
                
            }
        //Mexico
        case 2:
               // randNum = 2
                switch randNum {
                case 0:
                    
                    return ["D:5", "I1:1",
                            "S:1", "D:100", "HTR",
                            "D:5", "I:1"]
                    
                default:
                    return ["D:5", "I1:1"]
                    
            }
        
            
        case 3:
            switch randNum {
            case 0:
                
                return ["D:5", "I1:1",
                        "S:1", "D:100", "HTR",
                        "D:5", "I:1"]
                
            default:
                return ["D:5", "I1:1"]
                
            }
            
        case 4:
        
            switch randNum {
            case 0:
                
                return ["D:5", "I1:1",
                        "S:1", "D:100", "HTR",
                        "D:5", "I:1"]
                
            default:
                return ["D:5", "I1:1"]
                
            }
            
        case 5:
            switch randNum {
            case 0:
                
                return ["D:5", "I1:1",
                        "S:1", "D:100", "HTR",
                        "D:5", "I:1"]
                
            default:
                return ["D:5", "I1:1"]
                
            }
      
            
        case 6:
            switch randNum {
            case 0:
                
                return ["D:5", "I1:1",
                        "S:1", "D:100", "HTR",
                        "D:5", "I:1"]
                
            default:
                return ["D:5", "I1:1"]
                
            }
       
        case 8:

            switch randNum {
            case 0:
                
                return ["D:5", "I1:1",
                        "S:1", "D:100", "HTR",
                        "D:5", "I:1"]
                
            default:
                return ["D:5", "I1:1"]
                
            }
        case 9:
            
            switch randNum {
            case 0:
                
                return ["D:5", "I1:1",
                        "S:1", "D:100", "HTR",
                        "D:5", "I:1"]
                
            default:
                return ["D:5", "I1:1"]
                
            }
            
        default:
            return ["D:5", "I1:1"]
            
      
        }}
    
    private func getGameCommand(from commandCode: String) -> GameCommand {
        let components = commandCode.components(separatedBy: ":")
        let commandType = components[0]
        let commandValue = components.count > 1 ? components[1] : ""
        
        switch commandType {
        case "D":
            return .attackDamage(damage: Int(commandValue) ?? 10)
            
        case "S":
            return .opponentAttackSpeed(attackSpeed: Float(commandValue) ?? 1)
            
        case "PTL":
            return .opponentAttack(type: .punch, direction: .topLeft)
            
        case "PTR":
            return .opponentAttack(type: .punch, direction: .topRight)
            
        case "PBL":
            return .opponentAttack(type: .punch, direction: .bottomLeft)
            
        case "PBR":
            return .opponentAttack(type: .punch, direction: .bottomRight)
            
            // New Code Start
        case "PS1":
            return .opponentAttack(type: .punch, direction: .s1)
        case "PS2":
            return .opponentAttack(type: .punch, direction: .s2)
        case "PS3":
            return .opponentAttack(type: .punch, direction: .s3)
        case "PS4":
            return .opponentAttack(type: .punch, direction: .s4)
        case "PS5":
            return .opponentAttack(type: .punch, direction: .s5)
        case "H1":
            return .opponentAttack(type: .hook, direction: .s1)
        case "H2":
            return .opponentAttack(type: .hook, direction: .s2)
        case "H3":
            return .opponentAttack(type: .hook, direction: .s3)
        case "H4":
            return .opponentAttack(type: .hook, direction: .s4)
        case "H5":
            return .opponentAttack(type: .hook, direction: .s5)
            // New Code End
            
        case "HTL":
            return .opponentAttack(type: .hook, direction: .topLeft)
            
        case "HTR":
            return .opponentAttack(type: .hook, direction: .topRight)
            
        case "HBL":
            return .opponentAttack(type: .hook, direction: .bottomLeft)
            
        case "HBR":
            return .opponentAttack(type: .hook, direction: .bottomRight)
            
        case "BT":
            return .opponentBlock(direction: .top, duration: TimeInterval(commandValue) ?? 1)
            
        case "BB":
            return .opponentBlock(direction: .bottom, duration: TimeInterval(commandValue) ?? 1)
            
        case "BA":
            return .opponentBlock(direction: .all, duration: TimeInterval(commandValue) ?? 1)
            
        case "I":
            return .opponentIdle(kind: 1, duration: TimeInterval(commandValue) ?? 1)
        case "I1":
            return .opponentIdle(kind: 1, duration: TimeInterval(commandValue) ?? 1)
        case "I2":
            return .opponentIdle(kind: 2, duration: TimeInterval(commandValue) ?? 1)
        case "I3":
            return .opponentIdle(kind: 3, duration: TimeInterval(commandValue) ?? 1)
        case "I4":
            return .opponentIdle(kind: 4, duration: TimeInterval(commandValue) ?? 1)

        case "T":
            return .opponentTired(duration: TimeInterval(commandValue) ?? 1)
            
        default:
            return .opponentIdle(kind: 1, duration: 1)
        }
    }
    
    private func isValidSequence(_ commandSequence: [GameCommand]) -> Bool {
        for gameCommand in commandSequence {
            switch gameCommand {
            case .attackDamage, .opponentAttackSpeed:
                break
                
            default:
                return true
            }
        }
        
        return false
    }
}
