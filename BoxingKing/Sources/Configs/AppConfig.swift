import Foundation
import CoreGraphics
import GLKit

struct AppConfig {
    static let DebugMode = true
    static let AntiAliasingEnabled = false
    
    // New Code Start
    static let clockTime: TimeInterval = 60
    static let holdBlock = false
    // New Code End
    
    static let LeaderboardId = "the.boxing.games.ifunco"
    
    static let Continue2ProductId = "2"
    static let Continue6ProductId = "6"
    static let Continue15ProductId = "15"
    static let Continue35ProductId = "35"
    
    static let AdvertPlatformAdmob = 1
    static let AdvertPlatformChartboost = 2
    static let AdvertPlatform = 3 //AdvertPlatformAdmob + AdvertPlatformChartboost // 1 = admob, 2 = chartboost and 3 = both
    
    static let AdvertRewardVideo = 1
    static let AdvertRewardInterstitial = 2
    static let AdvertReward = 3 // AdvertRewardVideo + AdvertRewardInterstitial // 1 = video, 2 = interstitial and 3 = both

    static let PlayerLoadedNotification = "PlayerLoadedNotification"
    static let OpponentLoadedNotification = "OpponentLoadedNotification"
    static let BestScoreFetchedNotification = "BestScoreFetchedNotification"
    static let PurchaseSuccessNotification = "PurchaseSuccessNotification"
    static let PurchaseErrorNotification = "PurchaseErrorNotification"
    static let WatchAdNotification = "WatchAdNotification"
    static let WatchAdBackNotification = "WatchAdBackNotification"

    static let AdmobAppId = "ca-app-pub-2532745332818589~2364935019"
    static let AdmobBannerUnitId = "ca-app-pub-2532745332818589/3841668218"
    static let AdmobRewardedVideoUnitId = "ca-app-pub-2532745332818589/6795134610"
    static let AdmobInterstitialUnitId = "ca-app-pub-2532745332818589/5318401418"

    static let ChartboostAppId = "5a086c74db9fb80ae1030b77"
    static let ChartboostAppSignature = "b655f83f767bd5f7e64f29ae8622eb6257cd7dba"
    
    static let AppRateUrl = "itms-apps://itunes.apple.com/app/id1261077692"
    static let AppDownloadUrl = "https://itunes.apple.com/app/id1261077692"
    static let AppShareText = "https://itunes.apple.com/app/id1261077692"
	
	static let ButtonHighlightedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
	static let ButtonHighlightedStrength: CGFloat = 0.25
	static let ButtonDisabledColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
	static let ButtonDisabledStrength: CGFloat = 0.25
	
    static let LoadingBarColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
	static let LoadingBackgroundColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
	
	static let WinOverlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
	static let WinOverlayStrength: CGFloat = 0.9

	static let LoseOverlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
	static let LoseOverlayStrength: CGFloat = 0.9
    
    // New Code Start
    // use for every transition between scenes this constant
    static let FadeDuration: TimeInterval = 1.0
    
    // touchPad highlight
    //static let TouchPadOverlayColor = GLKVector4Make(0.0 / 255, 0.0 / 255, 0.0 / 255, 0)
    //static let TouchPadOverlayStrength: Float = 0.0
    //static let TouchPadOutlineColor = GLKVector4Make(33.0 / 255, 33.0 / 255, 0.0 / 255, 1)
 
    static let DodgeSlideSpeed: TimeInterval = 0.2
    static let DodgeSlideSize: CGFloat = 20

    // toggle off/on the touch pad and the bars
    static let TouchPadLightArea = false
    static let TouchPadLightBorder = true
    // New Code End
    
    // New Code Start
    static let SelectStageDarkOverlay = false
    // New Code End

}

extension UIImage {
    func resized(targetSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
