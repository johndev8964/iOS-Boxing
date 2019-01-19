import Foundation

class BlockOpponentState: OpponentState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is AttackOpponentState.Type, is Idle1OpponentState.Type, is Idle2OpponentState.Type, is Idle3OpponentState.Type,
             is Idle4OpponentState.Type, is Idle5OpponentState.Type, is TiredOpponentState.Type, is KnockOutOpponentState.Type:
            return currentFrameIndex >= animFrames.count
            
        default:
            return true
        }
    }
}

//opblocks

class BlockTopLeftOpponentState: BlockOpponentState {
    override var animFrames: [String] {
        return ["block_mid_punch.png",
                "block_mid_punch.png"]
    }
}

class BlockTopRightOpponentState: BlockOpponentState {
    override var animFrames: [String] {
        return ["block_mid_punch.png",
                "block_mid_punch.png"]
    }
}

class BlockBottomOpponentState: BlockOpponentState {
    override var animFrames: [String] {
        return ["block_b_0.png",
                "block_b_0.png"]
    }
}
