import UIKit

class FavoritesViewController: UIViewController {
    let rootView = FavoritesView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewBinders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rootView.setupItems(FavoritesService.shared.items)
    }
}

private extension FavoritesViewController {
    func setupUI() {
        view.backgroundColor = ColorResourceManager.shared.appBackground
        
        navigationItem.title = L10n.Favorites.favoritesNavigationTitle
    }
    
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
