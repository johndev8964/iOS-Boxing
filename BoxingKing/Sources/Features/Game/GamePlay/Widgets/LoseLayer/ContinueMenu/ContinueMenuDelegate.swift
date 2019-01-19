import Foundation


// MARK: -

protocol ContinueMenuDelegate: class {	
	func continueMenuDidClickWatchAd(_ sender: ContinueMenuNode)
	func continueMenuDidClickContinue(_ sender: ContinueMenuNode)
	func continueMenuDidClickBack(_ sender: ContinueMenuNode)
	func continueMenuDidFinishCountdown(_ sender: ContinueMenuNode)
}
