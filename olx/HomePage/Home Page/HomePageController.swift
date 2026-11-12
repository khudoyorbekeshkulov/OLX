//  
//  HomePageController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 03/11/26.
//

import UIKit

private enum HomeSection: Int, CaseIterable {
    case categories
    case products
}

class HomePageController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: HomePagePresenter!
    
    var searchContainer: ExpandingContainerView!
    var searchingTextField: UITextField!
    var mainCollectionView: UICollectionView!
    
    func reloadProducts() {
        mainCollectionView.reloadSections(IndexSet(integer: HomeSection.products.rawValue))
    }
    // swiftlint:enable implicitly_unwrapped_optional
    private init(with configurator: HomePageConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UIViewController Lifecycle
extension HomePageController: HomePageViewInstaller {
    
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        installSubviews()
        setupViewController()
        presenter.viewDidLoad()
    }
    
}

// MARK: View Protocol Conformation
extension HomePageController: HomePageView {
    func setupCategories(categories: [Category]) {
        DispatchQueue.main.async { [weak self] in
        guard let self else { return }
        mainCollectionView.reloadData()
        }
    }
}

// MARK: Static Initializer
extension HomePageController {
    static func instantiate() -> HomePageController {
        let configurator = HomePageConfiguratorImpl()
        let vc = HomePageController(with: configurator)
        return vc
    }
}

private extension HomePageController {
    func setupViewController() {
        navigationItem.titleView = searchContainer
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
}

extension HomePageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        HomeSection.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch HomeSection(rawValue: section) {
        case .categories:
            return 1
        default:
            return presenter.numberOfProducts
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch HomeSection(rawValue: indexPath.section) {
        case .categories:
            let cell = collectionView.dequeueCell(
                CategoryContainerCell.self,
                for: indexPath
            )
            
            return cell.then {
                $0.delegate = self
            }
            
        case .products:
            let cell = collectionView.dequeueCell(
                RecommendedCell.self,
                for: indexPath
            )
            
            guard let category = presenter.product(at: indexPath.item) else { return cell }
            
            return cell.then {
                $0.setCategory(category: category)
                $0.isImpact = false
                
                $0.setFavorite(presenter.isFavorite(category))
                $0.heartTapped = { [weak self, weak cell] in
                    guard let self, let cell else { return }
                    self.presenter.toggleFavorite(category)
                    cell.setFavorite(self.presenter.isFavorite(category))
                }
            }
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header = collectionView.dequeueSupplementaryView(
            RecommendedHeaderView.self,
            ofKind: kind,
            for: indexPath
        )
        return header
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard indexPath.section == HomeSection.products.rawValue else { return }
        guard let category = presenter.product(at: indexPath.item) else { return }
        presenter.openDetails(category: category)
    }
}

extension HomePageController: CategoryContainerCellDelegate {
    func didTapShowAllCategories() {
        presenter.openAllCategories()
    }
}

extension HomePageController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        switch HomeSection(rawValue: indexPath.section) {
        case .categories:
            return .init(
                width: collectionView.bounds.width,
                height: CategoryContainerCell.height(for: collectionView.bounds.width)
            )
        default:
            return ProductGrid.itemSize(for: collectionView.bounds.width)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        section == HomeSection.products.rawValue ? .init(width: collectionView.bounds.width, height: 60) : .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        switch HomeSection(rawValue: section) {
        case .categories: .init(
            top: 0,
            left: 0,
            bottom: 5,
            right: 0
        )
        case .products: .init(
            top: 0,
            left: ProductGrid.sideInset,
            bottom: 0,
            right: ProductGrid.sideInset
        )
        default: .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        section == HomeSection.categories.rawValue ? 20 : ProductGrid.lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        ProductGrid.interitemSpacing
    }
}
