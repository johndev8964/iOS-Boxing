import Foundation


// MARK: -

class TiredOpponentState: OpponentState {
    override var animFrames: [String] {
        return ["tired_0.png",
                "tired_1.png",
                "tired_2.png"]
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
