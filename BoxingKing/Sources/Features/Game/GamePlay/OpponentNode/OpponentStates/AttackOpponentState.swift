import Foundation

class AttackOpponentState: OpponentState {
    var contactFrame: String {
        return ""
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is AttackOpponentState.Type, is Idle1OpponentState.Type, is Idle2OpponentState.Type, is Idle3OpponentState.Type,
             is Idle4OpponentState.Type, is Idle5OpponentState.Type, is TiredOpponentState.Type:
            return currentFrameIndex >= animFrames.count
            
        case is BlockOpponentState.Type:
            return true
            
        default:
            return false
        }
    }
}

class PunchTopLeftOpponentState: AttackOpponentState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return ["punch_t_l_0.png",
                    "punch_t_l_0.png",
                    "punch_t_l_0.png",
                    "punch_t_l_0.png",
                    "punch_t_l_1.png",
                    "punch_t_l_2.png",
                    "punch_t_l_3.png"]
        }
        if(stageVar.currentStage == 5)
        {
            return ["punch_t_l_0.png",
                    "punch_t_l_1.png",
                    "punch_t_l_2.png",
                    "punch_t_l_3.png"]
        }
        if(stageVar.currentStage == 6)
        {
            return ["punch_t_l_0.png",
                    "punch_t_l_1.png",
                    "punch_t_l_2.png",
                    "punch_t_l_1.png",
                    "punch_t_l_2.png",
                    "punch_t_l_3.png"]
        }
        if(stageVar.currentStage == 8)
        {
            return ["punch_t_l_0.png",
                    "punch_t_l_0.png",
                    "punch_t_l_1.png",
                    "punch_t_l_2.png",
                    "punch_t_l_3.png"]
        }
        return ["punch_t_l_0.png",
                "punch_t_l_1.png",
                "punch_t_l_2.png",
                "punch_t_l_3.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return "punch_t_l_2.png"
        }
        if(stageVar.currentStage == 6)
        {
            return "punch_t_l_2.png"
        }
        if(stageVar.currentStage == 5)
        {
            return "punch_t_l_2.png"
        }
        return "punch_t_l_2.png"
    }
}

class PunchTopRightOpponentState: AttackOpponentState {
    override var animFrames: [String] {
        
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return ["punch_t_r_0.png",
                    "punch_t_r_0.png",
                    "punch_t_r_0.png",
                    "punch_t_r_0.png",
                    "punch_t_r_1.png",
                    "punch_t_r_2.png",
                    "punch_t_r_3.png"]
        }
        if(stageVar.currentStage == 5)
        {
            return ["punch_t_r_0.png",
                    "punch_t_r_1.png",
                    "punch_t_r_2.png",
                    "punch_t_r_3.png"]
        }
        if(stageVar.currentStage == 6)
        {
            return ["punch_t_r_0.png",
                    "punch_t_r_1.png",
                    "punch_t_r_2.png",
                    "punch_t_r_1.png",
                    "punch_t_r_2.png",
                    "punch_t_r_3.png"]
        }
        if(stageVar.currentStage == 8)
        {
            return ["punch_t_r_0.png",
                    "punch_t_r_0.png",
                    "punch_t_r_1.png",
                    "punch_t_r_2.png",
                    "punch_t_r_3.png"]
        }
        return ["punch_t_r_0.png",
                "punch_t_r_1.png",
                "punch_t_r_2.png",
                "punch_t_r_3.png"]
    }
    override var contactFrame: String {
        
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return "punch_t_r_2.png"
        }
        if(stageVar.currentStage == 6)
        {
            return "punch_t_r_2.png"
        }
        if(stageVar.currentStage == 5)
        {
            return "punch_t_r_2.png"
        }
        return "punch_t_r_2.png"
    }
}

class HookTopLeftOpponentState: AttackOpponentState {
    override var animFrames: [String] {
        
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return ["hook_t_l_0.png",
                    "hook_t_l_0.png",
                    "hook_t_l_0.png",
                    "hook_t_l_0.png",
                    "hook_t_l_1.png",
                    "hook_t_l_2.png",
                    "hook_t_l_3.png"]
        }
        if(stageVar.currentStage == 7)
        {
            return ["hook_t_r_0.png",
                    "hook_t_r_0.png",
                    "hook_t_r_0.png",
                    "hook_t_l_2.png",
                    "hook_t_l_3.png"]
        }
        return ["hook_t_l_0.png",
                "hook_t_l_1.png",
                "hook_t_l_2.png",
                "hook_t_l_3.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return "hook_t_l_2.png"
        }
        if(stageVar.currentStage == 7)
        {
            return "hook_t_l_2.png"
        }
        return "hook_t_l_2.png"
    }
}

class HookTopRightOpponentState: AttackOpponentState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return ["hook_t_r_0.png",
                    "hook_t_r_0.png",
                    "hook_t_r_0.png",
                    "hook_t_r_0.png",
                    "hook_t_r_1.png",
                    "hook_t_r_2.png",
                    "hook_t_r_3.png"]
        }
        if(stageVar.currentStage == 7)
        {
            return ["hook_t_r_0.png",
                    "hook_t_r_0.png",
                    "hook_t_r_0.png",
                    "hook_t_r_1.png",
                    "hook_t_r_2.png"]
        }
        return ["hook_t_r_0.png",
                "hook_t_r_1.png",
                "hook_t_r_2.png",
                "hook_t_r_3.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
             return "hook_t_r_2.png"
        }
        if(stageVar.currentStage == 7)
        {
             return "hook_t_r_1.png"
        }
        return "hook_t_r_2.png"
    }
}

class PunchBottomLeftOpponentState: AttackOpponentState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return ["upper_t_l_0.png",
                    "upper_t_l_0.png",
                    "upper_t_l_0.png",
                    "upper_t_l_0.png",
                    "upper_t_l_1.png",
                    "upper_t_l_2.png",
                    "upper_t_l_3.png"]
        }
        if(stageVar.currentStage == 4 || stageVar.currentStage == 5)
        {
            return ["upper_t_l_0.png",
                    "upper_t_l_0.png",
                    "upper_t_l_0.png",
                    "upper_t_l_1.png",
                    "upper_t_l_2.png",
                    "upper_t_l_3.png"]
        }
        if(stageVar.currentStage == 7)
        {
            return ["upper_t_l_0.png",
                    "upper_t_l_0.png",
                    "upper_t_l_0.png",
                    "upper_t_l_2.png",
                    "upper_t_l_3.png"]
        }
        return ["upper_t_l_0.png",
                "upper_t_l_1.png",
                "upper_t_l_2.png",
                "upper_t_l_3.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return "upper_t_l_2.png"
        }
        if(stageVar.currentStage == 4)
        {
            return "upper_t_l_2.png"
        }
        if(stageVar.currentStage == 7)
        {
            return "upper_t_l_2.png"
        }
        return "upper_t_l_2.png"
    }
}

class PunchBottomRightOpponentState: AttackOpponentState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return ["upper_t_r_0.png",
                    "upper_t_r_0.png",
                    "upper_t_r_0.png",
                    "upper_t_r_0.png",
                    "upper_t_r_1.png",
                    "upper_t_r_2.png",
                    "upper_t_r_3.png"]

        }
        if(stageVar.currentStage == 4 || stageVar.currentStage == 5)
        {
            return ["upper_t_r_0.png",
                    "upper_t_r_0.png",
                    "upper_t_r_0.png",
                    "upper_t_r_1.png",
                    "upper_t_r_2.png",
                    "upper_t_r_3.png"]
            
        }
        if(stageVar.currentStage == 7)
        {
            return ["upper_t_r_0.png",
                    "upper_t_r_0.png",
                    "upper_t_r_0.png",
                    "upper_t_r_2.png",
                    "upper_t_r_3.png"]
        }
        if(stageVar.currentStage == 9)
        {
            return ["upper_t_r_0.png",
                    "upper_t_r_0.png",
                    "upper_t_r_1.png",
                    "upper_t_r_2.png",
                    "upper_t_r_3.png",
                    "upper_t_r_3.png",
                    "upper_t_r_3.png"]
        }
        return ["upper_t_r_0.png",
                "upper_t_r_1.png",
                "upper_t_r_2.png",
                "upper_t_r_3.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 1 || stageVar.currentStage == 2 || stageVar.currentStage == 3)
        {
            return "upper_t_r_2.png"
        }
        if(stageVar.currentStage == 4)
        {
            return "upper_t_r_2.png"
        }
        if(stageVar.currentStage == 7)
        {
            return "upper_t_r_2.png"
        }
        return "upper_t_r_2.png"
    }
}

// New Code Start
class PunchS1OpponentState: AttackOpponentState {
    override var animFrames: [String] {
        
        if(stageVar.currentStage == 1)
        {
            return ["yawn_p_r_0.png",
                    "yawn_p_r_1.png",
                    "yawn_p_r_0.png",
                    "yawn_p_r_1.png",
                    "yawn_p_r_2.png",
                    "yawn_p_r_3.png",
                    "yawn_p_r_4.png",
                    "yawn_p_r_5.png"]
        }
        if(stageVar.currentStage == 4)
        {
            return ["wind_0.png",
                    "wind_1.png",
                    "wind_2.png",
                    "wind_3.png",
                    "wind_4.png",
                    "wind_5.png",
                    "wind_6.png",
                    "wind_7.png",
                    "wind_8.png",
                    "wind_9.png",
                    "wind_10.png",
                    "wind_11.png",
                    "wind_12.png",
                    "wind_13.png",
                    "wind_14.png"]
        }
        if(stageVar.currentStage == 6)
        {
            return ["ps1_0.png",
                    "ps1_1.png",
                    "ps1_2.png",
                    "ps1_3.png",
                    "ps1_4.png",
                    "ps1_5.png",
                    "ps1_6.png",
                    "ps1_12.png",
                    "ps1_13.png"]
            
        }
        if(stageVar.currentStage == 7)
        {
            return["taunt_1.png",
                   "taunt_2.png",
                   "taunt_3.png",
                   "taunt_4.png",
                   "taunt_5.png",
                   "taunt_6.png",
                   "taunt_7.png",
                   "taunt_8.png",
                   "upper_t_r_0.png",
                   "upper_t_r_0.png",
                   "upper_t_r_0.png",
                   "upper_t_r_2.png",
                   "upper_t_r_3.png"]
            
        }
        if(stageVar.currentStage == 8)
        {
                    return ["taunt_1.png",
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
                            "punch_t_l_2.png",
                            "punch_t_l_3.png",
                            "punch_t_l_2.png",
                            "punch_t_l_3.png"]
        }
        if(stageVar.currentStage == 9)
        {
            return ["ps1_0.png",
                    "ps1_1.png",
                    "ps1_2.png",
                    "ps1_0.png",
                    "ps1_1.png",
                    "ps1_2.png",
                    "ps1_0.png",
                    "ps1_1.png",
                    "ps1_2.png",
                    "ps1_3.png",
                    "ps1_4.png",
                    "ps1_5.png"]
            
        }
        return ["punch_t_l_0.png",
                "punch_t_l_1.png",
                "punch_t_l_2.png",
                "punch_t_l_3.png"]

    }
    override var contactFrame: String {
        if(stageVar.currentStage == 1)
        {
            return "yawn_p_r_4.png"
        }
        if(stageVar.currentStage == 4)
        {
            return "wind_13.png"
        }
        if(stageVar.currentStage == 6)
        {
            return "ps1_12.png"
        }
        if(stageVar.currentStage == 7)
        {
            return "upper_t_r_2.png"
        }
        if(stageVar.currentStage == 8)
        {
            return "punch_t_l_2.png"
        }
        if(stageVar.currentStage == 9)
        {
            return "ps1_4.png"
        } 
        return "punch_t_l_2.png"
    }
}

class PunchS2OpponentState: AttackOpponentState {
    override var animFrames: [String] {
        
       
        if(stageVar.currentStage == 5)
        {
            return ["ps1_0.png",
                    "ps1_1.png",
                    "ps1_2.png",
                    "ps1_3.png",
                    "ps2_4.png"]
        }
        
        if(stageVar.currentStage == 8)
        {
            return ["taunt_1.png",
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
                    "punch_t_r_2.png",
                    "punch_t_r_3.png",
                    "punch_t_r_2.png",
                    "punch_t_r_3.png"]
        }
        return ["punch_b_r_0.png",
                "punch_b_r_1.png",
                "punch_b_r_2.png",
                "punch_b_r_3.png",
                "punch_b_r_4.png",
                "punch_b_r_5.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 5)
        {
             return "ps2_4.png"
        }
        if(stageVar.currentStage == 8)
        {
            return "punch_t_r_2.png"
        }
        return "punch_b_r_3.png"
    }
}

class PunchS3OpponentState: AttackOpponentState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 8)
        {
            return ["ps3_0.png",
                    "ps3_1.png",
                    "ps3_2.png",
                    "ps3_3.png"]
        }
        return ["punch_b_r_0.png",
                "punch_b_r_1.png",
                "punch_b_r_2.png",
                "punch_b_r_3.png",
                "punch_b_r_4.png",
                "punch_b_r_5.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 8)
        {
             return "ps3_3.png"
        }
        return "punch_b_r_3.png"
    }
}

class PunchS4OpponentState: AttackOpponentState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 8)
        {
            return ["ps4_0.png",
                    "ps4_1.png",
                    "ps4_2.png",
                    "ps4_3.png"]
        }
        return ["punch_b_r_0.png",
                "punch_b_r_1.png",
                "punch_b_r_2.png",
                "punch_b_r_3.png",
                "punch_b_r_4.png",
                "punch_b_r_5.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 8)
        {
            return "ps4_3.png"
        }
        return "punch_b_r_3.png"
    }
}

class PunchS5OpponentState: AttackOpponentState {
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

class HookS1OpponentState: AttackOpponentState {
    override var animFrames: [String] {
        
        if(stageVar.currentStage == 2)
        {
            return ["ps1_0.png",
                    "ps1_1.png",
                    "ps1_2.png",
                    "ps1_3.png",
                    "ps1_4.png",
                    "ps1_5.png"]
            
        }
        if(stageVar.currentStage == 4)
        {
            return ["wind_u_r_0.png",
                    "wind_u_r_1.png",
                    "wind_u_r_2.png",
                    "wind_u_r_3.png",
                    "wind_u_r_4.png",
                    "wind_u_r_5.png",
                    "wind_u_r_6.png",
                    "wind_u_r_7.png",
                    "wind_u_r_8.png",
                    "wind_u_r_9.png",
                    "wind_u_r_10.png",
                    "wind_u_r_11.png"]
            
        }
        if(stageVar.currentStage == 5)
        {
            return ["h1_0.png",
                    "h1_0.png",
                    "h1_0.png",
                    "h1_1.png",
                    "h1_1.png",
                    "h1_1.png",
                    "h1_1.png",
                    "h1_1.png",
                    "h1_1.png",
                    "h1_2.png",
                    "h1_3.png",
                    "h1_4.png",
                    "h1_5.png"]
            
        }
        if(stageVar.currentStage == 6)
        {
            return ["h1_0.png",
                    "h1_1.png",
                    "h1_2.png",
                    "h1_3.png",
                    "h1_4.png",
                    "h1_5.png",
                    "h1_6.png",
                    "h1_7.png",
                    "h1_8.png",
                    "h1_9.png"]
        }
        if(stageVar.currentStage == 7)
        {
            return["taunt_1.png",
                   "taunt_2.png",
                   "taunt_3.png",
                   "taunt_4.png",
                   "taunt_5.png",
                   "taunt_6.png",
                   "hook_t_l_1.png",
                   "hook_t_l_2.png",
                   "hook_t_l_3.png"]
        }
        if(stageVar.currentStage == 8)
        {
            return ["h1_0.png",
                    "h1_1.png",
                    "h1_2.png"]
            
        }
        return ["hook_t_l_0.png",
                "hook_t_l_1.png",
                "hook_t_l_2.png",
                "hook_t_l_3.png",
                "hook_t_l_4.png",
                "hook_t_l_5.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 2)
        {
             return "ps1_4.png"
        }
        if(stageVar.currentStage == 4)
        {
            return "wind_u_r_10.png"
        }
        if(stageVar.currentStage == 5)
        {
            return "h1_4.png"
        }
        if(stageVar.currentStage == 6)
        {
            return "h1_8.png"
        }
        if(stageVar.currentStage == 7)
        {
            return "hook_t_l_2.png"
        }
        if(stageVar.currentStage == 8)
        {
            return "h1_2.png"
        }
        return "hook_t_l_3.png"
    }
}

class HookS2OpponentState: AttackOpponentState {
    override var animFrames: [String] {
        
        if(stageVar.currentStage == 2)
        {
            return ["ps2_0.png",
                    "ps2_1.png",
                    "ps2_2.png",
                    "ps2_3.png",
                    "ps2_4.png",
                    "ps2_5.png"]
        }
        if(stageVar.currentStage == 6)
        {
            return ["hs2_0.png",
                    "hs2_1.png",
                    "hs2_0.png",
                    "hs2_1.png",
                    "hs2_2.png",
                    "hs2_3.png",
                    "hs2_4.png"]
        }
        if(stageVar.currentStage == 5)
        {
            return ["ps1_0.png",
                    "ps1_1.png",
                    "ps1_2.png",
                    "ps1_3.png",
                    "hook_t_l_0.png",
                    "hook_t_l_1.png",
                    "hook_t_l_2.png",
                    "hook_t_l_3.png"]
        }
        if(stageVar.currentStage == 7)
        {
            return["taunt_5.png",
                   "taunt_6.png",
                   "taunt_7.png",
                   "taunt_8.png",
                   "taunt_9.png",
                   "hook_t_r_1.png",
                   "hook_t_r_2.png",
                   "hook_t_r_2.png"]
        }
        if(stageVar.currentStage == 8)
        {
            return ["h1_3.png",
                    "h1_4.png",
                    "h1_5.png"]
            
        }
        return ["hook_t_l_0.png",
                "hook_t_l_1.png",
                "hook_t_l_2.png",
                "hook_t_l_3.png",
                "hook_t_l_4.png",
                "hook_t_l_5.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 2)
        {
            return "ps2_4.png"
        }
        if(stageVar.currentStage == 6)
        {
            return "hs2_3.png"
        }
        if(stageVar.currentStage == 4)
        {
            return "hook_t_l_2.png"
        }
        if(stageVar.currentStage == 7)
        {
            return "hook_t_r_2.png"
        }
        if(stageVar.currentStage == 8)
        {
            return "h1_4.png"
        }
        return "hook_t_l_3.png"
    }
}

class HookS3OpponentState: AttackOpponentState {
    override var animFrames: [String] {
        if(stageVar.currentStage == 5)
        {
            return ["ps1_0.png",
                    "ps1_1.png",
                    "ps1_2.png",
                    "ps1_3.png",
                    "hook_t_r_0.png",
                    "hook_t_r_1.png",
                    "hook_t_r_2.png",
                    "hook_t_r_3.png"]
        }
        if(stageVar.currentStage == 6)
        {
                return ["hs2_0.png",
                        "hs2_1.png",
                        "hs2_0.png",
                        "hs2_1.png",
                        "hs2_2b.png",
                        "hs2_3b.png",
                        "hs2_4b.png"]
        }
        if(stageVar.currentStage == 7)
        {
            return["taunt_1.png",
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
                   "taunt_13.png",
                   "taunt_2.png",
                   "taunt_3.png",
                   "taunt_4.png",
                   "hook_t_r_1.png",
                   "hook_t_r_2.png",
                   "hook_t_r_3.png"]
        }
        return ["hook_t_l_0.png",
                "hook_t_l_1.png",
                "hook_t_l_2.png",
                "hook_t_l_3.png",
                "hook_t_l_4.png",
                "hook_t_l_5.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 5)
        {
            return "hook_t_r_2.png"
        }
        if(stageVar.currentStage == 6)
        {
            return "hs2_3b.png"
        }
        if(stageVar.currentStage == 7)
        {
            return "hook_t_r_2.png"
        }
        return "hook_t_l_3.png"
    }
}

class HookS4OpponentState: AttackOpponentState {
    override var animFrames: [String] {
        
        if(stageVar.currentStage == 5)
        {
            return ["h1_0.png",
                    "h1_0.png",
                    "h1_0.png",
                    "h1_1.png",
                    "h1_1.png",
                    "h1_1.png",
                    "h1_1.png",
                    "h1_1.png",
                    "h1_1.png",
                    "hs2_0.png",
                    "hs2_1.png",
                    "hs2_2.png"]
        }
        return ["hook_t_l_0.png",
                "hook_t_l_1.png",
                "hook_t_l_2.png",
                "hook_t_l_3.png",
                "hook_t_l_4.png",
                "hook_t_l_5.png"]
    }
    override var contactFrame: String {
        if(stageVar.currentStage == 5)
        {
            return "hs2_1.png"
        }
        return "hook_t_l_3.png"
    }
}

class HookS5OpponentState: AttackOpponentState {
    override var animFrames: [String] {
        return ["hook_t_l_0.png",
                "hook_t_l_1.png",
                "hook_t_l_2.png",
                "hook_t_l_3.png",
                "hook_t_l_4.png",
                "hook_t_l_5.png"]
    }
    override var contactFrame: String {
        return "hook_t_l_3.png"
    }
}

// New Code End

// MARK: -


// MARK: -

class HookBottomLeftOpponentState: AttackOpponentState {
    override var animFrames: [String] {
        return ["hook_b_l_0.png",
                "hook_b_l_1.png",
                "hook_b_l_2.png",
                "hook_b_l_3.png",
                "hook_b_l_4.png",
                "hook_b_l_5.png",
                "hook_b_l_6.png"]
    }
    override var contactFrame: String {
        return "hook_b_l_3.png"
    }
}


// MARK: -

class HookBottomRightOpponentState: AttackOpponentState {
    override var animFrames: [String] {
        return ["hook_b_r_0.png",
                "hook_b_r_1.png",
                "hook_b_r_2.png",
                "hook_b_r_3.png",
                "hook_b_r_4.png",
                "hook_b_r_5.png",
                "hook_b_r_6.png"]
    }
    override var contactFrame: String {
        return "hook_b_r_3.png"
    }
}
