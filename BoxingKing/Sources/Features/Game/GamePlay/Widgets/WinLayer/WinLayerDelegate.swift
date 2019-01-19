import Foundation


// MARK: -

protocol WinLayerDelegate: class {
    func winLayerDidChangeTimeLeft(_ sender: WinLayerNode, timeLeft: Int)
    func winLayerDidChangeHealthLeft(_ sender: WinLayerNode, healthLeft: Int)
	
    func winLayerDidClickNext(_ sender: WinLayerNode)
    func winLayerDidClickShare(_ sender: WinLayerNode)
    func winLayerDidClickRate(_ sender: WinLayerNode)
}
