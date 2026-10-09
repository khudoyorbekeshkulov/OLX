import UIKit

class HomePage: UIViewController, UITextFieldDelegate {
    private var searchResults: [CategoryItem] = []
    private let searchContainer = UIView()
    
    private let searchingTextField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let searchTableView = UITableView()
    
    let mockNetworkServiceInstance = NetworkServiceImplementation.shared
    
    private lazy var categories: [CategoryItem] = mockNetworkServiceInstance.getCategories().toCategories  [CategoryItem]

    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.backgroundColor = .systemGray6
        
        collectionView.register(CategoryContainerCell.self, forCellWithReuseIdentifier: "categoryContainerCell")
        
        collectionView.register(RecommendedCell.self, forCellWithReuseIdentifier: "recommendedCategoryCell")
        
        collectionView.register(RecommendedHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "recommendedHeader")
        
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(mainCollectionView)
        setupSearchBar()
        setupConstraints()
        
        searchResults = categories.filter {
            $0.title.lowercased().contains("nexia")
        }
    }
}

extension HomePage: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            /// bu yerda categoryContainerCell ni qaytarayapti
            return 1
        }
        /// bu yerda recommendedCell dagi elementlar sonini qaytaradi
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryContainerCell", for: indexPath) as? CategoryContainerCell else {
                return UICollectionViewCell()
            }
                        
            cell.delegate = self
                
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedCategoryCell", for: indexPath) as? RecommendedCell else {
            return UICollectionViewCell()
        }
        /// Category dagi o'zgaruvchilarni recommendedCategoryCell dagi o'zgaruvchilarga tengladik.
        let category = categories[indexPath.row]

        cell.profileImage.image = category.image
        cell.additionalLabel.text = category.title
        cell.saleLabel.text = category.numberOfSales
        cell.timeLabel.text = category.locationAndTime
        cell.isImpact = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "recommendedHeader", for: indexPath) as? RecommendedHeaderView else {
            return UICollectionReusableView()
        }
        return cell
    }
    /// Bu yerda recommendedCell ni ustiga bosganda yangi list ochilish uchun function qildik
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let category = categories[indexPath.row]
            
            let detailVC = DetailViewController()
            
            detailVC.category = category
            detailVC.categories = categories
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension HomePage: CategoryContainerCellDelegate {
    func didTapShowAllCategories() {
        let categoriesPage = CategoriesPage()
        navigationController?.pushViewController(categoriesPage, animated: true)
    }
}

extension HomePage: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
        return CGSize(width: collectionView.bounds.width, height: 190)
        }
        
        return CGSize(width: 180, height: 180)
    }
    
    //MARK: Header bilan recommendedCell orasidagi spacing ni control qilish
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.bounds.width, height: 60)
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        } else if section == 1 {
            return UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        }
        return .zero
    }
    
    //MARK: Ikkita section orasidagi masofani control qilish
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 15
    }
}
    
private extension HomePage {
    
    func setupSearchBar() {
        let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 36))
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        
        searchContainer.addSubview(searchingTextField)
        leftContainer.addSubview(icon)
        
        icon.tintColor = .systemGray
        icon.frame = CGRect(x: 12, y: 8, width: 23, height: 20)
        
        searchContainer.backgroundColor = .white
        searchContainer.layer.cornerRadius = 8
        searchingTextField.placeholder = "Поиск"
        searchingTextField.leftView = leftContainer
        searchingTextField.leftViewMode = .always
        navigationItem.titleView = searchContainer
    }
 
    func setupConstraints() {
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            searchContainer.heightAnchor.constraint(equalToConstant: 36),
            
            searchingTextField.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 10),
            searchingTextField.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: -10),
            searchingTextField.topAnchor.constraint(equalTo: searchContainer.topAnchor),
            searchingTextField.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor),
            
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
