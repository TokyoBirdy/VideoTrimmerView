import UIKit

class HandleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.point(inside: point)
    }

    func point(inside point: CGPoint) -> Bool {
        let relativeFrame = self.bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, UIEdgeInsetsMake(0, -30, 0, -30))
        let result = hitFrame.contains(point)
       // print("result is", result)
        return result
    }
}
