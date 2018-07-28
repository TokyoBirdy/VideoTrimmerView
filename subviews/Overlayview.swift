import UIKit

class OverlayView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.point(inside: point)
    }

    func point(inside point: CGPoint) -> Bool {
        let relativeFrame = self.bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, .zero)
        let result = hitFrame.contains(point)
        print("result is", result)
        return result
    }


}
