import Foundation


class CelebratePlayerState: PlayerState {
    override var animFrames: [String] {
        return ["celebrate_0.png",
                "celebrate_1.png",
                "celebrate_2.png",
                "celebrate_3.png"]
    }
    
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }
}
