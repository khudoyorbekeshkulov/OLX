import UIKit

class Add: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNav()
    }
}

private extension Add {
    
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
