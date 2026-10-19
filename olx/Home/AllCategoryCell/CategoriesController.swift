import UIKit

class CategoriesViewController: UIViewController {
    let rootView = CategoriesView()
    
    private lazy var categories = [Category]() {
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

private extension CategoriesViewController {
    func setupViewController() {
        navigationItem.title = "Категории"
    }
    
    func setupNetworkCalls() {
        categories = NetworkServiceMainProductChapterImplementation
            .shared
            .getCategoriesAllInfo()
            .toCategoryMainProductsChapter
    }
    
    func setupViewBinders() {
        rootView.onSectionTapped = { [weak self] in
            guard let self else { return }
            
            navigationController?.pushViewController(
                SelectedCategoryController(),
                animated: true
            )
        }
    }
}
