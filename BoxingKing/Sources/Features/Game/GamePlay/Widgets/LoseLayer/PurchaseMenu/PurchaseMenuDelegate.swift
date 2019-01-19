import Foundation


// MARK: -

protocol PurchaseMenuDelegate: class {
	func purchaseMenuDidClickPurchaseContinue2(_ sender: PurchaseMenuNode)
	func purchaseMenuDidClickPurchaseContinue6(_ sender: PurchaseMenuNode)
	func purchaseMenuDidClickPurchaseContinue15(_ sender: PurchaseMenuNode)
	func purchaseMenuDidClickPurchaseContinue35(_ sender: PurchaseMenuNode)
	func purchaseMenuDidClickBack(_ sender: PurchaseMenuNode)
}
