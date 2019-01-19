import Foundation
import GLKit


// MARK: -

final class PlayerConfig {
	static let EnergyRecoveryTime: TimeInterval = 0.8
	
	static let IdleFramePerSecond: Float = 10
	static let TiredFramePerSecond: Float = 10
	static let DodgeFramePerSecond: Float = 10
    
    // New Code Start
    static let DodgeLongFramePerSecond: Float = 10
    // New Code End
    
	static let BlockFramePerSecond: Float = 10
	
    static let TiredOverlayColor = GLKVector4Make(255.0 / 255, 255.0 / 255, 255.0 / 255, 1)
    static let TiredOverlayStrength: Float = 0.2
	static let TiredOutlineColor = GLKVector4Make(255.0 / 255, 255.0 / 255, 255.0 / 255, 1)
	
	static let WeakOverlayColor = GLKVector4Make(255.0 / 255, 255.0 / 255, 255.0 / 255, 1)
    static let WeakOverlayStrength: Float = 0.9
	static let WeakOutlineColor = GLKVector4Make(255.0 / 255, 255.0 / 255, 255.0 / 255, 1)
	
    static let LightHitOverlayColor = GLKVector4Make(255.0 / 255, 0.0 / 255, 4.0 / 255, 1)
    static let LightHitOverlayStrength: Float = 0.2
	static let LightHitOutlineColor = GLKVector4Make(255.0 / 255, 0.0 / 255, 4.0 / 255, 1)
	
	static let HeavyHitOverlayColor = GLKVector4Make(255.0 / 255, 0.0 / 255, 4.0 / 255, 1)
    static let HeavyHitOverlayStrength: Float = 0.9
	static let HeavyHitOutlineColor = GLKVector4Make(255.0 / 255, 0.0 / 255, 4.0 / 255, 1)

    // New Code Start
    static let BlockOverlayColor = GLKVector4Make(3.0 / 255, 146.0 / 255, 236.0 / 255, 1)
    static let BlockOverlayStrength: Float = 0.2
    static let BlockOutlineColor = GLKVector4Make(3.0 / 255, 146.0 / 255, 236.0 / 255, 1)
    // New Code End

	// MARK:
	
    static func percentX(forStage stage: Int) -> CGFloat {
        switch stage {
        case 2: return 0.49
            
        case 3: return 0.49
            
        case 4: return 0.49
            
        case 5: return 0.49
            
        case 6: return 0.49
            
        case 7: return 0.49
            
        case 8: return 0.49
            
        case 9: return 0.49
            
        default: return 0.49
        }
	}
	
	static func percentY(forStage stage: Int) -> CGFloat {
        switch stage {
        case 2: return 0.40
            
        case 3: return 0.40
            
        case 4: return 0.40
            
        case 5: return 0.40
            
        case 6: return 0.40
            
        case 7: return 0.40
            
        case 8: return 0.40
            
        case 9: return 0.40
            
        default: return 0.40
        }
	}
	
	static func percentHeight(forStage stage: Int) -> CGFloat {
        switch stage {
        case 2: return 0.70
            
        case 3: return 0.70
            
        case 4: return 0.70
            
        case 5: return 0.70
            
        case 6: return 0.70
            
        case 7: return 0.70
            
        case 8: return 0.70
            
        case 9: return 0.70
            
        default: return 0.70
        }
	}
}
