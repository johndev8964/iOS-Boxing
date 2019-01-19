import SpriteKit


// MARK: -

class OpponentNode: BKSpriteNode, Updatable, OpponentStateDelegate {
    weak var delegate: OpponentNodeDelegate?
    
    var attackSpeed: Float = 1
    private let stage: Int
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
    private var isTired = false {
        didSet {
            guard oldValue != isTired else {
                return
            }
            
            updateShader()
        }
    }
    private var canBlockTop = false
    private var canBlockBottom = false
    private var stateMachine: EHStateMachine!
    
    // MARK:
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder is not supported.")
    }
    
    required init(stage: Int) {
		self.stage = stage
		
        guard let texture = GameImageCache.SharedInstance
            .getOpponentTexture(textureName: "idle_0.png") else {
            fatalError("Opponent texture not loaded.")
        }
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        stateMachine = EHStateMachine(states: [
                Idle1OpponentState(delegate: self),
                Idle2OpponentState(delegate: self),
                Idle3OpponentState(delegate: self),
                Idle4OpponentState(delegate: self),
                Idle5OpponentState(delegate: self),
                PunchTopLeftOpponentState(delegate: self),
                PunchTopRightOpponentState(delegate: self),
                PunchBottomLeftOpponentState(delegate: self),
                PunchBottomRightOpponentState(delegate: self),
                
                PunchS1OpponentState(delegate: self),
                PunchS2OpponentState(delegate: self),
                PunchS3OpponentState(delegate: self),
                PunchS4OpponentState(delegate: self),
                PunchS5OpponentState(delegate: self),
                HookS1OpponentState(delegate: self),
                HookS2OpponentState(delegate: self),
                HookS3OpponentState(delegate: self),
                HookS4OpponentState(delegate: self),
                HookS5OpponentState(delegate: self),
                
                HookTopLeftOpponentState(delegate: self),
                HookTopRightOpponentState(delegate: self),
                HookBottomLeftOpponentState(delegate: self),
                HookBottomRightOpponentState(delegate: self),
                GetPunchTopLeftOpponentState(delegate: self),
                GetPunchTopRightOpponentState(delegate: self),
                GetPunchBottomLeftOpponentState(delegate: self),
                GetPunchBottomRightOpponentState(delegate: self),
                GetPunchTopLeftBlockedOpponentState(delegate: self),
                GetPunchTopRightBlockedOpponentState(delegate: self),
                GetPunchBottomLeftBlockedOpponentState(delegate: self),
                GetPunchBottomRightBlockedOpponentState(delegate: self),

                GetPunchS1OpponentState(delegate: self),
                GetPunchS2OpponentState(delegate: self),
                GetPunchS3OpponentState(delegate: self),
                GetPunchS4OpponentState(delegate: self),
                GetPunchS5OpponentState(delegate: self),
                GetPunchS1BlockedOpponentState(delegate: self),
                GetPunchS2BlockedOpponentState(delegate: self),
                GetPunchS3BlockedOpponentState(delegate: self),
                GetPunchS4BlockedOpponentState(delegate: self),
                GetPunchS5BlockedOpponentState(delegate: self),
                GetHookS1OpponentState(delegate: self),
                GetHookS2OpponentState(delegate: self),
                GetHookS3OpponentState(delegate: self),
                GetHookS4OpponentState(delegate: self),
                GetHookS5OpponentState(delegate: self),
                
                GetHookTopLeftOpponentState(delegate: self),
                GetHookTopRightOpponentState(delegate: self),
                GetHookBottomLeftOpponentState(delegate: self),
                GetHookBottomRightOpponentState(delegate: self),
                BlockTopLeftOpponentState(delegate: self),
                BlockTopRightOpponentState(delegate: self),
                BlockBottomOpponentState(delegate: self),
                TiredOpponentState(delegate: self),
                CelebrateOpponentState(delegate: self),
                KnockOutOpponentState(delegate: self)
            ])
        
        _ = stateMachine.enter(Idle1OpponentState.self)
    }
    
    // MARK:
    
    func update(deltaTime seconds: TimeInterval) {
        stateMachine.update(deltaTime: seconds)
    }
    
    // MARK:
    
    func opponentStateFrameInterval(_ state: OpponentState) -> TimeInterval {
        switch state {
        case is AttackOpponentState:
            return 1 / TimeInterval(baseFramePerSecond * attackSpeed)
	
		case is Idle1OpponentState, is Idle2OpponentState, is Idle3OpponentState,
             is Idle4OpponentState, is Idle5OpponentState:
			return 1 / TimeInterval(OpponentConfig.idleFramePerSecond(forStage: stage))
			
		case is TiredOpponentState:
			return 1 / TimeInterval(OpponentConfig.tiredFramePerSecond(forStage: stage))
			
		case is BlockOpponentState:
			return 1 / TimeInterval(OpponentConfig.blockFramePerSecond(forStage: stage))
			
		default:
			return 1 / TimeInterval(baseFramePerSecond)
		}
    }
    
    func opponentState(_ state: OpponentState, didUpdateFrameTo currentFrame: String) {
        texture = GameImageCache.SharedInstance.getOpponentTexture(textureName: currentFrame)
        
        if state is AttackOpponentState {
            let attackState = state as! AttackOpponentState
            
            if currentFrame == attackState.contactFrame {
                switch attackState {
                case is PunchTopLeftOpponentState:
                    delegate?.opponentNodeDidContactWithPunchTopLeft(self)
                    
                case is PunchTopRightOpponentState:
                    delegate?.opponentNodeDidContactWithPunchTopRight(self)
                    
                case is PunchBottomLeftOpponentState:
                    delegate?.opponentNodeDidContactWithPunchBottomLeft(self)
                    
                case is PunchBottomRightOpponentState:
                    delegate?.opponentNodeDidContactWithPunchBottomRight(self)
                    
                case is HookTopLeftOpponentState:
                    delegate?.opponentNodeDidContactWithHookTopLeft(self)
                    
                case is HookTopRightOpponentState:
                    delegate?.opponentNodeDidContactWithHookTopRight(self)
                    
                case is HookBottomLeftOpponentState:
                    delegate?.opponentNodeDidContactWithHookBottomLeft(self)
                    
                case is HookBottomRightOpponentState:
                    delegate?.opponentNodeDidContactWithHookBottomRight(self)
                    
                // New Code Start
                case is PunchS1OpponentState:
                    delegate?.opponentNodeDidContactWithPunchS1(self)
                    
                case is PunchS2OpponentState:
                    delegate?.opponentNodeDidContactWithPunchS2(self)
                    
                case is PunchS3OpponentState:
                    delegate?.opponentNodeDidContactWithPunchS3(self)
                    
                case is PunchS4OpponentState:
                    delegate?.opponentNodeDidContactWithPunchS4(self)
                    
                case is PunchS5OpponentState:
                    delegate?.opponentNodeDidContactWithPunchS5(self)
                    
                case is HookS1OpponentState:
                    delegate?.opponentNodeDidContactWithHookS1(self)

                case is HookS2OpponentState:
                    delegate?.opponentNodeDidContactWithHookS2(self)
                    
                case is HookS3OpponentState:
                    delegate?.opponentNodeDidContactWithHookS3(self)
                    
                case is HookS4OpponentState:
                    delegate?.opponentNodeDidContactWithHookS4(self)
                    
                case is HookS5OpponentState:
                    delegate?.opponentNodeDidContactWithHookS5(self)
                    
                // New Code End
                    
                default:
                    break
                }
            }
        }
    }
    
    func opponentStateDidShowAllFrames(_ state: OpponentState) {
        switch state {
        case is AttackOpponentState, is BlockOpponentState, is GetAttackOpponentState:
            if isTired {
                _ = stateMachine.enter(TiredOpponentState.self)
            }
            else {
                _ = stateMachine.enter(Idle1OpponentState.self)
            }
        
        case is KnockOutOpponentState:
            delegate?.opponentNodeDidFinishKnockOut(self)
            
        case is CelebrateOpponentState:
            delegate?.opponentNodeDidFinishCelebration(self)
            
        default:
            break
        }
    }
    
    // MARK:
    
    func punchTopLeft() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(PunchTopLeftOpponentState.self)
    }
    
    func punchTopRight() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(PunchTopRightOpponentState.self)
    }
    
    func punchBottomLeft() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(PunchBottomLeftOpponentState.self)
    }
    
    func punchBottomRight() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(PunchBottomRightOpponentState.self)
    }
    
    // New Code Start

    func punchS1() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(PunchS1OpponentState.self)
    }

    func punchS2() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(PunchS2OpponentState.self)
    }
    
    func punchS3() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(PunchS3OpponentState.self)
    }
    
    func punchS4() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(PunchS4OpponentState.self)
    }
    
    func punchS5() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(PunchS5OpponentState.self)
    }
    
    func hookS1() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(HookS1OpponentState.self)
    }

    func hookS2() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(HookS2OpponentState.self)
    }
    
    func hookS3() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(HookS3OpponentState.self)
    }
    
    func hookS4() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(HookS4OpponentState.self)
    }
    
    func hookS5() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(HookS5OpponentState.self)
    }
    
    // New Code End
    
    func hookTopLeft() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(HookTopLeftOpponentState.self)
    }
    
    func hookTopRight() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(HookTopRightOpponentState.self)
    }
    
    func hookBottomLeft() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(HookBottomLeftOpponentState.self)
    }
    
    func hookBottomRight() -> Bool {
        canBlockTop = true
        canBlockBottom = true
        
        return !isTired && stateMachine.enter(HookBottomRightOpponentState.self)
    }
    
    // MARK:
    
    func makeBlockTop() -> Bool {
        isTired = false
        canBlockTop = true
        canBlockBottom = false
        
        return stateMachine.enter(Idle5OpponentState.self)
    }
    
    func makeBlockBottom() -> Bool {
        isTired = false
        canBlockTop = false
        canBlockBottom = true
        
        return stateMachine.enter(Idle5OpponentState.self)
    }
    
    func makeBlockAll() -> Bool {
        isTired = false
        canBlockTop = true
        canBlockBottom = true
        
        return stateMachine.enter(Idle5OpponentState.self)
    }
    
    func makeIdle(kind: Int) -> Bool {
        isTired = false
        canBlockTop = false
        canBlockBottom = false
        
        switch kind {
        case 2:
            return stateMachine.enter(Idle2OpponentState.self)
        case 3:
            return stateMachine.enter(Idle3OpponentState.self)
        case 4:
            return stateMachine.enter(Idle4OpponentState.self)
        case 5:
            return stateMachine.enter(Idle5OpponentState.self)
        default:
            return stateMachine.enter(Idle1OpponentState.self)
        }
        
    }
    
    func makeTired() -> Bool {
        isTired = true
        canBlockTop = false
        canBlockBottom = false
        
        return stateMachine.enter(TiredOpponentState.self)
    }
    
    func celebrate() -> Bool {
        return stateMachine.enter(CelebrateOpponentState.self)
    }
    
    // MARK:
    
    func getPunchTopLeft(damage: Int) {
        if stateMachine.currentState is BlockOpponentState {
            getAttack(type: GetPunchTopLeftBlockedOpponentState.self, damage: 0)
        } else {
            getAttack(type: GetPunchTopLeftOpponentState.self, damage: damage)
        }
    }
    
    func getPunchTopRight(damage: Int) {
        if stateMachine.currentState is BlockOpponentState {
            getAttack(type: GetPunchTopRightBlockedOpponentState.self, damage: 0)
        } else {
            getAttack(type: GetPunchTopRightOpponentState.self, damage: damage)
        }
    }
    
    func getPunchBottomLeft(damage: Int) {
        if stateMachine.currentState is BlockOpponentState {
            getAttack(type: GetPunchBottomLeftBlockedOpponentState.self, damage: 0)
        } else {
            getAttack(type: GetPunchBottomLeftOpponentState.self, damage: damage)
        }
    }
    
    func getPunchBottomRight(damage: Int) {
        if stateMachine.currentState is BlockOpponentState {
            getAttack(type: GetPunchBottomRightBlockedOpponentState.self, damage: 0)
        } else {
            getAttack(type: GetPunchBottomRightOpponentState.self, damage: damage)
        }
    }
    
    func getHookTopLeft(damage: Int) {
        getAttack(type: GetHookTopLeftOpponentState.self, damage: damage)
    }
    
    func getHookTopRight(damage: Int) {
        getAttack(type: GetHookTopRightOpponentState.self, damage: damage)
    }
    
    func getHookBottomLeft(damage: Int) {
        getAttack(type: GetHookBottomLeftOpponentState.self, damage: damage)
    }
    
    func getHookBottomRight(damage: Int) {
        getAttack(type: GetHookBottomRightOpponentState.self, damage: damage)
    }
    
    // New Code Start
    func getPunchS1(damage: Int) {
        if stateMachine.currentState is BlockOpponentState {
            getAttack(type: GetPunchS1BlockedOpponentState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS1OpponentState.self, damage: damage)
        }
    }
    
    func getPunchS2(damage: Int) {
        if stateMachine.currentState is BlockOpponentState {
            getAttack(type: GetPunchS2BlockedOpponentState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS2OpponentState.self, damage: damage)
        }
    }
    
    func getPunchS3(damage: Int) {
        if stateMachine.currentState is BlockOpponentState {
            getAttack(type: GetPunchS3BlockedOpponentState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS3OpponentState.self, damage: damage)
        }
    }
    
    func getPunchS4(damage: Int) {
        if stateMachine.currentState is BlockOpponentState {
            getAttack(type: GetPunchS4BlockedOpponentState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS4OpponentState.self, damage: damage)
        }
    }
    
    func getPunchS5(damage: Int) {
        if stateMachine.currentState is BlockOpponentState {
            getAttack(type: GetPunchS5BlockedOpponentState.self, damage: 0)
        } else {
            getAttack(type: GetPunchS5OpponentState.self, damage: damage)
        }
    }
    
    func getHookS1(damage: Int) {
        getAttack(type: GetHookS1OpponentState.self, damage: damage)
    }
    
    func getHookS2(damage: Int) {
        getAttack(type: GetHookS2OpponentState.self, damage: damage)
    }
    
    func getHookS3(damage: Int) {
        getAttack(type: GetHookS3OpponentState.self, damage: damage)
    }
    
    func getHookS4(damage: Int) {
        getAttack(type: GetHookS4OpponentState.self, damage: damage)
    }
    
    func getHookS5(damage: Int) {
        getAttack(type: GetHookS5OpponentState.self, damage: damage)
    }
    
    // New Code End
    
    // MARK:
    
    private func getAttack(type getAttackClass: GetAttackOpponentState.Type, damage: Int) {
    	var adjustedDamage = damage
        let canBlock: Bool
        let blockClass: BlockOpponentState.Type
		
        if stateMachine.currentState is TiredOpponentState {
    		adjustedDamage = adjustedDamage * 2
		}
        
        if (getAttackClass is GetPunchBottomLeftOpponentState.Type) || (getAttackClass is GetPunchBottomRightOpponentState.Type) {
            adjustedDamage = adjustedDamage / 2
        }

        switch getAttackClass {
        case is GetPunchTopLeftOpponentState.Type, is GetPunchTopLeftBlockedOpponentState.Type, is GetHookTopLeftOpponentState.Type:
            canBlock = canBlockTop
            blockClass = BlockTopLeftOpponentState.self
            
        case is GetPunchTopRightOpponentState.Type, is GetPunchTopRightBlockedOpponentState.Type, is GetHookTopRightOpponentState.Type:
            canBlock = canBlockTop
            blockClass = BlockTopRightOpponentState.self
            
        case is GetPunchBottomLeftOpponentState.Type, is GetPunchBottomLeftBlockedOpponentState.Type, is GetHookBottomLeftOpponentState.Type,
             is GetPunchBottomRightOpponentState.Type, is GetPunchBottomRightBlockedOpponentState.Type, is GetHookBottomRightOpponentState.Type:
            canBlock = canBlockBottom
            blockClass = BlockBottomOpponentState.self
            
        // New Code Start
        case is GetPunchS1OpponentState.Type, is GetPunchS1BlockedOpponentState.Type, is GetHookS1OpponentState.Type:
            canBlock = canBlockTop
            blockClass = BlockTopLeftOpponentState.self
            
        case is GetPunchS2OpponentState.Type, is GetPunchS2BlockedOpponentState.Type, is GetHookS2OpponentState.Type:
            canBlock = canBlockTop
            blockClass = BlockTopRightOpponentState.self

        case is GetPunchS3OpponentState.Type, is GetPunchS3BlockedOpponentState.Type, is GetHookS3OpponentState.Type,
             is GetPunchS4OpponentState.Type, is GetPunchS4BlockedOpponentState.Type, is GetHookS4OpponentState.Type,
             is GetPunchS5OpponentState.Type, is GetPunchS5BlockedOpponentState.Type, is GetHookS5OpponentState.Type:
            canBlock = canBlockBottom
            blockClass = BlockBottomOpponentState.self
            
        // New Code End
            
        default:
            canBlock = false
            blockClass = BlockBottomOpponentState.self
        }
        
        if canBlock && stateMachine.enter(blockClass) {
            delegate?.opponentNodeDidBlock(self)
            // New Code Start
            shader = ShaderManager.SharedInstance.opponentBlockShader
            let waitAction = SKAction.wait(forDuration: 0.6)
            run(waitAction) { [weak self] in
                self?.updateShader()
            }
            processMotion(type: getAttackClass, blocked: true)
            // New Code End
        }
        else if health - adjustedDamage > 0 && stateMachine.enter(getAttackClass) {
            health -= adjustedDamage
			
            if (damage >= 10) {
            	shader = ShaderManager.SharedInstance.opponentHeavyHitShader
            }
            else {
				shader = ShaderManager.SharedInstance.opponentLightHitShader
			}
            
            let waitAction = SKAction.wait(forDuration: 0.6)
            run(waitAction) {
				[weak self] in
				
				self?.updateShader()
			}
            
            delegate?.opponentNodeDidGetAttack(self,
            	hook: getAttackClass is GetHookOpponentState.Type)
            // New Code Start
            processMotion(type: getAttackClass, blocked: false)
            // New Code End
        }
        else if health - adjustedDamage <= 0 && stateMachine.enter(KnockOutOpponentState.self) {
            health -= adjustedDamage
            
            delegate?.opponentNodeDidKnockOut(self)
        }
    }
    
    private func updateShader() {
        if health <= 0 {
            shader = nil
        }
        else if health < 20 {
            shader = ShaderManager.SharedInstance.opponentWeakShader
        }
        else if isTired {
            shader = ShaderManager.SharedInstance.opponentTiredShader
        }
        else {
            shader = nil
        }
    }
    
    // New Code Start
    private func processMotion(type getAttackClass: GetAttackOpponentState.Type, blocked: Bool) {
        let duration = 0.05 //0.05
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
        case is GetPunchTopLeftOpponentState.Type, is GetPunchTopLeftBlockedOpponentState.Type:
            dx = punchTopX
            dy = punchTopY
        case is GetPunchTopRightOpponentState.Type, is GetPunchTopRightBlockedOpponentState.Type:
            dx = -1 * punchTopX
            dy = punchTopY
        case is GetPunchBottomLeftOpponentState.Type, is GetPunchBottomLeftBlockedOpponentState.Type:
            dx = punchBottomX
            dy = punchBottomY
        case is GetPunchBottomRightOpponentState.Type, is GetPunchBottomRightBlockedOpponentState.Type:
            dx = -1 * punchBottomX
            dy = punchBottomY
        case is GetHookTopLeftOpponentState.Type:
            dx = hookTopX
            dy = hookTopY
        case is GetHookTopRightOpponentState.Type:
            dx = -1 * hookTopX
            dy = hookTopY
        case is GetHookBottomLeftOpponentState.Type:
            dx = hookBottomX
            dy = hookBottomY
        case is GetHookBottomRightOpponentState.Type:
            dx = -1 * hookBottomX
            dy = hookBottomY
            
        case is GetPunchS1OpponentState.Type, is GetPunchS1BlockedOpponentState.Type:
            dx = -1 * punchBottomX
            dy = punchBottomY
        case is GetPunchS2OpponentState.Type, is GetPunchS2BlockedOpponentState.Type:
            dx = -1 * punchBottomX
            dy = punchBottomY
        case is GetPunchS3OpponentState.Type, is GetPunchS3BlockedOpponentState.Type:
            dx = -1 * punchBottomX
            dy = punchBottomY
        case is GetPunchS4OpponentState.Type, is GetPunchS4BlockedOpponentState.Type:
            dx = -1 * punchBottomX
            dy = punchBottomY
        case is GetPunchS5OpponentState.Type, is GetPunchS5BlockedOpponentState.Type:
            dx = -1 * punchBottomX
            dy = punchBottomY
        case is GetHookS1OpponentState.Type:
            dx = hookTopX
            dy = hookTopY
        case is GetHookS2OpponentState.Type:
            dx = hookTopX
            dy = hookTopY
        case is GetHookS3OpponentState.Type:
            dx = hookTopX
            dy = hookTopY
        case is GetHookS4OpponentState.Type:
            dx = hookTopX
            dy = hookTopY
        case is GetHookS5OpponentState.Type:
            dx = hookTopX
            dy = hookTopY

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

}
