import Foundation
import GLKit


// MARK: -

final class GameControlConfig {
	static let ControlWidth: CGFloat = 4
    // New Code Start
    // static let ControlGap: CGFloat = 6
	static let ControlGap: CGFloat = 0
    // New Code End
	static let HookChargeTime: TimeInterval = 1
    
    // New Code Start
    static let TouchPadOverlayStrength: Float = 0.5
    // New Code End

	// MARK:
	
    static func backgroundColor(forStage stage: Int) -> UIColor {
		switch stage {
		case 2: return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
			
		case 3: return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
		
		case 4: return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
			
		case 5: return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
			
		case 6: return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
			
		case 7: return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
			
		case 8: return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
			
		case 9: return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
			
		default: return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
		}
	}
	
	static func normalColor(forStage stage: Int) -> UIColor {
		switch stage {
		case 2: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
			
		case 3: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
		
		case 4: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
			
		case 5: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
			
		case 6: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
			
		case 7: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
			
		case 8: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
			
		case 9: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
			
		default: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
		}
	}
	
    // touchbar
	static func highlightedColor(forStage stage: Int) -> UIColor {
		/*switch stage {
		case 2: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
			
		case 3: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
		
		case 4: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
			
		case 5: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
			
		case 6: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
			
		case 7: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
			
		case 8: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
			
		case 9: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
			
         default:}*/ return UIColor.white
		
	}
    
    // New Code Start
    static func touchPadOverlayColor(forStage stage: Int) -> GLKVector4 {
        switch stage {
        case 2: return GLKVector4Make(255.0 / 255, 0.0 / 255, 0.0 / 255, 1)
            
        case 3: return GLKVector4Make(255.0 / 255, 0.0 / 255, 0.0 / 255, 1)
            
        case 4: return GLKVector4Make(255.0 / 255, 0.0 / 255, 0.0 / 255, 1)
            
        case 5: return GLKVector4Make(255.0 / 255, 0.0 / 255, 0.0 / 255, 1)
            
        case 6: return GLKVector4Make(255.0 / 255, 0.0 / 255, 0.0 / 255, 1)
            
        case 7: return GLKVector4Make(255.0 / 255, 0.0 / 255, 0.0 / 255, 1)
            
        case 8: return GLKVector4Make(255.0 / 255, 0.0 / 255, 0.0 / 255, 1)
            
        case 9: return GLKVector4Make(255.0 / 255, 0.0 / 255, 0.0 / 255, 1)
            
        //default: return GLKVector4Make(255.0 / 255, 0.0 / 255, 0.0 / 255, 1)
            
        default: return GLKVector4Make(0.0 / 255, 0.0 / 255, 0.0 / 255, 0.1)
        }
    }
    // New Code End

}
