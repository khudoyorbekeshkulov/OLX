import UIKit

class Add: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
    }
    
    private func setupNav() {
        view.backgroundColor = UIColor(named: "app_background_color")
        navigationItem.title = "Создать"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        print("Add tapped")
    }
}
