import UIKit
import QuartzCore
import GameKit
import GoogleMobileAds


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GKGameCenterControllerDelegate,
    GADBannerViewDelegate, GADRewardBasedVideoAdDelegate, GADInterstitialDelegate, ChartboostDelegate {
    var window: UIWindow?
    private var bannerView: GADBannerView?
    private var interstitial: GADInterstitial?
	
    // MARK:
	
    override init() {
		super.init()
	}
	
    // MARK:
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.isStatusBarHidden = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.makeKeyAndVisible()
        
        let rootViewController = GameViewController()
        rootViewController.edgesForExtendedLayout = .all
        rootViewController.extendedLayoutIncludesOpaqueBars = true
        window!.rootViewController = rootViewController
        
        AudioHelper.SharedInstance.setEffectsVolume(volume: DataHelper.isEffectsEnabled() ? 1 : 0)
        AudioHelper.SharedInstance.setMusicsVolume(volume: DataHelper.isMusicsEnabled() ? 1 : 0)
        
        //initializeGameCenter()
        initializeStoreKit()
        initializeAdmob()
        initializeChartboost()
        
        return true
    }
    
    // MARK:
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK:
    
    // New Code Start
    private var rewardVideoDisplayedCompletely = false
    // New Code End

    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        // New Code Start
        rewardVideoDisplayedCompletely = true
        // New Code End
    }
    
    // New Code Start
    // run next round after Ad video is closed
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        // New Code Start
        if rewardVideoDisplayedCompletely {
            rewardVideoDisplayedCompletely = false
            NotificationCenter.default
                .post(name: Notification.Name(AppConfig.WatchAdNotification), object: nil)
        } else {
            NotificationCenter.default
                .post(name: Notification.Name(AppConfig.WatchAdBackNotification), object: nil)
        }
        // New Code End
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                withAdUnitID: AppConfig.AdmobRewardedVideoUnitId)
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        NotificationCenter.default
            .post(name: Notification.Name(AppConfig.WatchAdNotification), object: nil)
        loadAdmobInterstitial()
    }
    
    func loadAdmobInterstitial() {
        interstitial = GADInterstitial(adUnitID: AppConfig.AdmobInterstitialUnitId)
        interstitial?.delegate = self
        interstitial?.load(GADRequest())
    }
    
    // New Code End
    
    // MARK:
    
    func didInitialize(_ status: Bool) {
        if status {
            Chartboost.cacheRewardedVideo(CBLocationGameOver)
            Chartboost.cacheInterstitial(CBLocationGameOver)
        }
    }
    
    func didCompleteRewardedVideo(_ location: String!, withReward reward: Int32) {
        // New Code Start
        rewardVideoDisplayedCompletely = true
        // New Code End
    }
    
    // New Code Start
    // run next round after Ad video is closed
    func didDismissRewardedVideo(_ location: String!) {
        if rewardVideoDisplayedCompletely {
            rewardVideoDisplayedCompletely = false
            NotificationCenter.default
                .post(name: Notification.Name(AppConfig.WatchAdNotification), object: nil)
       } else {
            NotificationCenter.default
                .post(name: Notification.Name(AppConfig.WatchAdBackNotification), object: nil)
        }
    }
    
    func didDismissInterstitial(_ location: String!) {
        NotificationCenter.default
            .post(name: Notification.Name(AppConfig.WatchAdNotification), object: nil)
    }
    
    // New Code End
    
    // MARK:
    
    func showLeaderboard() {
        guard let rootViewController = window?.rootViewController else {
            return
        }
        
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.viewState = .leaderboards
        gameCenterViewController.leaderboardIdentifier = AppConfig.LeaderboardId
        gameCenterViewController.gameCenterDelegate = self
        rootViewController.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    func submitScoreToLeaderboard(score: Int) {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let gkScore = GKScore(leaderboardIdentifier: AppConfig.LeaderboardId)
            gkScore.value = Int64(score)
            
            GKScore.report([gkScore]) {
                (error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
    func openRateUrl() {
        let rateUrl = URL(string: AppConfig.AppRateUrl)
        
        
        if #available(iOS 10.3, *)
        {
            SKStoreReviewController.requestReview()
        }
        else
        {
            if rateUrl != nil && UIApplication.shared.canOpenURL(rateUrl!)
            {
                UIApplication.shared.openURL(rateUrl!)
    
            }
        }
    }

    
    func shareApp(final: Bool = false) {
        guard let rootViewController = window?.rootViewController else {
            return
        }
		
        let shareImage = UIImage(named: final ? "share_image_final.png" : "share_image.png")
		let shareItemsArray =
				[AppConfig.AppShareText, AppConfig.AppDownloadUrl, shareImage!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareItemsArray,
                                                              applicationActivities: nil)
        activityViewController.excludedActivityTypes =
            [.airDrop, .addToReadingList, .assignToContact, .print, .saveToCameraRoll]
        activityViewController.popoverPresentationController?.sourceView = rootViewController.view
        
        rootViewController.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK:
	
	func fetchProductPrices() {
		let productIds: Set = [AppConfig.Continue2ProductId,
		                       AppConfig.Continue6ProductId,
		                       AppConfig.Continue15ProductId,
		                       AppConfig.Continue35ProductId]
        SwiftyStoreKit.retrieveProductsInfo(productIds) {
            result in

            for product in result.retrievedProducts {
				switch product.productIdentifier {
				case AppConfig.Continue2ProductId:
					DataHelper.setContinue2Price(price: product.localizedPrice)
					
				case AppConfig.Continue6ProductId:
					DataHelper.setContinue6Price(price: product.localizedPrice)
					
				case AppConfig.Continue15ProductId:
					DataHelper.setContinue15Price(price: product.localizedPrice)
					
				case AppConfig.Continue35ProductId:
					DataHelper.setContinue35Price(price: product.localizedPrice)
					
				default:
					break
				}
			}
        }
	}
    
    func purchaseContinue2() {
        purchaseProduct(productId: AppConfig.Continue2ProductId)
    }
    
    func purchaseContinue6() {
        purchaseProduct(productId: AppConfig.Continue6ProductId)
    }
    
    func purchaseContinue15() {
        purchaseProduct(productId: AppConfig.Continue15ProductId)
    }
    
    func purchaseContinue35() {
        purchaseProduct(productId: AppConfig.Continue35ProductId)
    }
    
    // MARK:
    
    // New Code Start
    func loadBannerAd() {
        if bannerView == nil {
            guard let rootViewController = window?.rootViewController else {
                return
            }
            bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait) // kGADAdSizeFluid
            bannerView!.adUnitID = AppConfig.AdmobBannerUnitId
            bannerView!.rootViewController = rootViewController
            bannerView!.frame = CGRect(x: 0, y: rootViewController.view.frame.height,
                                       width: bannerView!.frame.width, height: bannerView!.frame.height)
            bannerView!.delegate = self
            rootViewController.view.addSubview(bannerView!)
        }
        let request = GADRequest()
        if AppConfig.DebugMode {
            request.testDevices = ["73013bb59e0a477a33c5bb6f987eeba3"];
        }
        bannerView!.load(request)
    }
    
    // New Code End
	
	func showBannerAd() {
        guard let rootViewController = window?.rootViewController else {
            return
        }
        
        guard bannerView != nil else {
            return
        }
        
        bannerView!.layer.removeAllAnimations()
		
        UIView.animate(withDuration: 0.3) {
            [weak self] in
			
            guard let bannerView = self?.bannerView else {
                return
            }
            bannerView.frame = CGRect(x: 0,
                    y: rootViewController.view.frame.height - bannerView.frame.height,
                    width: bannerView.frame.width, height: bannerView.frame.height)
            bannerView.superview?.bringSubview(toFront: bannerView)
        }
    }
	
    func hideBannerAd() {
        guard let rootViewController = window?.rootViewController else {
            return
        }
		
        guard bannerView != nil else {
            return
        }
		
        bannerView!.layer.removeAllAnimations()
		
        UIView.animate(withDuration: 0.3, animations: {
            [weak self] in
			
            guard let bannerView = self?.bannerView else {
                return
            }
			
            bannerView.frame = CGRect(x: 0, y: rootViewController.view.frame.height,
                      width: bannerView.frame.width, height: bannerView.frame.height)
        })
        {
            [weak self] (finished) in
			
			//self?.bannerView?.removeFromSuperview()
            //self?.bannerView = nil
            self?.loadBannerAd()
        }
    }
    
    func isRewardedVideoAvailable() -> Bool {
        // New Code Start
        if (AppConfig.AdvertPlatform & AppConfig.AdvertPlatformAdmob == AppConfig.AdvertPlatformAdmob) && GADRewardBasedVideoAd.sharedInstance().isReady {
            return true
        }
        else if (AppConfig.AdvertPlatform & AppConfig.AdvertPlatformChartboost == AppConfig.AdvertPlatformChartboost) && Chartboost.hasRewardedVideo(CBLocationGameOver) {
            return true
        }
        // New Code End

        return false
    }
    
    func loadRewardedVideoAd() {
        // New Code Start
        if AppConfig.AdvertPlatform & AppConfig.AdvertPlatformAdmob == AppConfig.AdvertPlatformAdmob {
            GADRewardBasedVideoAd.sharedInstance()
                    .load(GADRequest(), withAdUnitID: AppConfig.AdmobRewardedVideoUnitId)
        }
        
        if AppConfig.AdvertPlatform & AppConfig.AdvertPlatformChartboost == AppConfig.AdvertPlatformChartboost {
            Chartboost.cacheRewardedVideo(CBLocationGameOver)
        }
        // New Code End
    }
    
    func showRewardedVideoAd() {
        guard let rootViewController = window?.rootViewController else {
            return
        }
        
        // New Code Start
        if (AppConfig.AdvertPlatform & AppConfig.AdvertPlatformAdmob == AppConfig.AdvertPlatformAdmob) && GADRewardBasedVideoAd.sharedInstance().isReady {
            GADRewardBasedVideoAd.sharedInstance()
                .present(fromRootViewController: rootViewController)
        }
        else if (AppConfig.AdvertPlatform & AppConfig.AdvertPlatformChartboost == AppConfig.AdvertPlatformChartboost) && Chartboost.hasRewardedVideo(CBLocationGameOver) {
            Chartboost.showRewardedVideo(CBLocationGameOver)
        }
        // New Code End
    }
    
    // MARK: Interstitial
    
    // New Code Start
    func isInterstitialAvailable() -> Bool {
        if (AppConfig.AdvertPlatform & AppConfig.AdvertPlatformAdmob == AppConfig.AdvertPlatformAdmob) && (interstitial?.isReady == true) {
            return true
        }
        else if (AppConfig.AdvertPlatform & AppConfig.AdvertPlatformChartboost == AppConfig.AdvertPlatformChartboost) && Chartboost.hasInterstitial(CBLocationGameOver) {
            return true
        }
        return false
    }
    
    func loadInterstitial() {
        if AppConfig.AdvertPlatform & AppConfig.AdvertPlatformAdmob == AppConfig.AdvertPlatformAdmob {
            loadAdmobInterstitial()
        }
        
        if AppConfig.AdvertPlatform & AppConfig.AdvertPlatformChartboost == AppConfig.AdvertPlatformChartboost {
            Chartboost.cacheInterstitial(CBLocationGameOver)
        }
    }
    
    func showInterstitial() {
        guard let rootViewController = window?.rootViewController else {
            return
        }
        
        if (AppConfig.AdvertPlatform & AppConfig.AdvertPlatformAdmob == AppConfig.AdvertPlatformAdmob) &&  (interstitial?.isReady == true) {
            interstitial?.present(fromRootViewController: rootViewController)
        }
        else if (AppConfig.AdvertPlatform & AppConfig.AdvertPlatformChartboost == AppConfig.AdvertPlatformChartboost) && Chartboost.hasInterstitial(CBLocationGameOver) {
            Chartboost.showInterstitial(CBLocationGameOver)
        }
    }
    // New Code End

    // MARK:
    
    private func initializeGameCenter() {
        guard let rootViewController = window?.rootViewController else {
            return
        }
		
        GKLocalPlayer.localPlayer().authenticateHandler = {
            (viewController, error) in
			
			let localPlayer = GKLocalPlayer.localPlayer()
			
			if localPlayer.isAuthenticated {
				let leaderboard = GKLeaderboard(players: [localPlayer])
				leaderboard.identifier = AppConfig.LeaderboardId
				leaderboard.timeScope = .allTime
				leaderboard.loadScores(completionHandler: {
					(scores, error) in
					
					let bestScore = scores?.first?.value
					
					if bestScore != nil {
						DataHelper.setBestScore(bestScore: Int(bestScore!))
					}
					else {
						DataHelper.setBestScore(bestScore: 0)
					}
					
					NotificationCenter.default
							.post(name: Notification.Name(AppConfig.BestScoreFetchedNotification),
							      object: nil)
				})
			}
            
            if viewController != nil {
                rootViewController.present(viewController!, animated: true, completion: nil)
            }
            
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    private func initializeStoreKit() {
        SwiftyStoreKit.completeTransactions(atomically: true) {
            purchases in
            
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    
                    print("Purchased: \(purchase)")
                    
                default:
                    break
                }
            }
        }
		
		fetchProductPrices()
    }
    
    private func initializeAdmob() {
        GADMobileAds.configure(withApplicationID: AppConfig.AdmobAppId)
        // New Code Start
        if (AppConfig.AdvertPlatform & AppConfig.AdvertPlatformAdmob == AppConfig.AdvertPlatformAdmob) {
            
            GADRewardBasedVideoAd.sharedInstance().delegate = self
            GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                withAdUnitID: AppConfig.AdmobRewardedVideoUnitId)
            
            loadAdmobInterstitial()
            loadBannerAd()
        }
        // New Code End
    }
    
    private func initializeChartboost() {
        // New Code Start
        if AppConfig.AdvertPlatform & AppConfig.AdvertPlatformChartboost == AppConfig.AdvertPlatformChartboost {
            Chartboost.start(withAppId: AppConfig.ChartboostAppId,
                             appSignature: AppConfig.ChartboostAppSignature, delegate: self)
        }
        // New Code End
    }
    
    // MARK:
    
    private func purchaseProduct(productId: String) {
        SwiftyStoreKit.retrieveProductsInfo([productId]) {
            [weak self] result in

            if let product = result.retrievedProducts.first {
                SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) {
                    [weak self] result in

                    switch result {
                    case .success(let purchase):
                        self?.didPurchaseProduct(productId: purchase.productId)

                    case .error(let error):
                        self?.didFailPurchase(error: error)
                    }
                }
            }
        }
    }
    
    private func didPurchaseProduct(productId: String) {
		print("Purchase successful with product id: \(productId)")

        switch productId {
        case AppConfig.Continue2ProductId:
            let continueCount = DataHelper.getContinueCount()
            DataHelper.setContinueCount(continueCount: continueCount + 2)
            
        case AppConfig.Continue6ProductId:
            let continueCount = DataHelper.getContinueCount()
            DataHelper.setContinueCount(continueCount: continueCount + 6)
            
        case AppConfig.Continue15ProductId:
            let continueCount = DataHelper.getContinueCount()
            DataHelper.setContinueCount(continueCount: continueCount + 15)
            
        case AppConfig.Continue35ProductId:
            let continueCount = DataHelper.getContinueCount()
            DataHelper.setContinueCount(continueCount: continueCount + 35)
        
        default:
            break
        }
        
        NotificationCenter.default
                .post(name: Notification.Name(AppConfig.PurchaseSuccessNotification), object: nil)
    }
    
    private func didFailPurchase(error: SKError) {
		print("Purchase failed with error: \(error.localizedDescription)")

		if error.code != .paymentCancelled {
			guard let rootViewController = window?.rootViewController else {
				return
			}
			
			let alertController = UIAlertController(title: "Error!",
					message: error.localizedDescription, preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			rootViewController.present(alertController, animated: true, completion: nil)
		}
		
        NotificationCenter.default
            .post(name: Notification.Name(AppConfig.PurchaseErrorNotification), object: nil)
    }
    
    // New Code Start
    // global variables for reusable scenes
    private var mainMenuScene: MainMenuScene?
    private var loadStageScene: LoadStageScene?
    private var gamePlayScene: GamePlayScene?

    enum SceneKind {
        case mainMenu
        case loadStage
        case gamePlay
    }
    
    func getScene(kind: SceneKind, size: CGSize) -> SKScene {
        switch kind {
        case .mainMenu:
            if self.mainMenuScene == nil {
                self.mainMenuScene = MainMenuScene(size: size)
                self.mainMenuScene!.scaleMode = .aspectFill
            }
            return self.mainMenuScene!
        case .loadStage:
            if self.loadStageScene == nil {
                self.loadStageScene = LoadStageScene(size: size)
                self.loadStageScene!.scaleMode = .aspectFill
            }
            return self.loadStageScene!
        case .gamePlay:
            if self.gamePlayScene == nil {
                self.gamePlayScene = GamePlayScene(size: size)
                self.gamePlayScene!.scaleMode = .aspectFill
                //self.gamePlayScene!.scaleMode = .fill
            }
            return self.gamePlayScene!
        }
    }
    // New Code End

}
