import UIKit

final class ProfileViewController: UIViewController {
    let rootView = ProfileView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

private extension ProfileViewController {
    func setupView() {
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(tappedToView)
            )
        )
    }
    
    @objc func tappedToView() {
        view.endEditing(true)
    }
}
