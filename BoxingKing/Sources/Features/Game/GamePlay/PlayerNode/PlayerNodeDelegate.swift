import Foundation


// MARK: -

protocol PlayerNodeDelegate: class {
    func playerNodeDidContactWithPunchTopLeft(_ playerNode: PlayerNode)
    func playerNodeDidContactWithPunchTopRight(_ playerNode: PlayerNode)
    func playerNodeDidContactWithPunchBottomLeft(_ playerNode: PlayerNode)
    func playerNodeDidContactWithPunchBottomRight(_ playerNode: PlayerNode)
    func playerNodeDidContactWithHookTopLeft(_ playerNode: PlayerNode)
    func playerNodeDidContactWithHookTopRight(_ playerNode: PlayerNode)
    func playerNodeDidContactWithHookBottomLeft(_ playerNode: PlayerNode)
    func playerNodeDidContactWithHookBottomRight(_ playerNode: PlayerNode)
    
    // New Code Start
    func playerNodeDidContactWithPunchS1(_ playerNode: PlayerNode)
    func playerNodeDidContactWithPunchS2(_ playerNode: PlayerNode)
    func playerNodeDidContactWithPunchS3(_ playerNode: PlayerNode)
    func playerNodeDidContactWithPunchS4(_ playerNode: PlayerNode)
    func playerNodeDidContactWithPunchS5(_ playerNode: PlayerNode)
    func playerNodeDidContactWithHookS1(_ playerNode: PlayerNode)
    func playerNodeDidContactWithHookS2(_ playerNode: PlayerNode)
    func playerNodeDidContactWithHookS3(_ playerNode: PlayerNode)
    func playerNodeDidContactWithHookS4(_ playerNode: PlayerNode)
    func playerNodeDidContactWithHookS5(_ playerNode: PlayerNode)
    // New Code End
    
    func playerNodeDidBlock(_ playerNode: PlayerNode)
    func playerNodeDidGetAttack(_ playerNode: PlayerNode, hook: Bool, blocked: Bool)
    func playerNodeDidKnockOut(_ playerNode: PlayerNode)
    func playerNodeDidFinishKnockOut(_ playerNode: PlayerNode)
    func playerNodeDidFinishCelebration(_ playerNode: PlayerNode)
    func playerNodeDidRecoverEnergy(_ playerNode: PlayerNode)
}
