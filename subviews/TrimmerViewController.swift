import UIKit

class TrimmerViewController: UIViewController {

    var trimmerView: TrimmerView!

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        trimmerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            trimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trimmerView.heightAnchor.constraint(equalTo:view.heightAnchor),
            trimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]

        NSLayoutConstraint.activate(constraints)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        trimmerView = TrimmerView()
        trimmerView.backgroundColor = UIColor.red
        view.addSubview(trimmerView)
        setupConstraints()
 
    }


 
}
