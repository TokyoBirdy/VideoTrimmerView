import UIKit

class ViewController: UIViewController {
    let bottomViewController:BottomViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(bottomViewController)
        view.addSubview(bottomViewController.view)
        bottomViewController.didMove(toParentViewController: self)
        setupConstraints()

    }
    
    required init?(coder aDecoder: NSCoder) {
        bottomViewController = BottomViewController()
       super.init(coder: aDecoder)

        bottomViewController.view.backgroundColor = UIColor.yellow


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

