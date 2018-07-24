import UIKit

class BottomViewController : UIViewController {
    let trimmerViewController: TrimmerViewController

    init() {
        trimmerViewController = TrimmerViewController()
        super.init(nibName: nil, bundle: nil)

        addChildViewController(trimmerViewController)
        view.addSubview(trimmerViewController.view)
        trimmerViewController.didMove(toParentViewController: self)
        trimmerViewController.view.backgroundColor = UIColor.blue
       setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        //So this is done in auto layout just only manully setup
        trimmerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            trimmerViewController.view.heightAnchor.constraint(equalToConstant: 90),
            trimmerViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            trimmerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            trimmerViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)

        ]
        NSLayoutConstraint.activate(constraints)
    }
}
