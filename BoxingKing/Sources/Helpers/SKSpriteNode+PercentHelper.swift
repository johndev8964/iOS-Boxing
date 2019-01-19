import SpriteKit


extension SKSpriteNode {
    func percentFillScale(referSize: CGSize,
                          widthPercent: CGFloat, heightPercent: CGFloat) -> CGFloat {
        return max(referSize.width / size.width * widthPercent,
                   referSize.height / size.height * heightPercent)
    }
    
    func percentFitScale(referSize: CGSize,
                         widthPercent: CGFloat, heightPercent: CGFloat) -> CGFloat {
        return min(referSize.width / size.width * widthPercent,
                   referSize.height / size.height * heightPercent)
    }
}
