import SpriteKit


class GameImageCache {
    static let SharedInstance = GameImageCache()
    
    private var playerAtlas: SKTextureAtlas?
    private var opponentAtlas: SKTextureAtlas?
    
    // MARK:
    
    private init() {}
    
    // MARK:
    
    func preloadPlayerAtlas() {
        // New Code Start
        // will NOT preload sprites
        if playerAtlas == nil {
            playerAtlas = SKTextureAtlas(named: "player")
        }
        didLoadPlayer()
        //        if playerAtlas == nil {
        //            playerAtlas = SKTextureAtlas(named: "player")
        //        }
        //
        //        playerAtlas!.preload(completionHandler: {
        //            [weak self] in
        //
        //            self?.didLoadPlayer()
        //        })
        // New Code End
    }
    
    func preloadOpponentAtlas(forStage stage: Int) {
        opponentAtlas = nil
        opponentAtlas = SKTextureAtlas(named: "opponent_\(stage)")
        // New Code Start
        // will NOT preload sprites
        //opponentAtlas!.preload(completionHandler: {
            didLoadOpponent()
        //})
        // New Code End
    }
    
    func clearOpponentAtlas() {
        opponentAtlas = nil
    }
    
    func getPlayerTexture(textureName: String) -> SKTexture? {
        return playerAtlas?.textureNamed(textureName)
    }
    
    func getOpponentTexture(textureName: String) -> SKTexture? {
        var texture = opponentAtlas?.textureNamed(textureName)
        
      // New Code Start
       /*if #available(iOS 9.0, *) {
            if textureName == "ring.png" || textureName == "ring2.png", let txt = texture {
                let ref = txt.cgImage()
                let image = UIImage(cgImage: ref).resized(targetSize: CGSize(width: txt.size().width * 2, height: txt.size().height * 2))
                texture = SKTexture(image: image)
            }
        }*/
       
        return texture
    }
    
    // MARK:
    
    private func didLoadPlayer() {
        NotificationCenter.default
            .post(name: Notification.Name(AppConfig.PlayerLoadedNotification), object: nil)
    }
    
    private func didLoadOpponent() {
        NotificationCenter.default
            .post(name: Notification.Name(AppConfig.OpponentLoadedNotification), object: nil)
    }
}
