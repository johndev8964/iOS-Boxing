import Foundation


// MARK: -

enum GameCommand {
    enum AttackType {
        case punch
        case hook
    }
    enum AttackDirection {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        // New Code Start
        // 5 additional punches
        case s1
        case s2
        case s3
        case s4
        case s5
        // New Code End
    }
    enum BlockDirection {
        case top
        case bottom
        case all
    }
        
    case attackDamage(damage: Int)
    case opponentAttackSpeed(attackSpeed: Float)
    
    case opponentAttack(type: AttackType, direction: AttackDirection)
    case opponentBlock(direction: BlockDirection, duration: TimeInterval)
    case opponentIdle(kind: Int, duration: TimeInterval)
    case opponentTired(duration: TimeInterval)
}
