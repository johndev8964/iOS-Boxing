import Foundation


// MARK: -

class BlockPlayerState: PlayerState {
    override var animFrames: [String] {
        return ["block_0.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdlePlayerState.Type, is TiredPlayerState.Type, is KnockOutPlayerState.Type:
            return true
            
        case is GetPunchBottomLeftPlayerState.Type, is GetPunchBottomRightPlayerState.Type,
             is GetPunchBottomLeftBlockedPlayerState.Type, is GetPunchBottomRightBlockedPlayerState.Type,
             is GetPunchTopLeftBlockedPlayerState.Type, is GetPunchTopRightBlockedPlayerState.Type,
             is GetPunchS1BlockedPlayerState.Type, is GetPunchS2BlockedPlayerState.Type,
             is GetPunchS3BlockedPlayerState.Type, is GetPunchS4BlockedPlayerState.Type,
             is GetPunchS5BlockedPlayerState.Type,
             is GetHookTopLeftPlayerState.Type, is GetHookTopRightPlayerState.Type,
             is GetHookBottomLeftPlayerState.Type, is GetHookBottomRightPlayerState.Type,
             is GetHookTopLeftBlockedPlayerState.Type, is GetHookTopRightBlockedPlayerState.Type,
             is GetHookBottomLeftBlockedPlayerState.Type, is GetHookBottomRightBlockedPlayerState.Type,
             is GetHookS1PlayerState.Type, is GetHookS2PlayerState.Type, is GetHookS3PlayerState.Type,
             is GetHookS4PlayerState.Type, is GetHookS5PlayerState.Type,
             is GetHookS1BlockedPlayerState.Type, is GetHookS2BlockedPlayerState.Type, is GetHookS3BlockedPlayerState.Type,
             is GetHookS4BlockedPlayerState.Type, is GetHookS5BlockedPlayerState.Type:
            return true
            
        default:
            return false
        }
    }
    
    // MARK:
    
    override func didShowAllFrames() {
        super.didShowAllFrames()
        
        currentFrameIndex = 0
        
        delegate?.playerState(self, didUpdateFrameTo: animFrames[currentFrameIndex])
    }
}
