import UIKit
import SnapKit

class HomeViewController: UIViewController, UITextFieldDelegate {
    let rootView = HomeView()
    
    private var searchResults: [Category] = []
    
    private let searchTableView = UITableView()
    
    let mockNetworkServiceInstance = NetworkServiceImplementation.shared
    
    private lazy var categories: [Category] = mockNetworkServiceInstance.getCategories().toCategories
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupDelegates()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            /// bu yerda categoryContainerCell ni qaytarayapti
            return 1
        default:
            return categories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryContainerCell", for: indexPath) as? CategoryContainerCell else {
                return UICollectionViewCell()
            }
            
            return cell.then {
                $0.delegate = self
            }
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedCategoryCell", for: indexPath) as? RecommendedCell else {
                return UICollectionViewCell()
            }
            /// Category dagi o'zgaruvchilarni recommendedCategoryCell dagi o'zgaruvchilarga tengladik.
            let category = categories[indexPath.item]
            
            return cell.then {
                $0.profileImage.image = category.image
                $0.additionalLabel.text = category.title
                $0.saleLabel.text = category.numberOfSales
                $0.timeLabel.text = category.locationAndTime
                $0.isImpact = false
            }
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "recommendedHeader", for: indexPath) as? RecommendedHeaderView else {
            return UICollectionReusableView()
        }
        return cell
    }
    /// Bu yerda recommendedCell ni ustiga bosganda yangi list ochilish uchun function qildik
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        
        let detailVC = DetailViewController().then{
            $0.category = category
            $0.categories = categories
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: CategoryContainerCellDelegate {
    func didTapShowAllCategories() {
        let categoriesPage = CategoriesViewController()
        navigationController?.pushViewController(categoriesPage, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return .init(width: collectionView.bounds.width, height: 200)
        default:
            return .init(width: 180, height: 180)
        }
    }
    
    //MARK: Header bilan recommendedCell orasidagi spacing ni control qilish
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        section == 1 ? .init(width: collectionView.bounds.width, height: 60) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0: .init(top: 0, left: 0, bottom: 5, right: 0)
        case 1: .init(top: 0, left: 13, bottom: 0, right: 13)
        default: .zero
        }
    }
    
    //MARK: Bitta section ichidagi qatorlar orasidagi minimal masofani belgilaydi
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        section == 0 ? 20 : 15
    }
}

private extension HomeViewController {
    
    func setupNavigation() {
        navigationItem.titleView = rootView.searchContainer
    }
    
    func setupDelegates() {
        rootView.mainCollectionView.delegate = self
        rootView.mainCollectionView.dataSource = self
    }
}
