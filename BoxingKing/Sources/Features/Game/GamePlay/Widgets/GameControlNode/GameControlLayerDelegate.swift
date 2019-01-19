import Foundation


// MARK: -

protocol GameControlLayerDelegate: class {
    func gameControlLayerDidRequestPunchTopLeft(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestPunchTopRight(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestPunchBottomLeft(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestPunchBottomRight(_ sender: GameControlLayerNode)
    
    func gameControlLayerDidRequestHookTopLeft(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestHookTopRight(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestHookBottomLeft(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestHookBottomRight(_ sender: GameControlLayerNode)
    
    func gameControlLayerDidRequestDodgeLeft(_ sender: GameControlLayerNode, long:Bool)
    func gameControlLayerDidRequestDodgeRight(_ sender: GameControlLayerNode, long:Bool)
    
    func gameControlLayerDidRequestHoldBlock(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestReleaseBlock(_ sender: GameControlLayerNode)
    
    // New Code Start
    func gameControlLayerDidRequestPunchS1(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestPunchS2(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestPunchS3(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestPunchS4(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestPunchS5(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestHookS1(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestHookS2(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestHookS3(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestHookS4(_ sender: GameControlLayerNode)
    func gameControlLayerDidRequestHookS5(_ sender: GameControlLayerNode)
    // New Code End
}
