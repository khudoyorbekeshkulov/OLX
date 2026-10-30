import UIKit

class DetailViewController: UIViewController {
    let rootView = DetailView()
    
    var categories: [Category] = []
    var category: Category?
    
    private var isCheckedHeart: Bool = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                navigationItem.rightBarButtonItem?.image = heartImage
            }
        }
    }
    
    private var heartImage: UIImage? {
        UIImage(systemName: isCheckedHeart ? "heart.fill" : "heart")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupViewBinders()
    }
}

private extension DetailViewController {
    func setupNavBar() {
        if let category {
            isCheckedHeart = FavoritesService.shared.contains(category)
        }
        
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithTransparentBackground()
        }
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: heartImage,
            style: .plain,
            target: self,
            action: #selector(didTapHeartButton)
        )
    }
    
    func setupViewBinders() {
        rootView.onProductOwnerTapped = { [weak self] in
            self?.messageOwnerTapped()
        }
        
        rootView.onCategorySelected = { [weak self] selectedCategory in
            guard let self else { return }
            
            let detailVC = DetailViewController().then {
                $0.category = selectedCategory
                $0.categories = self.categories
            }
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
        if let category = category {
            rootView.configure(category: category)
        }
        
        rootView.configureCategories(categories: categories)
    }
    
    @objc func didTapHeartButton() {
        guard let category else { return }
        FavoritesService.shared.toggle(category)
        isCheckedHeart = FavoritesService.shared.contains(category)
    }
    
    @objc func messageOwnerTapped() {
        let messageVC = MessageViewController(navigationTitle: category?.productOwner ?? "Сообщения")
        navigationController?.pushViewController(messageVC, animated: true)
    }
}
