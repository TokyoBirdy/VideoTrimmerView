import UIKit

class TrimmerView: UIView {

    let handleWidth : CGFloat = 10.0

    let assetScrollView: AssetScrollView
    let leftOverlayView : OverlayView
    let rightOverlayView : OverlayView

    let leftHandleView : HandleView
    let rightHandleView : HandleView
    let middleOverLayview: OverlayView
    var leftConstraint: NSLayoutConstraint!
    var rightConstraint: NSLayoutConstraint!


    var leftStartingPoint: CGPoint = .zero
    var rightStartingPoint: CGPoint = .zero
    var middleStartingPoint: CGPoint = .zero

    var isDraggingLeftHandle: Bool = false
    var isDraggingRighthandle: Bool = false
    var isDraggingMiddleView: Bool = false
    var maxTrimLength: CGFloat = 200
    var minTrimLength: CGFloat = 80
    var trimLength : CGFloat = 100

    var leftConstraintMax: CGFloat = 0
    var rightConstraintMax: CGFloat = 0

    override init(frame: CGRect) {
        assetScrollView = AssetScrollView(frame: .zero)


        leftOverlayView = OverlayView(frame:.zero)
        rightOverlayView = OverlayView(frame:.zero)

        leftHandleView = HandleView(frame:.zero)
        rightHandleView = HandleView(frame:.zero)
        middleOverLayview = OverlayView(frame:.zero)

        super.init(frame: frame)

        middleOverLayview.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.1)
        addSubview(assetScrollView)

        middleOverLayview.addSubview(leftHandleView)
        middleOverLayview.addSubview(rightHandleView)

        addSubview(leftOverlayView)
        addSubview(middleOverLayview)
        addSubview(rightOverlayView)

        setupConstraints()

        leftOverlayView.isUserInteractionEnabled = false
        rightOverlayView.isUserInteractionEnabled = false

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveOverlayView(_:)))
        self.addGestureRecognizer(panGestureRecognizer)

        middleOverLayview.backgroundColor = UIColor.red.withAlphaComponent(0.7)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        let allSubviews = self.getAllSubviews() as [UIView]
        allSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false}
        leftConstraint = leftOverlayView.trailingAnchor.constraint(equalTo: leadingAnchor)
        rightConstraint = rightOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: maxTrimLength)

        let constraints : [NSLayoutConstraint] = [
            assetScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            assetScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            assetScrollView.heightAnchor.constraint(equalTo: heightAnchor),
            assetScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            leftOverlayView.topAnchor.constraint(equalTo: topAnchor),
            leftOverlayView.widthAnchor.constraint(equalTo: widthAnchor),
            leftOverlayView.heightAnchor.constraint(equalTo:heightAnchor),
            leftConstraint,

            rightOverlayView.topAnchor.constraint(equalTo: topAnchor),
            rightOverlayView.widthAnchor.constraint(equalTo: widthAnchor),
            rightOverlayView.heightAnchor.constraint(equalTo:heightAnchor),
            rightConstraint,

            middleOverLayview.topAnchor.constraint(equalTo: topAnchor),
            middleOverLayview.heightAnchor.constraint(equalTo:heightAnchor),
            middleOverLayview.leadingAnchor.constraint(equalTo: leftOverlayView.trailingAnchor),
            middleOverLayview.trailingAnchor.constraint(equalTo: rightOverlayView.leadingAnchor),

            leftHandleView.topAnchor.constraint(equalTo: middleOverLayview.topAnchor),
            leftHandleView.leadingAnchor.constraint(equalTo:middleOverLayview.leadingAnchor),
            leftHandleView.heightAnchor.constraint(equalTo:middleOverLayview.heightAnchor),
            leftHandleView.widthAnchor.constraint(equalToConstant: handleWidth),

            rightHandleView.topAnchor.constraint(equalTo: middleOverLayview.topAnchor),
            rightHandleView.trailingAnchor.constraint(equalTo:middleOverLayview.trailingAnchor),
            rightHandleView.heightAnchor.constraint(equalTo:rightOverlayView.heightAnchor),
            rightHandleView.widthAnchor.constraint(equalToConstant: handleWidth),
            ]

        NSLayoutConstraint.activate(constraints)
    }


    @objc func moveOverlayView(_ geature: UIPanGestureRecognizer) {

        switch geature.state {
        case .began:
            let isLeft = leftHandleView.point(inside: geature.location(in: leftHandleView))
            let isRight = rightHandleView.point(inside: geature.location(in: rightHandleView))
          //  let isMiddle = middleOverLayview.point(inside: geature.location(in: middleOverLayview))

            let touchingPoint = geature.location(in: self)

            if (isLeft) {
                leftStartingPoint = touchingPoint
                isDraggingLeftHandle = true
                isDraggingRighthandle = false
                isDraggingMiddleView = false
                print("start left now")

            } else if (isRight) {
                rightStartingPoint = touchingPoint
                isDraggingLeftHandle = false
                isDraggingRighthandle = true
                isDraggingMiddleView = false
                print("start right now")

            } else {
                middleStartingPoint = touchingPoint
                isDraggingLeftHandle = false
                isDraggingRighthandle = false
                isDraggingMiddleView = true
                print("start middle now")

            }

        case .changed:
           let touchingPoint = geature.location(in: self)
           if (isDraggingLeftHandle) {
            let deltaX = touchingPoint.x - self.leftStartingPoint.x
            leftConstraint.constant += deltaX
            let rightEdgeMax = rightConstraint.constant - minTrimLength
            let leftConstraintleftMax = rightConstraint.constant - maxTrimLength
            leftConstraint.constant = min(rightEdgeMax, max(leftConstraint.constant, leftConstraintleftMax))
            self.leftStartingPoint = touchingPoint
            updateFilmLength()
             print("change left now")


           } else if (isDraggingRighthandle) {
            let deltaX = touchingPoint.x - self.rightStartingPoint.x
            rightConstraint.constant += deltaX
            let leftEdgeMax = leftConstraint.constant + minTrimLength

            let rightScrollMax = leftConstraint.constant + maxTrimLength
            let rightEdgeMax = min(bounds.width, rightScrollMax)
            rightConstraint.constant = min(max(leftEdgeMax, rightConstraint.constant), rightEdgeMax)
            self.rightStartingPoint = touchingPoint
            updateFilmLength()
            print("change right now")

           } else {
            //assume dragging middle
            let deltaX = touchingPoint.x - self.middleStartingPoint.x
            leftConstraint.constant += deltaX
            let leftConstraintRightMax = bounds.width - trimLength
            leftConstraint.constant = min(max(leftConstraint.constant, 0),leftConstraintRightMax)
            rightConstraint.constant += deltaX
            let rightConstraintlLeftMax = trimLength
            let rightConstraintRightMax = bounds.width
            rightConstraint.constant = min(max(rightConstraint.constant, rightConstraintlLeftMax), rightConstraintRightMax)
            self.middleStartingPoint = touchingPoint
             print("change middle now")
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
       // let length = rightOverlayView.frame.minX - leftOverlayView.frame.maxX
        let anotherLength = rightConstraint.constant - leftConstraint.constant

        trimLength = max(min(anotherLength, maxTrimLength), minTrimLength)
       // print("trim length", trimLength)
    }



}
