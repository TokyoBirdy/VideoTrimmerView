import UIKit

class TrimmerView: UIView, CustomStackViewDelegate {

    let assetScrollView: AssetScrollView

    override init(frame: CGRect) {
        assetScrollView = AssetScrollView(frame: .zero)
        super.init(frame: frame)
        addSubview(assetScrollView)
        setupConstraints()
        assetScrollView.backgroundColor = UIColor.cyan
        assetScrollView.stackView.delegate = self


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        assetScrollView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            assetScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            assetScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            assetScrollView.heightAnchor.constraint(equalToConstant: 80),
            assetScrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            ]

        NSLayoutConstraint.activate(constraints)
    }

    func forceLayoutSubviews() {
        setNeedsLayout()
    }


}
