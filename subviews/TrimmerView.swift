import UIKit

class TrimmerView: UIView {

    let handleWidth : CGFloat = 10.0

    let assetScrollView: AssetScrollView
    let leftOverlayView : OverlayView
    let leftHandleView : HandleView
    let rightOverlayView : OverlayView
    let rightHandleView : HandleView
    var leftConstraint: NSLayoutConstraint!
    var rightConstraint: NSLayoutConstraint!


    var leftStartingPoint: CGPoint = .zero
    var rightStartingPoint: CGPoint = .zero
    var middleStartingPoint: CGPoint = .zero

    var isDraggingLeftOverlay: Bool = false
    var isDraggingRightOverlay: Bool = false
    var isDraggingMiddleView: Bool = false
    var trimLength: CGFloat = 100

    var leftConstraintMax: CGFloat = 0
    var rightConstraintMax: CGFloat = 0

    override init(frame: CGRect) {
        assetScrollView = AssetScrollView(frame: .zero)

        leftHandleView = HandleView(frame:.zero)
        leftOverlayView = OverlayView(frame:.zero)

        rightHandleView = HandleView(frame:.zero)
        rightOverlayView = OverlayView(frame:.zero)

        super.init(frame: frame)

        assetScrollView.backgroundColor = UIColor.cyan
        addSubview(assetScrollView)
        leftOverlayView.addSubview(leftHandleView)
        rightOverlayView.addSubview(rightHandleView)
        addSubview(leftOverlayView)
        addSubview(rightOverlayView)

        setupConstraints()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveOverlayView(_:)))
        assetScrollView.isUserInteractionEnabled = false
        self.addGestureRecognizer(panGestureRecognizer)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        let allSubviews = self.getAllSubviews() as [UIView]
        allSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false}
        leftConstraint = leftOverlayView.trailingAnchor.constraint(equalTo: leadingAnchor, constant: handleWidth)
        rightConstraint = rightOverlayView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -handleWidth)

        let constraints : [NSLayoutConstraint] = [
            assetScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            assetScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            assetScrollView.heightAnchor.constraint(equalTo: heightAnchor),
            assetScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            leftHandleView.topAnchor.constraint(equalTo: topAnchor),
            leftHandleView.trailingAnchor.constraint(equalTo:leftOverlayView.trailingAnchor),
            leftHandleView.heightAnchor.constraint(equalTo:leftOverlayView.heightAnchor),
            leftHandleView.widthAnchor.constraint(equalToConstant: handleWidth),

            leftOverlayView.topAnchor.constraint(equalTo: topAnchor),
            leftOverlayView.widthAnchor.constraint(equalTo: widthAnchor),
            leftOverlayView.heightAnchor.constraint(equalTo:heightAnchor),
            leftConstraint,

            rightHandleView.topAnchor.constraint(equalTo: topAnchor),
            rightHandleView.leadingAnchor.constraint(equalTo:rightOverlayView.leadingAnchor),
            rightHandleView.heightAnchor.constraint(equalTo:rightOverlayView.heightAnchor),
            rightHandleView.widthAnchor.constraint(equalToConstant: handleWidth),

            rightOverlayView.topAnchor.constraint(equalTo: topAnchor),
            rightOverlayView.widthAnchor.constraint(equalTo: widthAnchor),
            rightOverlayView.heightAnchor.constraint(equalTo:heightAnchor),
            rightConstraint,
            ]

        NSLayoutConstraint.activate(constraints)
    }


    @objc func moveOverlayView(_ geature: UIPanGestureRecognizer) {


        switch geature.state {
        case .began:
            let isLeft = leftOverlayView.point(inside: geature.location(in: leftOverlayView))
            let isRight = rightOverlayView.point(inside: geature.location(in: rightOverlayView))


            let touchingPoint = geature.location(in: self)

            if (isLeft) {
                leftStartingPoint = touchingPoint
                isDraggingLeftOverlay = true
                isDraggingRightOverlay = false
                isDraggingMiddleView = false

            } else if (isRight) {
                rightStartingPoint = touchingPoint
                isDraggingLeftOverlay = false
                isDraggingRightOverlay = true
                isDraggingMiddleView = false

            } else {
                middleStartingPoint = touchingPoint
                isDraggingLeftOverlay = false
                isDraggingRightOverlay = false
                isDraggingMiddleView = true
                leftConstraintMax = maxConstraints()
                rightConstraintMax = -maxConstraints()

            }

        case .changed:
           let touchingPoint = geature.location(in: self)
           if (isDraggingLeftOverlay) {
            let deltaX = touchingPoint.x - self.leftStartingPoint.x
            leftConstraint.constant += deltaX
            leftConstraint.constant = max(leftConstraint.constant, 10)
            self.leftStartingPoint = touchingPoint
            updateFilmLength()

           } else if (isDraggingRightOverlay) {
            let deltaX = touchingPoint.x - self.rightStartingPoint.x
            rightConstraint.constant += deltaX
            rightConstraint.constant = min(rightConstraint.constant, -10)
            self.rightStartingPoint = touchingPoint
            updateFilmLength()

           } else {
            //assume dragging middle
            let deltaX = touchingPoint.x - self.middleStartingPoint.x
            leftConstraint.constant += deltaX
            leftConstraint.constant = min(max(leftConstraint.constant, 10), leftConstraintMax)
            rightConstraint.constant += deltaX
            rightConstraint.constant = min(max(rightConstraint.constant, rightConstraintMax), -10)

            self.middleStartingPoint = touchingPoint
            }
        case .ended:
            break
        case .cancelled:
            break
        case .failed:
            break
        case .possible:
            break
        }
    }


    func updateFilmLength() {
        trimLength = rightOverlayView.frame.minX - leftOverlayView.frame.maxX
        print("trim length", trimLength)
    }

    func maxConstraints() -> CGFloat {
        return bounds.width - trimLength - handleWidth
    }

}
