import Foundation


// MARK: -

protocol ScoreBoardDelegate: class {
    func scoreBoardDidChangeTimeLeft(_ sender: ScoreBoardNode, timeLeft: Int)
    func scoreBoardDidChangeHealthLeft(_ sender: ScoreBoardNode, healthLeft: Int)
    func scoreBoardDidFinishCalculation(_ sender: ScoreBoardNode)
}
