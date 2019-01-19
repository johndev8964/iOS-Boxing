import Foundation


// MARK: -

class KnockOutPlayerState: PlayerState {
    override var animFrames: [String] {
        return ["knock_out_0.png",
                "knock_out_1.png",
                "knock_out_2.png"]
    }
    
    // MARK:
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }
}
