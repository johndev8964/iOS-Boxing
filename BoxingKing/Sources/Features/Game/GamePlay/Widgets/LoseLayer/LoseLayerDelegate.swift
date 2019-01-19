import Foundation


// MARK: -

protocol LoseLayerDelegate: class {
	func loseLayerDidWatchAd(_ sender: LoseLayerNode)
	func loseLayerDidSpendContinue(_ sender: LoseLayerNode)
	func loseLayerDidPurchaseContinue(_ sender: LoseLayerNode)
	func loseLayerDidResign(_ sender: LoseLayerNode)
}
