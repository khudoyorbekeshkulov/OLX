import UIKit

class FavouritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension FavouritesViewController {
    func setupUI() {
        view.backgroundColor = UIColor(named: "app_background_color")
        
        navigationItem.title = "Избранное"
    }
}
