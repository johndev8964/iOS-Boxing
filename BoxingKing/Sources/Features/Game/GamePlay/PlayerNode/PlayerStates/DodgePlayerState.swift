import Foundation


// MARK: -

class DodgePlayerState: PlayerState {
    
}


// MARK: -

class DodgeLeftPlayerState: DodgePlayerState {
    override var animFrames: [String] {
        return ["dodge_l_0.png",
                "dodge_l_0.png",
                "dodge_l_0.png",
                "dodge_l_0.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdlePlayerState.Type, is TiredPlayerState.Type:
            return currentFrameIndex >= animFrames.count
            
        case is GetPunchTopRightPlayerState.Type, is GetPunchBottomRightPlayerState.Type,
             is GetPunchTopRightBlockedPlayerState.Type, is GetPunchBottomRightBlockedPlayerState.Type,
             is GetHookTopRightPlayerState.Type, is GetHookBottomRightPlayerState.Type:
            return true
            
        default:
            return false
        }
    }
}


// MARK: -

class DodgeRightPlayerState: DodgePlayerState {
    override var animFrames: [String] {
        return ["dodge_r_0.png",
                "dodge_r_0.png",
                "dodge_r_0.png",
                "dodge_r_0.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdlePlayerState.Type, is TiredPlayerState.Type:
            return currentFrameIndex >= animFrames.count
            
        case is GetPunchTopLeftPlayerState.Type, is GetPunchBottomLeftPlayerState.Type,
             is GetPunchTopLeftBlockedPlayerState.Type, is GetPunchBottomLeftBlockedPlayerState.Type,
             is GetHookTopLeftPlayerState.Type, is GetHookBottomLeftPlayerState.Type,
             is GetHookTopLeftBlockedPlayerState.Type, is GetHookBottomLeftBlockedPlayerState.Type:
            return true
            
        default:
            return false
        }
    }
}

// New Code Start
// MARK: -

class DodgeLongPlayerState: PlayerState {
    
}


// MARK: -

class DodgeLongLeftPlayerState: DodgeLongPlayerState {
    override var animFrames: [String] {
        return ["dodge_l_0.png",
                "dodge_l_0.png",
                "dodge_l_0.png",
                "dodge_l_0.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdlePlayerState.Type, is TiredPlayerState.Type:
            return currentFrameIndex >= animFrames.count
            
        case is GetPunchTopRightPlayerState.Type, is GetPunchBottomRightPlayerState.Type,
             is GetPunchTopRightBlockedPlayerState.Type, is GetPunchBottomRightBlockedPlayerState.Type,
             is GetHookTopRightPlayerState.Type, is GetHookBottomRightPlayerState.Type:
            return true
            
        default:
            return false
        }
    }
}


// MARK: -

class DodgeLongRightPlayerState: DodgeLongPlayerState {
    override var animFrames: [String] {
        return ["dodge_r_0.png",
                "dodge_r_0.png",
                "dodge_r_0.png",
                "dodge_r_0.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdlePlayerState.Type, is TiredPlayerState.Type:
            return currentFrameIndex >= animFrames.count
            
        case is GetPunchTopLeftPlayerState.Type, is GetPunchBottomLeftPlayerState.Type,
             is GetPunchTopLeftBlockedPlayerState.Type, is GetPunchBottomLeftBlockedPlayerState.Type,
             is GetHookTopLeftPlayerState.Type, is GetHookBottomLeftPlayerState.Type,
             is GetHookTopLeftBlockedPlayerState.Type, is GetHookBottomLeftBlockedPlayerState.Type:
            return true
            
        default:
            return false
        }
    }
}

// New Code End
