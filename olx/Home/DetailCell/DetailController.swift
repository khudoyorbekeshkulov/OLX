import UIKit
import SnapKit

class DetailViewController: UIViewController {
    let rootView = DetailView()
    
    private let mainColor = ColorResourceManager.shared.mainColor
    
    var categories: [Category] = []
    var category: Category?
    
    private var isCheckedHeart: Bool = false {
        didSet {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: isCheckedHeart ? "heart.fill" : "heart")
        }
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupNavBar()
        
        rootView.onProductOwnerTapped = { [weak self ] in
            self?.messageOwnerTapped()
        }
        
        if let category = category {
            rootView.configure(category: category)
        }
        
        rootView.configureCategories(categories: categories)
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
    
    @objc func didTapHeartButton() {
        isCheckedHeart.toggle()
    }
    
    @objc func messageOwnerTapped() {
        let messageVC = MessageViewController()
        messageVC.chatPartnerName = category?.productOwner ?? messageVC.chatPartnerName
        
        navigationController?.pushViewController(messageVC, animated: true)
    }
}
