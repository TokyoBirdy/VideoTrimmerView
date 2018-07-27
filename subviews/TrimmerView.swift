import UIKit

class TrimmerView: UIView, CustomStackViewDelegate {

    let handleWidth : CGFloat = 10.0

    let assetScrollView: AssetScrollView
    let leftOverlayView : OverlayView
    let leftHandleView : HandleView
    let rightOverlayView : OverlayView
    let rightHandleView : HandleView
    var leftConstraint: NSLayoutConstraint!
    var rightConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        assetScrollView = AssetScrollView(frame: .zero)

        leftHandleView = HandleView(frame:.zero)
        leftOverlayView = OverlayView(frame:.zero)

        rightHandleView = HandleView(frame:.zero)
        rightOverlayView = OverlayView(frame:.zero)

        super.init(frame: frame)

        assetScrollView.backgroundColor = UIColor.cyan
        assetScrollView.stackView.delegate = self
        addSubview(assetScrollView)
        leftOverlayView.addSubview(leftHandleView)
        rightOverlayView.addSubview(rightHandleView)
        addSubview(leftOverlayView)
        addSubview(rightOverlayView)

        setupConstraints()

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
            assetScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            assetScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
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

    func forceLayoutSubviews() {
        setNeedsLayout()
    }


}
