import Foundation


// MARK: -

class IdlePlayerState: PlayerState {
    override var animFrames: [String] {
        return ["idle_0.png",
                "idle_1.png",
                "idle_2.png",
                "idle_3.png"]
    }
    
    // MARK:
    
    override func didShowAllFrames() {
        super.didShowAllFrames()
        
        currentFrameIndex = 0
        
        delegate?.playerState(self, didUpdateFrameTo: animFrames[currentFrameIndex])
    }
}
