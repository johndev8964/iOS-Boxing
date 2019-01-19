import Foundation


// MARK: -

class KnockOutOpponentState: OpponentState {
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
