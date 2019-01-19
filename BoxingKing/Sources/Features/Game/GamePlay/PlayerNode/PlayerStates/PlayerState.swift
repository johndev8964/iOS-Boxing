import Foundation


// MARK: -

class PlayerState: EHState {
    weak var delegate: PlayerStateDelegate?
    var animFrames: [String] {
        return []
    }
    var currentFrameIndex = 0
    private var timeSinceFrameUpdate: TimeInterval = 0
    
    // MARK:
    
    required init(delegate: PlayerStateDelegate) {
        super.init()
        
        self.delegate = delegate
    }
    
    // MARK:
    
    override func didEnter(from previousState: EHState?) {
        super.didEnter(from: previousState)
        
        guard animFrames.count > 0 else {
            fatalError("No animation frames provided.")
        }
        
        currentFrameIndex = 0
        
        delegate?.playerState(self, didUpdateFrameTo: animFrames[currentFrameIndex])
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        timeSinceFrameUpdate += seconds
        
        guard let delegate = delegate else {
            return
        }
        
        let frameInterval = delegate.playerStateFrameInterval(self)
        
        if timeSinceFrameUpdate > frameInterval {
            timeSinceFrameUpdate = 0
            
            if currentFrameIndex < animFrames.count {
                currentFrameIndex += 1
                
                if animFrames.indices.contains(currentFrameIndex) {
                    delegate.playerState(self, didUpdateFrameTo: animFrames[currentFrameIndex])
                }
                else if currentFrameIndex == animFrames.count {
                    didShowAllFrames()
                }
            }
        }
    }
    
    // MARK:
    
    func didShowAllFrames() {
        delegate?.playerStateDidShowAllFrames(self)
    }
}
