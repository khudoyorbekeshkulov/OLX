import UIKit

class AddViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNav()
    }
}

private extension AddViewController {
    
    func setupUI () {
        view.backgroundColor = UIColor(named: "app_background_color")
    }
    
    func setupNav() {
        navigationItem.title = "Создать"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        print("Add tapped")
    }
}
