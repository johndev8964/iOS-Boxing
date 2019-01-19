import Foundation


// MARK: -

class GetAttackPlayerState: PlayerState {
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GetAttackPlayerState.Type, is KnockOutPlayerState.Type:
            return true
            
        case is IdlePlayerState.Type, is TiredPlayerState.Type:
            return currentFrameIndex >= animFrames.count
            
        default:
            return false
        }
    }
}

// Punch Top Left & Right

class GetPunchPlayerState: GetAttackPlayerState {}

class GetPunchTopLeftPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["punch_top.png"]
    }
}

class GetPunchTopLeftBlockedPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["block_0.png",
                "block_1.png"]
    }
}

class GetPunchTopRightPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["punch_top.png"]
    }
}

class GetPunchTopRightBlockedPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["block_0.png",
                "block_1.png"]
    }
}

//Hook Top Left & Right
class GetHookPlayerState: GetAttackPlayerState {}

class GetHookTopLeftPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        return ["get_punch_t_l_0.png",
                "get_punch_t_l_0.png"]
    }
}

class GetHookTopLeftBlockedPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        return ["get_punch_t_l_0.png",
                "get_punch_t_l_0.png"]
    }
}

class GetHookTopRightPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        return ["get_punch_t_r_0.png",
                "get_punch_t_r_0.png"]
    }
}

class GetHookTopRightBlockedPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        return ["get_punch_t_r_0.png",
                "get_punch_t_r_0.png"]
    }
}

// Get Upper Cut Left & Right
class GetPunchBottomLeftPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["get_up_l_0.png",
                "get_up_l_1.png"]
    }
}

class GetPunchBottomLeftBlockedPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["get_up_l_0.png",
                "get_up_l_1.png"]
    }
}

class GetPunchBottomRightPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["get_up_l_0.png",
                "get_up_l_1.png"]
    }
}

class GetPunchBottomRightBlockedPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["get_up_l_0.png",
                "get_up_l_1.png"]
    }
}



class GetPunchS1PlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 1)
        {
            return ["punch_top.png"]
        }
        if(stageVar.currentStage == 2)
        {
            return ["get_punch_t_r_0.png",
                    "get_punch_t_r_0.png"]
        }
        if(stageVar.currentStage == 4)
        {
            return ["get_punch_t_r_0.png",
                    "get_punch_t_r_0.png"]
        }
        if(stageVar.currentStage == 8)
        {
            return ["punch_top.png"]
        }
        return ["punch_top.png",
                "punch_top.png"]
    }
}

class GetPunchS1BlockedPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["block_0.png",
                "block_1.png"]
    }
}

class GetPunchS2PlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        
        if(stageVar.currentStage == 2)
        {
            return ["get_punch_t_l_0.png",
                    "get_punch_t_l_0.png"]
        }
        if(stageVar.currentStage == 4)
        {
            return ["get_punch_t_l_0.png",
                    "get_punch_t_l_0.png"]
        }
        if(stageVar.currentStage == 5)
        {
            return ["punch_top.png",
                    "punch_top.png"]
        }
        if(stageVar.currentStage == 8)
        {
            return ["punch_top.png"]
        }
        
        return ["get_punch_b_0.png",
                "get_punch_b_1.png",
                "get_punch_b_2.png",
                "get_punch_b_3.png",
                "get_punch_b_4.png"]
    }
}

class GetPunchS3PlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["punch_top.png"]
    }
}

class GetPunchS4PlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["punch_top.png"]
    }
}

class GetPunchS5PlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["get_punch_b_0.png",
                "get_punch_b_1.png",
                "get_punch_b_2.png",
                "get_punch_b_3.png",
                "get_punch_b_4.png"]
    }
}

class GetPunchS2BlockedPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["block_0.png",
                "block_1.png"]
    }
}

class GetPunchS3BlockedPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["block_0.png",
                "block_1.png"]
    }
}

class GetPunchS4BlockedPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["block_0.png",
                "block_1.png"]
    }
}

class GetPunchS5BlockedPlayerState: GetPunchPlayerState {
    override var animFrames: [String] {
        return ["block_0.png",
                "block_1.png"]
    }
}

class GetHookS1PlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        
        if(stageVar.currentStage == 4)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        if(stageVar.currentStage == 5)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        if(stageVar.currentStage == 6)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        if(stageVar.currentStage == 8)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        return ["get_punch_t_l_0.png",
                "get_punch_t_l_0.png"]
    }
}
class GetHookS1BlockedPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 4)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        if(stageVar.currentStage == 5)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        if(stageVar.currentStage == 6)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        if(stageVar.currentStage == 8)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        return ["get_punch_t_l_0.png",
                "get_punch_t_l_0.png"]
    }
}

class GetHookS2PlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 8)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        return ["get_punch_t_r_0.png",
                "get_punch_t_r_0.png"]
    }
}

class GetHookS2BlockedPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 8)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        return ["get_punch_t_r_0.png",
                "get_punch_t_r_0.png"]
    }
}

class GetHookS3PlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        return ["get_punch_t_l_0.png",
                "get_punch_t_l_0.png"]
    }
}

class GetHookS3BlockedPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        return ["get_punch_t_l_0.png",
                "get_punch_t_l_0.png"]
    }
}

class GetHookS4PlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 5)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        return ["get_punch_t_l_0.png",
                "get_punch_t_l_0.png"]
    }
}

class GetHookS4BlockedPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 5)
        {
            return["get_up_l_0.png",
                   "get_up_l_1.png"]
        }
        return ["get_punch_t_r_0.png",
                "get_punch_t_r_0.png"]
    }
}

class GetHookS5PlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        return ["get_hook_b_0.png",
                "get_hook_b_1.png",
                "get_hook_b_2.png",
                "get_hook_b_3.png",
                "get_hook_b_4.png"]
    }
}

class GetHookS5BlockedPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        return ["get_hook_b_0.png",
                "get_hook_b_1.png",
                "get_hook_b_2.png",
                "get_hook_b_3.png",
                "get_hook_b_4.png"]
    }
}

// NOT USED START
class GetHookBottomRightPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        print("NOT USED!????")
        return ["punch_top.png",
                "punch_top.png"]
    }
}

class GetHookBottomRightBlockedPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        print("NOT USED!????")
        return ["block_0.png",
                "block_0.png"]
    }
}

class GetHookBottomLeftPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        print("NOT USED!????")
        return ["punch_top.png",
                "punch_top.png"]
    }
}
class GetHookBottomLeftBlockedPlayerState: GetHookPlayerState {
    override var animFrames: [String] {
        print("NOT USED!????")
        return ["get_up_l_0.png",
                "get_up_l_1.png"]
    }
}
// NOT USED END

