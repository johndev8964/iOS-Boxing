import Foundation


// MARK: -

protocol OpponentNodeDelegate: class {
    func opponentNodeDidContactWithPunchTopLeft(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithPunchTopRight(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithPunchBottomLeft(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithPunchBottomRight(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithHookTopLeft(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithHookTopRight(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithHookBottomLeft(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithHookBottomRight(_ opponentNode: OpponentNode)
    
    // New Code Start
    func opponentNodeDidContactWithPunchS1(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithPunchS2(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithPunchS3(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithPunchS4(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithPunchS5(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithHookS1(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithHookS2(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithHookS3(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithHookS4(_ opponentNode: OpponentNode)
    func opponentNodeDidContactWithHookS5(_ opponentNode: OpponentNode)
    // New Code End

    func opponentNodeDidBlock(_ opponentNode: OpponentNode)
    func opponentNodeDidGetAttack(_ opponentNode: OpponentNode, hook: Bool)
    func opponentNodeDidKnockOut(_ opponentNode: OpponentNode)
    func opponentNodeDidFinishKnockOut(_ opponentNode: OpponentNode)
    func opponentNodeDidFinishCelebration(_ opponentNode: OpponentNode)
}
