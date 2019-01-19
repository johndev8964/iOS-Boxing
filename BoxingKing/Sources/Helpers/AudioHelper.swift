import AVFoundation


final class AudioHelper {
    static let SharedInstance = AudioHelper()
    
    private var effectsVolume: Float = 1
    private var musicsVolume: Float = 1
    private var effectPlayers = [AVAudioPlayer]()
    private var musicPlayers = [AVAudioPlayer]()
    
    // MARK:
    
    private init() {}
    
    // MARK:
    
    func setEffectsVolume(volume: Float) {
        effectsVolume = volume
        
        for player in effectPlayers {
            player.volume = effectsVolume
        }
    }
    
    func setMusicsVolume(volume: Float) {
        musicsVolume = volume
        
        for player in musicPlayers {
            player.volume = musicsVolume
        }
    }
    
    // MARK:
	
    func playIntroEffect() {
        playEffect(resource: "intro", withExtension: "mp3")
    }
	
    func playClickEffect() {
        playEffect(resource: "click", withExtension: "mp3")
    }
    
    func playBellEffect() {
        playEffect(resource: "bell", withExtension: "mp3")
    }
    
    func playPlayerAttackEffect() {
        playEffect(resource: "player_attack", withExtension: "mp3")
    }
	
    func playPlayerTiredEffect() {
        playEffect(resource: "player_tired", withExtension: "mp3")
    }
    
    func playPlayerDodgeEffect() {
        playEffect(resource: "player_dodge", withExtension: "mp3")
    }
    
    func playPlayerBlockEffect() {
        playEffect(resource: "player_block", withExtension: "mp3")
    }
    
    func playPlayerHitEffect() {
        playEffect(resource: "player_hit", withExtension: "mp3")
    }
    
    func playPlayerKnockOutEffect() {
        playEffect(resource: "player_knock_out", withExtension: "mp3")
    }
    
    func playOpponentAttackEffect() {
        playEffect(resource: "opponent_attack", withExtension: "mp3")
    }
    
    func playOpponentBlockEffect() {
        playEffect(resource: "opponent_block", withExtension: "mp3")
    }
    
    func playOpponentHitEffect() {
        playEffect(resource: "opponent_hit", withExtension: "mp3")
    }
    
    func playOpponentKnockOutEffect() {
        playEffect(resource: "opponent_knock_out", withExtension: "mp3")
    }
	
    func playHitFloorEffect() {
        playEffect(resource: "hit_floor", withExtension: "mp3")
    }
	
    func playCrowdExcitedEffect() {
        playEffect(resource: "crowd_excited", withExtension: "mp3")
    }
    
    func playCalculateEndEffect() {
        playEffect(resource: "calculate_end", withExtension: "mp3")
    }
    
    func playCrowdNormalEffect() {
        playEffect(resource: "crowd_normal", withExtension: "mp3", loop: true)
    }
    
    func stopCrowdNormalEffect() {
        stopEffect(resource: "crowd_normal", withExtension: "mp3")
    }
    
    func playCrowdWinEffect() {
        playEffect(resource: "crowd_win", withExtension: "mp3", loop: true)
    }
    
    func stopCrowdWinEffect() {
        stopEffect(resource: "crowd_win", withExtension: "mp3")
    }
    
    func playCrowdLoseEffect() {
        playEffect(resource: "crowd_lose", withExtension: "mp3", loop: false)
    }
    
    func stopCrowdLoseEffect() {
        stopEffect(resource: "crowd_lose", withExtension: "mp3")
    }
    
    func playCalculateEffect() {
        playEffect(resource: "calculate", withExtension: "mp3", loop: true)
    }
    
    func stopCalculateEffect() {
        stopEffect(resource: "calculate", withExtension: "mp3")
    }
    
    // MARK:
    
    func playMainMenuMusic() {
        playMusic(resource: "bg_main", withExtension: "mp3")
    }
    
    func stopMainMenuMusic() {
        stopMusic(resource: "bg_main", withExtension: "mp3")
    }
    
    func playLoadStageMusic() {
        playMusic(resource: "bg_select", withExtension: "mp3")
    }
    
    func stopLoadStageMusic() {
        stopMusic(resource: "bg_select", withExtension: "mp3")
    }
    
    func playFinalMusic() {
        playMusic(resource: "bg_final", withExtension: "mp3")
    }
    
    func stopFinalMusic() {
        stopMusic(resource: "bg_final", withExtension: "mp3")
    }
    
    func playChampionMusic() {
        playMusic(resource: "bg_champion", withExtension: "mp3")
    }
    
    func stopChampionMusic() {
        stopMusic(resource: "bg_champion", withExtension: "mp3")
    }
    
    func playStageMusic(stage: Int) {
        playMusic(resource: "bg_stage_\(stage)", withExtension: "mp3")
    }
    
    func stopStageMusic(stage: Int) {
        stopMusic(resource: "bg_stage_\(stage)", withExtension: "mp3")
    }
    
    // MARK:
    
    private func fetchPlayer(url: URL, from players: inout [AVAudioPlayer]) -> AVAudioPlayer? {
        let availablePlayers = players.filter {
            (player) -> Bool in
            
            return player.url == url
        }
        
        if let availablePlayer = availablePlayers.first {
            return availablePlayer
        }
        
        do {
            let newPlayer = try AVAudioPlayer(contentsOf: url)
            players.append(newPlayer)
            
            return newPlayer
        }
        catch {
            return nil
        }
    }
    
    private func playEffect(resource: String, withExtension extn: String, loop: Bool = false) {
        if let url = Bundle.main.url(forResource: resource, withExtension: extn) {
            let player = fetchPlayer(url: url, from: &effectPlayers)
            player?.currentTime = 0
            player?.volume = effectsVolume
            player?.numberOfLoops = loop ? -1 : 0
            player?.play()
        }
    }
    
    private func stopEffect(resource: String, withExtension extn: String) {
        if let url = Bundle.main.url(forResource: resource, withExtension: extn) {
            let player = fetchPlayer(url: url, from: &effectPlayers)
            player?.stop()
        }
    }
    
    private func playMusic(resource: String, withExtension extn: String) {
        if let url = Bundle.main.url(forResource: resource, withExtension: extn) {
            let player = fetchPlayer(url: url, from: &musicPlayers)
            player?.currentTime = 0
            player?.volume = musicsVolume
            player?.numberOfLoops = -1
            player?.play()
        }
    }
    
    private func stopMusic(resource: String, withExtension extn: String) {
        if let url = Bundle.main.url(forResource: resource, withExtension: extn) {
            let player = fetchPlayer(url: url, from: &musicPlayers)
            player?.stop()
        }
    }
}
