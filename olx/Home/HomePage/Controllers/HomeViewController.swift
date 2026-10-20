import UIKit

class HomeViewController: UIViewController {
    let rootView = HomeView()
    
    private var categories = [Category]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                rootView.setupCategories(categories: categories)
            }
        }
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupNetworkCalls()
        setupViewBinders()
    }
}

private extension HomeViewController {
    
    func setupViewController() {
        navigationItem.titleView = rootView.searchContainer
    }
    
    func setupNetworkCalls() {
        let mockNetworkServiceInstance = NetworkServiceImplementation.shared
        categories = mockNetworkServiceInstance.getCategories().toCategories
    }
    
    func setupViewBinders() {
        rootView.onShowAllCategoriesTapped = { [weak self] in
            guard let self else { return }
            
            navigationController?.pushViewController(
                CategoriesViewController(),
                animated: true
            )
        }
        
        rootView.onCategorySelected = { [weak self] category in
            guard let self else { return }
            
            let detailVC = DetailViewController().then{
                $0.category = category
                $0.categories = self.categories
            }
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
