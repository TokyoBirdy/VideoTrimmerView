import UIKit

class ViewController: UIViewController {
    var bottomViewController:BottomViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomViewController = BottomViewController()
        bottomViewController.view.backgroundColor = UIColor.black

        addChildViewController(bottomViewController)
        view.addSubview(bottomViewController.view)
        bottomViewController.didMove(toParentViewController: self)
        setupConstraints()

    }


    func setupConstraints() {
        //So this is done in auto layout just only manully setup
        bottomViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            bottomViewController.view.heightAnchor.constraint(equalToConstant: 100),
            bottomViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }




}

