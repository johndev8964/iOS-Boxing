import Foundation


// MARK: -

class CelebrateOpponentState: OpponentState {
    override var animFrames: [String] {
        return ["celebrate_0.png",
				"celebrate_1.png",
				"celebrate_2.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }
}
