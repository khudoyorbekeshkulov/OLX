import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension FavoritesViewController {
    func setupUI() {
        view.backgroundColor = UIColor(named: "app_background_color")
        
        navigationItem.title = "Избранное"
    }
}
