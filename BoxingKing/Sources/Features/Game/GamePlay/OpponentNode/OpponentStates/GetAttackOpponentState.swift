import Foundation

class GetAttackOpponentState: OpponentState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is AttackOpponentState.Type, is Idle1OpponentState.Type, is Idle2OpponentState.Type, is Idle3OpponentState.Type,
             is Idle4OpponentState.Type, is Idle5OpponentState.Type, is TiredOpponentState.Type:
            return currentFrameIndex >= animFrames.count
            
        default:
            return true
        }
    }
}

class GetPunchOpponentState: GetAttackOpponentState {}

class GetPunchTopLeftOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_m_0.png",
                "get_punch_m_0.png"]
    }
}

class GetPunchTopLeftBlockedOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["block_mid_punch.png",
                "block_mid_punch.png"]
    }
}

class GetPunchTopRightOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_m_0.png",
                "get_punch_m_0.png"]
    }
}

class GetPunchTopRightBlockedOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["block_mid_punch.png",
                "block_mid_punch.png"]
    }
}

class GetPunchBottomLeftOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_l_0.png",
                "get_punch_b_l_0.png"]
    }
}

class GetPunchBottomLeftBlockedOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["block_b_0.png",
                "block_b_0.png"]
    }
}


// MARK: -

class GetPunchBottomRightOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_0.png"]
    }
}

class GetPunchBottomRightBlockedOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["block_b_0.png",
                "block_b_0.png"]
    }
}


// MARK: -

class GetHookOpponentState: GetAttackOpponentState {}


// MARK: -

class GetHookTopLeftOpponentState: GetHookOpponentState {
    override var animFrames: [String] {
        return ["get_punch_m_0.png",
                "get_punch_m_0.png"]
    }
}


// MARK: -

class GetHookTopRightOpponentState: GetHookOpponentState {
    override var animFrames: [String] {
        return ["get_punch_m_0.png",
                "get_punch_m_0.png"]
    }
}


// MARK: -

class GetHookBottomLeftOpponentState: GetHookOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_l_0.png",
                "get_punch_b_l_0.png"]
    }
}


// MARK: -

class GetHookBottomRightOpponentState: GetHookOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_0.png"]
    }
}

// New Code Start

class GetPunchS1OpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetPunchS2OpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetPunchS3OpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetPunchS4OpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetPunchS5OpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetPunchS1BlockedOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetPunchS2BlockedOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetPunchS3BlockedOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetPunchS4BlockedOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetPunchS5BlockedOpponentState: GetPunchOpponentState {
    override var animFrames: [String] {
        return ["get_punch_b_r_0.png",
                "get_punch_b_r_1.png",
                "get_punch_b_r_2.png",
                "get_punch_b_r_3.png",
                "get_punch_b_r_4.png"]
    }
}

class GetHookS1OpponentState: GetHookOpponentState {
    override var animFrames: [String] {
        return ["get_hook_b_r_0.png",
                "get_hook_b_r_1.png",
                "get_hook_b_r_2.png",
                "get_hook_b_r_3.png",
                "get_hook_b_r_4.png"]
    }
}

class GetHookS2OpponentState: GetHookOpponentState {
    override var animFrames: [String] {
        return ["get_hook_b_r_0.png",
                "get_hook_b_r_1.png",
                "get_hook_b_r_2.png",
                "get_hook_b_r_3.png",
                "get_hook_b_r_4.png"]
    }
}

class GetHookS3OpponentState: GetHookOpponentState {
    override var animFrames: [String] {
        return ["get_hook_b_r_0.png",
                "get_hook_b_r_1.png",
                "get_hook_b_r_2.png",
                "get_hook_b_r_3.png",
                "get_hook_b_r_4.png"]
    }
}

class GetHookS4OpponentState: GetHookOpponentState {
    override var animFrames: [String] {
        return ["get_hook_b_r_0.png",
                "get_hook_b_r_1.png",
                "get_hook_b_r_2.png",
                "get_hook_b_r_3.png",
                "get_hook_b_r_4.png"]
    }
}

class GetHookS5OpponentState: GetHookOpponentState {
    override var animFrames: [String] {
        return ["get_hook_b_r_0.png",
                "get_hook_b_r_1.png",
                "get_hook_b_r_2.png",
                "get_hook_b_r_3.png",
                "get_hook_b_r_4.png"]
    }
}


// New Code End
