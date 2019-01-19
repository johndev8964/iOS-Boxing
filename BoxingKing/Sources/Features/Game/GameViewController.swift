import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK:
    
    override func loadView() {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            fatalError("Key window is not set.")
        }
		
		if #available(iOS 11.0, *) {
			view = SKView(frame: keyWindow.safeAreaLayoutGuide.layoutFrame)
		}
		else {
			view = SKView(frame: keyWindow.frame)
		}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        skView.ignoresSiblingOrder = true
        skView.isMultipleTouchEnabled = false
        
        if AppConfig.DebugMode {
            //skView.showsFPS = true
            //skView.showsNodeCount = true
            //skView.showsDrawCount = true
            //skView.showsQuadCount = true
        }
		
        let nextScene = SplashScene(size: skView.bounds.size)
        nextScene.scaleMode = .aspectFill
        // New Code Start
        // Present without animations
        skView.presentScene(nextScene)
        // let transition = SKTransition.fade(withDuration: 0.3)
        // skView.presentScene(nextScene, transition: transition)
        // New Code End
    }
	
    override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

        if #available(iOS 11.0, *) {
            if let window = view.window {
                view.frame = window.safeAreaLayoutGuide.layoutFrame
            }
        }
	}
}
