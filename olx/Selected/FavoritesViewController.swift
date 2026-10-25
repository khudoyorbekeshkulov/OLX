import UIKit

class FavoritesViewController: UIViewController {
    let rootView = FavoritesView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rootView.setupItems(FavoritesService.shared.items)
    }
}

private extension FavoritesViewController {
    func setupUI() {
        view.backgroundColor = UIColor(named: "app_background_color")
        
        navigationItem.title = "Избранное"
    }
}

private extension FavoritesViewController {
    func setupViewBinders() {
        rootView.onItemSelected = { [weak self] category in
            guard let self else { return }
            
            let detailViewController = DetailViewController().then {
                $0.category = category
                $0.categories = FavoritesService.shared.items
            }
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
