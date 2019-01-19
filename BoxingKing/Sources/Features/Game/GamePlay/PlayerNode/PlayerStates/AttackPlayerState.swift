import Foundation

class AttackPlayerState: PlayerState {
    var contactFrame: String {
        return ""
    }

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

// pattack
class PunchTopLeftPlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_t_l_0.png",
                "punch_t_l_1.png",
                "punch_t_l_2.png"]
    }
    override var contactFrame: String {
        return "punch_t_l_2.png"
    }
}

class PunchTopRightPlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_t_r_0.png",
                "punch_t_r_1.png",
                "punch_t_r_2.png"]
    }
    override var contactFrame: String {
        return "punch_t_r_2.png"
    }
}

// MARK: -
class PunchBottomLeftPlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_t_l_0.png",
                "punch_b_l_2.png"]
    }
    override var contactFrame: String {
        return "punch_b_l_2.png"
    }
}


// MARK: -

class PunchBottomRightPlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return [//"punch_b_r_0.png",
                "punch_t_r_1.png",
                "punch_b_r_2.png"]
    }
    override var contactFrame: String {
        return "punch_b_r_2.png"
    }
}


// MARK: -

class HookTopLeftPlayerState: AttackPlayerState {
        override var animFrames: [String] {
            return ["punch_t_l_0.png",
                    "punch_t_l_1.png",
                    "punch_t_l_2.png"]
        }
        override var contactFrame: String {
            return "punch_t_l_2.png"
        }
}


// MARK: -

class HookTopRightPlayerState: AttackPlayerState {
        override var animFrames: [String] {
            return ["punch_t_r_0.png",
                    "punch_t_r_1.png",
                    "punch_t_r_2.png"]
        }
        override var contactFrame: String {
            return "punch_t_r_2.png"
        }
}


// MARK: -

class HookBottomLeftPlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_b_l_0.png",
                "punch_b_l_1.png",
                "punch_b_l_2.png"]
    }
    override var contactFrame: String {
        return "punch_b_l_2.png"
    }
}


// MARK: -

class HookBottomRightPlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_b_r_0.png",
                "punch_b_r_2.png",
                "player_hook_br_0.png"]
    }
    override var contactFrame: String {
        return "punch_b_r_2.png"
    }
}

// New Code Start

class PunchS1PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_b_r_0.png",
                "punch_b_r_1.png",
                "punch_b_r_2.png",
                "punch_b_r_3.png",
                "punch_b_r_4.png",
                "punch_b_r_5.png"]
    }
    override var contactFrame: String {
        return "punch_b_r_3.png"
    }
}

class PunchS2PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_b_r_0.png",
                "punch_b_r_1.png",
                "punch_b_r_2.png",
                "punch_b_r_3.png",
                "punch_b_r_4.png",
                "punch_b_r_5.png"]
    }
    override var contactFrame: String {
        return "punch_b_r_3.png"
    }
}

class PunchS3PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_b_r_0.png",
                "punch_b_r_1.png",
                "punch_b_r_2.png",
                "punch_b_r_3.png",
                "punch_b_r_4.png",
                "punch_b_r_5.png"]
    }
    override var contactFrame: String {
        return "punch_b_r_3.png"
    }
}

class PunchS4PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_b_r_0.png",
                "punch_b_r_1.png",
                "punch_b_r_2.png",
                "punch_b_r_3.png",
                "punch_b_r_4.png",
                "punch_b_r_5.png"]
    }
    override var contactFrame: String {
        return "punch_b_r_3.png"
    }
}

class PunchS5PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["punch_b_r_0.png",
                "punch_b_r_1.png",
                "punch_b_r_2.png",
                "punch_b_r_3.png",
                "punch_b_r_4.png",
                "punch_b_r_5.png"]
    }
    override var contactFrame: String {
        return "punch_b_r_3.png"
    }
}

class HookS1PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["hook_b_r_0.png",
                "hook_b_r_1.png",
                "hook_b_r_2.png",
                "hook_b_r_3.png",
                "hook_b_r_4.png",
                "hook_b_r_5.png"]
    }
    override var contactFrame: String {
        return "hook_b_r_3.png"
    }
}

class HookS2PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["hook_b_r_0.png",
                "hook_b_r_1.png",
                "hook_b_r_2.png",
                "hook_b_r_3.png",
                "hook_b_r_4.png",
                "hook_b_r_5.png"]
    }
    override var contactFrame: String {
        return "hook_b_r_3.png"
    }
}

class HookS3PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["hook_b_r_0.png",
                "hook_b_r_1.png",
                "hook_b_r_2.png",
                "hook_b_r_3.png",
                "hook_b_r_4.png",
                "hook_b_r_5.png"]
    }
    override var contactFrame: String {
        return "hook_b_r_3.png"
    }
}

class HookS4PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["hook_b_r_0.png",
                "hook_b_r_1.png",
                "hook_b_r_2.png",
                "hook_b_r_3.png",
                "hook_b_r_4.png",
                "hook_b_r_5.png"]
    }
    override var contactFrame: String {
        return "hook_b_r_3.png"
    }
}

class HookS5PlayerState: AttackPlayerState {
    override var animFrames: [String] {
        return ["hook_b_r_0.png",
                "hook_b_r_1.png",
                "hook_b_r_2.png",
                "hook_b_r_3.png",
                "hook_b_r_4.png",
                "hook_b_r_5.png"]
    }
    override var contactFrame: String {
        return "hook_b_r_3.png"
    }
}
