import Foundation


// MARK: -

protocol OpponentStateDelegate: class {
    func opponentStateFrameInterval(_ state: OpponentState) -> TimeInterval
    func opponentState(_ state: OpponentState, didUpdateFrameTo currentFrame: String)
    func opponentStateDidShowAllFrames(_ state: OpponentState)
}
