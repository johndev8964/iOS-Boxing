import Foundation


// MARK: -

class Idle1OpponentState: OpponentState {
    override var animFrames: [String] {
        return ["idle_0.png",
                "idle_1.png",
                "idle_2.png",
                "idle_3.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    // MARK:
    
    override func didShowAllFrames() {
        super.didShowAllFrames()
        
        currentFrameIndex = 0
        
        delegate?.opponentState(self, didUpdateFrameTo: animFrames[currentFrameIndex])
    }
}

class Idle2OpponentState: OpponentState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 2)
        {
            return ["ps1_0.png",
                    "ps1_1.png",
                    "ps1_2.png",
                    "ps1_3.png"]
        }
        return ["idle_0.png",
                "idle_1.png",
                "idle_2.png",
                "idle_3.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    // MARK:
    
    override func didShowAllFrames() {
        super.didShowAllFrames()
        
        currentFrameIndex = 0
        
        delegate?.opponentState(self, didUpdateFrameTo: animFrames[currentFrameIndex])
    }
}

class Idle3OpponentState: OpponentState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 3)
        {
          return  ["taunt_1.png",
                    "taunt_2.png",
                    "taunt_3.png",
                    "taunt_4.png",
                    "taunt_5.png",
                    "taunt_6.png",
                    "taunt_7.png",
                    "taunt_8.png",
                    "taunt_9.png",
                    "taunt_10.png",
                    "taunt_11.png",
                    "taunt_12.png"]
            
        }
        if(stageVar.currentStage == 7)
        {
            return  ["taunt_1.png",
                     "taunt_2.png",
                     "taunt_3.png",
                     "taunt_4.png",
                     "taunt_5.png",
                     "taunt_6.png",
                     "taunt_7.png",
                     "taunt_8.png",
                     "taunt_9.png",
                     "taunt_10.png",
                     "taunt_11.png",
                     "taunt_12.png",
                     "taunt_13.png"]
        }
        if(stageVar.currentStage == 8)
        {
            
            return  ["idle_2_0.png",
                     "idle_2_1.png",
                     "idle_2_2.png",
                     "idle_2_0.png",
                     "idle_2_1.png",
                     "idle_2_2.png"]
            
        }
        return ["idle_0.png",
                "idle_1.png",
                "idle_2.png",
                "idle_3.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    // MARK:
    
    override func didShowAllFrames() {
        super.didShowAllFrames()
        
        currentFrameIndex = 0
        
        delegate?.opponentState(self, didUpdateFrameTo: animFrames[currentFrameIndex])
    }
}

class Idle4OpponentState: OpponentState {
    override var animFrames: [String] {
        
        if(stageVar.currentStage == 9)
        {
            return ["idle_0.png",
                    "idle_0.png",
                    "idle_0.png"]
        }
        return ["idle_0.png",
                "idle_1.png",
                "idle_2.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    // MARK:
    
    override func didShowAllFrames() {
        super.didShowAllFrames()
        
        currentFrameIndex = 0
        
        delegate?.opponentState(self, didUpdateFrameTo: animFrames[currentFrameIndex])
    }
}

class Idle5OpponentState: OpponentState {
    override var animFrames: [String] {
        return ["idle_0.png",
                "idle_1.png",
                "idle_2.png",
                "idle_3.png"]
    }
    
    // MARK:
     
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    // MARK:
    
    override func didShowAllFrames() {
        super.didShowAllFrames()
        
        currentFrameIndex = 0
        
        delegate?.opponentState(self, didUpdateFrameTo: animFrames[currentFrameIndex])
    }
}
