import Foundation
import GLKit


// MARK: -

final class OpponentConfig {
    
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
		case 2: return 0.5
			
		case 3: return 0.5
		
		case 4: return 0.5
			
		case 5: return 0.5
			
		case 6: return 0.5
			
		case 7: return 0.5
			
		case 8: return 0.5
			
		case 9: return 0.5
			
		default: return 0.5
		}
	}
	
	static func percentY(forStage stage: Int) -> CGFloat {
		switch stage {
		case 2: return 0.57
			
		case 3: return 0.57
		
		case 4: return 0.57
			
		case 5: return 0.57
			
		case 6: return 0.57
			
		case 7: return 0.57
			
		case 8: return 0.57
			
		case 9: return 0.57
			
		default: return 0.57
		}
	}
	
	static func percentHeight(forStage stage: Int) -> CGFloat {
		switch stage {
		case 2: return 0.75
			
		case 3: return 0.75
		
		case 4: return 0.75
			
		case 5: return 0.75
			
		case 6: return 0.75
			
		case 7: return 0.75
			
		case 8: return 0.75
			
		case 9: return 0.75
			
		default: return 0.75
		}
	}
	
	static func idleFramePerSecond(forStage stage: Int) -> Float {
		switch stage {
		case 2: return 10
			
		case 3: return 10
		
		case 4: return 10
			
		case 5: return 10
			
		case 6: return 10
			
		case 7: return 10
			
		case 8: return 10
			
		case 9: return 10
			
		default: return 10
		}
	}
	
	static func tiredFramePerSecond(forStage stage: Int) -> Float {
		switch stage {
		case 2: return 10
			
		case 3: return 10
		
		case 4: return 10
			
		case 5: return 10
			
		case 6: return 10
			
		case 7: return 10
			
		case 8: return 10
			
		case 9: return 10
			
		default: return 10
		}
	}
	
	static func blockFramePerSecond(forStage stage: Int) -> Float {
		switch stage {
		case 2: return 10
			
		case 3: return 10
		
		case 4: return 10
			
		case 5: return 10
			
		case 6: return 10
			
		case 7: return 10
			
		case 8: return 10
			
		case 9: return 10
			
		default: return 10
		}
	}
}
