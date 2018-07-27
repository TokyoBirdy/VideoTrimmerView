import UIKit

class BottomViewController : UIViewController {
    var trimmerViewController: TrimmerViewController!
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        //So this is done in auto layout just only manully setup
        trimmerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            trimmerViewController.view.heightAnchor.constraint(equalTo:view.heightAnchor),
            trimmerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trimmerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            trimmerViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor)

        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        trimmerViewController = TrimmerViewController()
        addChildViewController(trimmerViewController)
        view.addSubview(trimmerViewController.view)
        trimmerViewController.didMove(toParentViewController: self)
        trimmerViewController.view.backgroundColor = UIColor.blue
        setupConstraints()
        
        
    }
}
