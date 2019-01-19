import Foundation


struct DataHelper {
    static func isEffectsEnabled() -> Bool {
        UserDefaults.standard.register(defaults: ["EffectsEnabled": true])
        return UserDefaults.standard.bool(forKey: "EffectsEnabled")
    }
    
    static func setEffectsEnabled(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "EffectsEnabled")
        UserDefaults.standard.synchronize()
    }
    
    static func isMusicsEnabled() -> Bool {
        UserDefaults.standard.register(defaults: ["MusicsEnabled": true])
        return UserDefaults.standard.bool(forKey: "MusicsEnabled")
    }
    
    static func setMusicsEnabled(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "MusicsEnabled")
        UserDefaults.standard.synchronize()
    }
    
    // New Code Start
    static func isTouchPadEnabled() -> Bool {
        UserDefaults.standard.register(defaults: ["TouchPadEnabled": true])
        // New Code Start
        return UserDefaults.standard.bool(forKey: "TouchPadEnabled") && AppConfig.TouchPadLightBorder
        // New Code End
    }
    
    static func setTouchPadEnabled(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "TouchPadEnabled")
        UserDefaults.standard.synchronize()
    }
    // New Code End
	
    static func isTutorialEnabled() -> Bool {
        UserDefaults.standard.register(defaults: ["TutorialEnabled": true])
        return UserDefaults.standard.bool(forKey: "TutorialEnabled")
    }
	
    static func setTutorialEnabled(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "TutorialEnabled")
        UserDefaults.standard.synchronize()
    }
    
    static func getBestScore() -> Int {
        return UserDefaults.standard.integer(forKey: "BestScore")
    }
    
    static func setBestScore(bestScore: Int) {
        UserDefaults.standard.set(bestScore, forKey: "BestScore")
        UserDefaults.standard.synchronize()
    }
    
    static func getContinueCount() -> Int {
        return UserDefaults.standard.integer(forKey: "ContinueCount")
    }
    
    static func setContinueCount(continueCount: Int) {
        UserDefaults.standard.set(continueCount, forKey: "ContinueCount")
        UserDefaults.standard.synchronize()
    }
	
	// MARK:
	
	static func getContinue2Price() -> String? {
        return UserDefaults.standard.string(forKey: "Continue2Price")
    }
	
    static func setContinue2Price(price: String?) {
        UserDefaults.standard.set(price, forKey: "Continue2Price")
        UserDefaults.standard.synchronize()
    }
	
    static func getContinue6Price() -> String? {
        return UserDefaults.standard.string(forKey: "Continue6Price")
    }
	
    static func setContinue6Price(price: String?) {
        UserDefaults.standard.set(price, forKey: "Continue6Price")
        UserDefaults.standard.synchronize()
    }
	
    static func getContinue15Price() -> String? {
        return UserDefaults.standard.string(forKey: "Continue15Price")
    }
	
    static func setContinue15Price(price: String?) {
        UserDefaults.standard.set(price, forKey: "Continue15Price")
        UserDefaults.standard.synchronize()
    }
	
    static func getContinue35Price() -> String? {
        return UserDefaults.standard.string(forKey: "Continue35Price")
    }
	
    static func setContinue35Price(price: String?) {
        UserDefaults.standard.set(price, forKey: "Continue35Price")
        UserDefaults.standard.synchronize()
    }
}
