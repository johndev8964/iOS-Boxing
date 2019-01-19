import SpriteKit
import GLKit


// MARK: -

class PlayerNode: BKSpriteNode, Updatable, PlayerStateDelegate {
    weak var delegate: PlayerNodeDelegate?
    
    private let baseFramePerSecond: Float = 10
    private(set) var health = 100 {
        didSet {
            guard oldValue != health else {
                return
            }
            
            if health <= 0 {
                health = 0
            }
            
            updateShader()
        }
    }
    private(set) var energy = 0 {
        didSet {
            guard oldValue != energy else {
                return
            }
            
            if energy <= 0 {
                energy = 0
            }
                
            updateShader()
        }
    }
    private let maxEnergy: Int
    private var recoveryTime: TimeInterval = 0
    private var stateMachine: EHStateMachine!
    
    // MARK:
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(maxEnergy: Int) {        
        guard let texture = GameImageCache.SharedInstance
            .getPlayerTexture(textureName: "idle_0.png") else {
            fatalError("Player texture not loaded.")
        }

        if maxEnergy <= 0 {
    		fatalError("Max energy cannot be negative")
		}

		self.maxEnergy = maxEnergy
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        stateMachine = EHStateMachine(states: [
                IdlePlayerState(delegate: self),
                PunchTopLeftPlayerState(delegate: self),
                PunchTopRightPlayerState(delegate: self),
                PunchBottomLeftPlayerState(delegate: self),
                PunchBottomRightPlayerState(delegate: self),
                
                // New Code Start
                PunchS1PlayerState(delegate: self),
                PunchS2PlayerState(delegate: self),
                PunchS3PlayerState(delegate: self),
                PunchS4PlayerState(delegate: self),
                PunchS5PlayerState(delegate: self),
                HookS1PlayerState(delegate: self),
                HookS2PlayerState(delegate: self),
                HookS3PlayerState(delegate: self),
                HookS4PlayerState(delegate: self),
                HookS5PlayerState(delegate: self),
                // New Code End
            
                HookTopLeftPlayerState(delegate: self),
                HookTopRightPlayerState(delegate: self),
                HookBottomLeftPlayerState(delegate: self),
                HookBottomRightPlayerState(delegate: self),
                GetPunchTopLeftPlayerState(delegate: self),
                GetPunchTopLeftBlockedPlayerState(delegate: self),
                GetPunchTopRightPlayerState(delegate: self),
                GetPunchTopRightBlockedPlayerState(delegate: self),
                GetPunchBottomLeftPlayerState(delegate: self),
                GetPunchBottomLeftBlockedPlayerState(delegate: self),
                GetPunchBottomRightPlayerState(delegate: self),
                GetPunchBottomRightBlockedPlayerState(delegate: self),

                // New Code Start
                GetPunchS1PlayerState(delegate: self),
                GetPunchS2PlayerState(delegate: self),
                GetPunchS3PlayerState(delegate: self),
                GetPunchS4PlayerState(delegate: self),
                GetPunchS5PlayerState(delegate: self),
                GetPunchS1BlockedPlayerState(delegate: self),
                GetPunchS2BlockedPlayerState(delegate: self),
                GetPunchS3BlockedPlayerState(delegate: self),
                GetPunchS4BlockedPlayerState(delegate: self),
                GetPunchS5BlockedPlayerState(delegate: self),
                GetHookS1PlayerState(delegate: self),
                GetHookS2PlayerState(delegate: self),
                GetHookS3PlayerState(delegate: self),
                GetHookS4PlayerState(delegate: self),
                GetHookS5PlayerState(delegate: self),
                GetHookS1BlockedPlayerState(delegate: self),
                GetHookS2BlockedPlayerState(delegate: self),
                GetHookS3BlockedPlayerState(delegate: self),
                GetHookS4BlockedPlayerState(delegate: self),
                GetHookS5BlockedPlayerState(delegate: self),
                // New Code End
            
                GetHookTopLeftPlayerState(delegate: self),
                GetHookTopRightPlayerState(delegate: self),
                GetHookBottomLeftPlayerState(delegate: self),
                GetHookBottomRightPlayerState(delegate: self),
                GetHookTopLeftBlockedPlayerState(delegate: self),
                GetHookTopRightBlockedPlayerState(delegate: self),
                GetHookBottomLeftBlockedPlayerState(delegate: self),
                GetHookBottomRightBlockedPlayerState(delegate: self),
                BlockPlayerState(delegate: self),
                DodgeLeftPlayerState(delegate: self),
                DodgeRightPlayerState(delegate: self),
                DodgeLongLeftPlayerState(delegate: self),
                DodgeLongRightPlayerState(delegate: self),
                TiredPlayerState(delegate: self),
                CelebratePlayerState(delegate: self),
                KnockOutPlayerState(delegate: self)
            ])
        
        _ = stateMachine.enter(IdlePlayerState.self)

        energy = maxEnergy
    }
    
    // MARK:
    
    func update(deltaTime seconds: TimeInterval) {
        if energy < maxEnergy {
            if !(stateMachine.currentState is AttackPlayerState) {
                recoveryTime += seconds
            }
            
            if recoveryTime >= PlayerConfig.EnergyRecoveryTime {
                recoveryTime = 0
                energy += 1
                
                delegate?.playerNodeDidRecoverEnergy(self)
            }
        }
        
        stateMachine.update(deltaTime: seconds)
    }
    
    // MARK:
    
    func playerStateFrameInterval(_ state: PlayerState) -> TimeInterval {
		switch state {
		case is IdlePlayerState:
			return 1 / TimeInterval(PlayerConfig.IdleFramePerSecond)
			
		case is TiredPlayerState:
			return 1 / TimeInterval(PlayerConfig.TiredFramePerSecond)
			
		case is DodgePlayerState:
			return 1 / TimeInterval(PlayerConfig.DodgeFramePerSecond)
        
        // New Code Start
        case is DodgeLongPlayerState:
            return 1 / TimeInterval(PlayerConfig.DodgeLongFramePerSecond)
        // New Code End

		case is BlockPlayerState:
			return 1 / TimeInterval(PlayerConfig.BlockFramePerSecond)
			
		default:
			return 1 / TimeInterval(baseFramePerSecond)
		}
    }
    
    func playerState(_ state: PlayerState, didUpdateFrameTo currentFrame: String) {
        texture = GameImageCache.SharedInstance.getPlayerTexture(textureName: currentFrame)
        
        if state is AttackPlayerState {
            let attackState = state as! AttackPlayerState
            
            if currentFrame == attackState.contactFrame {
                switch attackState {
                case is PunchTopLeftPlayerState:
                    delegate?.playerNodeDidContactWithPunchTopLeft(self)
                    
                case is PunchTopRightPlayerState:
                    delegate?.playerNodeDidContactWithPunchTopRight(self)
                    
                case is PunchBottomLeftPlayerState:
                    delegate?.playerNodeDidContactWithPunchBottomLeft(self)
                    
                case is PunchBottomRightPlayerState:
                    delegate?.playerNodeDidContactWithPunchBottomRight(self)
                    
                case is HookTopLeftPlayerState:
                    delegate?.playerNodeDidContactWithHookTopLeft(self)
                    
                case is HookTopRightPlayerState:
                    delegate?.playerNodeDidContactWithHookTopRight(self)
                    
                case is HookBottomLeftPlayerState:
                    delegate?.playerNodeDidContactWithHookBottomLeft(self)
                    
                case is HookBottomRightPlayerState:
                    delegate?.playerNodeDidContactWithHookBottomRight(self)
                
                // New Code Start
                case is PunchS1PlayerState:
                    delegate?.playerNodeDidContactWithPunchS1(self)
                case is PunchS2PlayerState:
                    delegate?.playerNodeDidContactWithPunchS2(self)
                case is PunchS3PlayerState:
                    delegate?.playerNodeDidContactWithPunchS3(self)
                case is PunchS4PlayerState:
                    delegate?.playerNodeDidContactWithPunchS4(self)
                case is PunchS5PlayerState:
                    delegate?.playerNodeDidContactWithPunchS5(self)

                case is HookS1PlayerState:
                    delegate?.playerNodeDidContactWithHookS1(self)
                case is HookS2PlayerState:
                    delegate?.playerNodeDidContactWithHookS2(self)
                case is HookS3PlayerState:
                    delegate?.playerNodeDidContactWithHookS3(self)
                case is HookS4PlayerState:
                    delegate?.playerNodeDidContactWithHookS4(self)
                case is HookS5PlayerState:
                    delegate?.playerNodeDidContactWithHookS5(self)

               // New Code End
                    
                default:
                    break
                }
            }
        }
        
        if state is TiredPlayerState {
            if energy > 0 {
                _ = stateMachine.enter(IdlePlayerState.self)
            }
        }
    }
    
    func playerStateDidShowAllFrames(_ state: PlayerState) {
        switch state {
        case is AttackPlayerState, is DodgePlayerState, is DodgeLongPlayerState, is GetAttackPlayerState:
            if energy > 0 {
                _ = stateMachine.enter(IdlePlayerState.self)
            }
            else {
                _ = stateMachine.enter(TiredPlayerState.self)
            }
        
        case is KnockOutPlayerState:
            delegate?.playerNodeDidFinishKnockOut(self)
            
        case is CelebratePlayerState:
            delegate?.playerNodeDidFinishCelebration(self)
            
        default:
            break
        }
    }
    
    // MARK:
    
    func punchTopLeft() -> Bool {
        return energy > 0 && stateMachine.enter(PunchTopLeftPlayerState.self)
    }
    
    func punchTopRight() -> Bool {
        return energy > 0 && stateMachine.enter(PunchTopRightPlayerState.self)
    }
    
    func punchBottomLeft() -> Bool {
        return energy > 0 && stateMachine.enter(PunchBottomLeftPlayerState.self)
    }
    
    func punchBottomRight() -> Bool {
        return energy > 0 && stateMachine.enter(PunchBottomRightPlayerState.self)
    }
    
    func hookTopLeft() -> Bool {
        return energy > 0 && stateMachine.enter(HookTopLeftPlayerState.self)
    }
    
    func hookTopRight() -> Bool {
        return energy > 0 && stateMachine.enter(HookTopRightPlayerState.self)
    }
    
    func hookBottomLeft() -> Bool {
        return energy > 0 && stateMachine.enter(HookBottomLeftPlayerState.self)
    }
    
    func hookBottomRight() -> Bool {
        return energy > 0 && stateMachine.enter(HookBottomRightPlayerState.self)
    }
    
    // New Code Start
    
    func punchS1() -> Bool {
        return energy > 0 && stateMachine.enter(PunchS1PlayerState.self)
    }
    
    func punchS2() -> Bool {
        return energy > 0 && stateMachine.enter(PunchS2PlayerState.self)
    }
    
    func punchS3() -> Bool {
        return energy > 0 && stateMachine.enter(PunchS3PlayerState.self)
    }
    
    func punchS4() -> Bool {
        return energy > 0 && stateMachine.enter(PunchS4PlayerState.self)
    }
    
    func punchS5() -> Bool {
        return energy > 0 && stateMachine.enter(PunchS5PlayerState.self)
    }
    
    func hookS1() -> Bool {
        return energy > 0 && stateMachine.enter(HookS1PlayerState.self)
    }
    
    func hookS2() -> Bool {
        return energy > 0 && stateMachine.enter(HookS2PlayerState.self)
    }
    
    func hookS3() -> Bool {
        return energy > 0 && stateMachine.enter(HookS3PlayerState.self)
    }
    
    func hookS4() -> Bool {
        return energy > 0 && stateMachine.enter(HookS4PlayerState.self)
    }
    
    func hookS5() -> Bool {
        return energy > 0 && stateMachine.enter(HookS5PlayerState.self)
    }

    // New Code End
    
    func dodgeLeft(long: Bool) -> Bool {
        return long ? (energy > 0 && stateMachine.enter(DodgeLongLeftPlayerState.self)) : (energy > 0 && stateMachine.enter(DodgeLeftPlayerState.self))
    }
    
    func dodgeRight(long: Bool) -> Bool {
        return long ? (energy > 0 && stateMachine.enter(DodgeLongRightPlayerState.self)) : (energy > 0 && stateMachine.enter(DodgeRightPlayerState.self))
    }
    
    func block() -> Bool {
        return energy > 0 && stateMachine.enter(BlockPlayerState.self)
    }
    
    func releaseBlock() -> Bool {
        return stateMachine.currentState is BlockPlayerState
            && stateMachine.enter(IdlePlayerState.self)
    }
    
    func celebrate() -> Bool {
        return stateMachine.enter(CelebratePlayerState.self)
    }
    
    // MARK:
    
    func getPunchTopLeft(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetPunchTopLeftBlockedPlayerState.self, damage: 0)
        } else {
            getAttack(type: GetPunchTopLeftPlayerState.self, damage: damage)
        }
    }
    
    func getPunchTopRight(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetPunchTopRightBlockedPlayerState.self, damage: 0)
        } else {
            getAttack(type: GetPunchTopRightPlayerState.self, damage: damage)
        }
    }
    
    func getPunchBottomLeft(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetPunchBottomLeftBlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetPunchBottomLeftPlayerState.self, damage: damage)
        }
    }
    
    func getPunchBottomRight(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetPunchBottomRightBlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetPunchBottomRightPlayerState.self, damage: damage)
        }
    }
    
    func getHookTopLeft(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetHookTopLeftBlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetHookTopLeftPlayerState.self, damage: damage)
        }
    }
    
    func getHookTopRight(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetHookTopRightBlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetHookTopRightPlayerState.self, damage: damage)
        }
    }
    
    func getHookBottomLeft(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetHookBottomLeftBlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetHookBottomLeftPlayerState.self, damage: damage)
        }
    }
    
    func getHookBottomRight(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetHookBottomRightBlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetHookBottomRightPlayerState.self, damage: damage)
        }
    }
    
    // New Code Start
    func getPunchS1(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetPunchS1BlockedPlayerState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS1PlayerState.self, damage: damage)
        }
    }
    
    func getPunchS2(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetPunchS2BlockedPlayerState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS2PlayerState.self, damage: damage)
        }
    }
    
    func getPunchS3(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetPunchS3BlockedPlayerState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS3PlayerState.self, damage: damage)
        }
    }
    
    func getPunchS4(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetPunchS4BlockedPlayerState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS4PlayerState.self, damage: damage)
        }
    }
    
    func getPunchS5(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetPunchS5BlockedPlayerState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS5PlayerState.self, damage: damage)
        }
    }
    
    func getHookS1(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetHookS1BlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetHookS1PlayerState.self, damage: damage)
        }
    }
    
    func getHookS2(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetHookS2BlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetHookS2PlayerState.self, damage: damage)
        }
    }
    
    func getHookS3(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetHookS3BlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetHookS3PlayerState.self, damage: damage)
        }
    }
    
    func getHookS4(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetHookS4BlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetHookS4PlayerState.self, damage: damage)
        }
    }
    
    func getHookS5(damage: Int) {
        if stateMachine.currentState is BlockPlayerState {
            getAttack(type: GetHookS5BlockedPlayerState.self, damage: damage)
        } else {
            getAttack(type: GetHookS5PlayerState.self, damage: damage)
        }
    }
    
    func getEnergyValue() -> Int {
        return energy
    }
    
    // New Code End

    func consumeEnergy() {
        energy -= 1
    }
    
    // MARK:
    
    private func getAttack(type getAttackClass: GetAttackPlayerState.Type, damage: Int) {
    	var adjustedDamage = damage
		
    	if stateMachine.currentState is TiredPlayerState {
    		adjustedDamage = adjustedDamage * 2
		}
        
//        if getAttackClass is GetPunchPlayerState.Type {
//            adjustedDamage = adjustedDamage / 2
//        }
		
        // New Code Start
        let currentStateIsBlock = stateMachine.currentState is BlockPlayerState
        // New Code End
        if (currentStateIsBlock) && (!stateMachine.canEnterState(getAttackClass)) {
            delegate?.playerNodeDidBlock(self)
            
            // New Code Start
            shader = ShaderManager.SharedInstance.playerBlockShader
            let waitAction = SKAction.wait(forDuration: 0.6)
            run(waitAction) { [weak self] in
                self?.updateShader()
            }
            processMotion(type: getAttackClass, blocked: true)
            // New Code End
        }
        else if health - adjustedDamage > 0 && stateMachine.enter(getAttackClass) {
            health -= adjustedDamage
			
            if currentStateIsBlock && (adjustedDamage <= 0) {
                shader = ShaderManager.SharedInstance.playerBlockShader
            } else if (damage >= 15) {
            	shader = ShaderManager.SharedInstance.playerHeavyHitShader
            }
            else {
				shader = ShaderManager.SharedInstance.playerLightHitShader
			}
			
            let waitAction = SKAction.wait(forDuration: 0.6)
            run(waitAction) {
				[weak self] in
				
				self?.updateShader()
                // New Code Start
                if currentStateIsBlock && AppConfig.holdBlock {
                    _ = self?.block()
                }
                // New Code End
			}
            
            delegate?.playerNodeDidGetAttack(self, hook: getAttackClass is GetHookPlayerState.Type, blocked: currentStateIsBlock && (adjustedDamage <= 0))
            // New Code Start
            processMotion(type: getAttackClass, blocked: adjustedDamage <= 0)
            // New Code End
        }
        else if health - adjustedDamage <= 0 && stateMachine.enter(KnockOutPlayerState.self) {
            health -= adjustedDamage
            
            delegate?.playerNodeDidKnockOut(self)
        } else {
            // New Code Start
            if !(stateMachine.currentState is DodgePlayerState) && !(stateMachine.currentState is DodgeLongPlayerState) {
                delegate?.playerNodeDidBlock(self)
                shader = ShaderManager.SharedInstance.playerBlockShader
                let waitAction = SKAction.wait(forDuration: 0.6)
                run(waitAction) { [weak self] in
                    self?.updateShader()
                }
                processMotion(type: getAttackClass, blocked: true)
            }
            // New Code End
       }
    }
    
    // New Code Start
    private func processMotion(type getAttackClass: GetAttackPlayerState.Type, blocked: Bool) {
        let duration = 0.05
        let coef: CGFloat = blocked ? 0.2 : 2.2

        let hookTopX: CGFloat = 10 * coef
        let hookTopY: CGFloat = 5 * coef
        let hookBottomX: CGFloat = 10 * coef
        let hookBottomY: CGFloat = 5 * coef
        let punchTopX: CGFloat = 0 * coef
        let punchTopY: CGFloat = 5 * coef
        let punchBottomX: CGFloat = 10 * coef
        let punchBottomY: CGFloat = 5 * coef
        
        let dx: CGFloat
        let dy: CGFloat
        switch getAttackClass {
        case is GetPunchTopLeftPlayerState.Type, is GetPunchTopLeftBlockedPlayerState.Type:
            dx = -1 * punchTopX
            dy = -1 * punchTopY
        case is GetPunchTopRightPlayerState.Type, is GetPunchTopRightBlockedPlayerState.Type:
            dx = punchTopX
            dy = -1 * punchTopY
        case is GetPunchBottomLeftPlayerState.Type, is GetPunchBottomLeftBlockedPlayerState.Type:
            dx = -1 * punchBottomX
            dy = -1 * punchBottomY
        case is GetPunchBottomRightPlayerState.Type, is GetPunchBottomRightBlockedPlayerState.Type:
            dx = punchBottomX
            dy = -1 * punchBottomY
        case is GetHookTopLeftPlayerState.Type, is GetHookTopLeftBlockedPlayerState.Type:
            dx = -1 * hookTopX
            dy = -1 * hookTopY
        case is GetHookTopRightPlayerState.Type, is GetHookTopRightBlockedPlayerState.Type:
            dx = hookTopX
            dy = -1 * hookTopY
        case is GetHookBottomLeftPlayerState.Type, is GetHookBottomLeftBlockedPlayerState.Type:
            dx = -1 * hookBottomX
            dy = -1 * hookBottomY
        case is GetHookBottomRightPlayerState.Type, is GetHookBottomRightBlockedPlayerState.Type:
            dx = hookBottomX
            dy = -1 * hookBottomY
            
        case is GetPunchS1PlayerState.Type, is GetPunchS1BlockedPlayerState.Type:
            dx = -1 * punchTopX
            dy = -1 * punchTopY
        case is GetPunchS2PlayerState.Type, is GetPunchS2BlockedPlayerState.Type:
            dx = -1 * punchTopX
            dy = -1 * punchTopY
        case is GetPunchS3PlayerState.Type, is GetPunchS3BlockedPlayerState.Type:
            dx = -1 * punchTopX
            dy = -1 * punchTopY
        case is GetPunchS4PlayerState.Type, is GetPunchS4BlockedPlayerState.Type:
            dx = -1 * punchTopX
            dy = -1 * punchTopY
        case is GetPunchS5PlayerState.Type, is GetPunchS5BlockedPlayerState.Type:
            dx = -1 * punchTopX
            dy = -1 * punchTopY
        case is GetHookS1PlayerState.Type, is GetHookS1BlockedPlayerState.Type:
            dx = hookBottomX
            dy = -1 * hookBottomY
        case is GetHookS2PlayerState.Type, is GetHookS2BlockedPlayerState.Type:
            dx = hookBottomX
            dy = -1 * hookBottomY
        case is GetHookS3PlayerState.Type, is GetHookS3BlockedPlayerState.Type:
            dx = hookBottomX
            dy = -1 * hookBottomY
        case is GetHookS4PlayerState.Type, is GetHookS4BlockedPlayerState.Type:
            dx = hookBottomX
            dy = -1 * hookBottomY
        case is GetHookS5PlayerState.Type, is GetHookS5BlockedPlayerState.Type:
            dx = hookBottomX
            dy = -1 * hookBottomY

        default:
            dx = 0
            dy = 0
        }
        let vector = CGVector(dx: dx, dy: dy)
        let vectorBack = CGVector(dx: -1 * dx, dy: -1 * dy)
        let action = SKAction.sequence([SKAction.move(by: vector, duration: duration),
                                        SKAction.move(by: vectorBack, duration: duration)])
        run(action)
    }
    // New Code End

    private func updateShader() {
        if health <= 0 {
            shader = nil
        }
        else if health < 20 {
            shader = ShaderManager.SharedInstance.playerWeakShader
        }
        else if energy <= 0 {
            shader = ShaderManager.SharedInstance.playerTiredShader
        }
        else {
            shader = nil
        }
    }
}
