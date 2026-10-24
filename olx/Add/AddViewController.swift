import UIKit

class AddViewController: UIViewController {
    let rootView = AddView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
    }
}

private extension AddViewController {
    func setupNav() {
        navigationItem.title = "Создать"
    }
}
