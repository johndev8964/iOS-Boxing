import Foundation


// MARK: -

class TiredPlayerState: PlayerState {
    override var animFrames: [String] {
        return ["tired_0.png",
                "tired_1.png",
                "tired_2.png",
                "tired_3.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GetAttackPlayerState.Type, is KnockOutPlayerState.Type, is IdlePlayerState.Type:
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
