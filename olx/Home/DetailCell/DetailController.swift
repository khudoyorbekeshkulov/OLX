import UIKit

class DetailViewController: UIViewController {
    let rootView = DetailView()
    
    var categories: [Category] = []
    var category: Category?
    
    private var isCheckedHeart: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: self.isCheckedHeart ? "heart.fill" : "heart")
            }
        }
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
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithTransparentBackground()
        }
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
        
        let heartButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(didTapHeartButton)
        )
        navigationItem.rightBarButtonItem = heartButton
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
        isCheckedHeart.toggle()
    }
    
    @objc func messageOwnerTapped() {
        let messageVC = MessageViewController(navigationTitle: category?.productOwner ?? "Сообщения")
        navigationController?.pushViewController(messageVC, animated: true)
    }
}
