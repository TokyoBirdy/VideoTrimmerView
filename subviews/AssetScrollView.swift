import UIKit

protocol  CustomStackViewDelegate : AnyObject {
    func forceLayoutSubviews()
}

class CustomStackView:UIStackView {

    weak var delegate: CustomStackViewDelegate?

}

class AssetScrollView: UIScrollView {

    let stackView: CustomStackView

    override init(frame: CGRect) {
        stackView = CustomStackView()
        super.init(frame: frame)
        addSubview(stackView)
        stackView.backgroundColor = UIColor.red
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0

        setupConstraints()

        createThumbnailViews(12)

    }


    private func createThumbnailViews(_ count: Int) {
        let range = 0...count
        range.forEach { _ in

            //Need to give a size
            let height = 80

            let imgView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: height, height: height)))
            let colorImage = randomColor.image(CGSize(width:height, height: height))
            imgView.image = colorImage
           // imgView.frame.size = colorImage.size
            stackView.addArrangedSubview(imgView)
        }

    }

    var randomColor: UIColor {
        let hue: CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation: CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness: CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }




    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalTo:heightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

    }



}


extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image(actions: { renderContext in
            self.setFill()
            renderContext.fill(CGRect(origin: .zero, size: size))
        })
    }
}
