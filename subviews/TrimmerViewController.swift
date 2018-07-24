import UIKit

class TrimmerViewController: UIViewController {

    let trimmerView: TrimmerView
    

    init() {
        trimmerView = TrimmerView()
        trimmerView.backgroundColor = UIColor.red

        super.init(nibName: nil, bundle: nil)
        view.addSubview(trimmerView)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        trimmerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            trimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            trimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            trimmerView.heightAnchor.constraint(equalToConstant: 80),
            trimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2),
            ]

        NSLayoutConstraint.activate(constraints)
    }


 
}
