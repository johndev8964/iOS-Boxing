import Foundation


// MARK: -

protocol PlayerStateDelegate: class {
    func playerStateFrameInterval(_ state: PlayerState) -> TimeInterval
    func playerState(_ state: PlayerState, didUpdateFrameTo currentFrame: String)
    func playerStateDidShowAllFrames(_ state: PlayerState)
}
