//
//  HomeView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/10/26.
//

import UIKit
import SnapKit

private enum HomeSection: Int, CaseIterable {
    case categories
    case products
}

final class HomeView: UIView {
    
    private var categories = [Category]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                mainCollectionView.reloadData()
            }
        }
    }
    
    var onShowAllCategoriesTapped: (() -> Void)?
    var onCategorySelected: ((Category) -> Void)?
    
    let searchContainer = ExpandingContainerView().then {
        $0.backgroundColor = ColorResourceManager.shared.searchBackground
        $0.layer.cornerRadius = 8
    }
    
    let searchingTextField = UITextField().then {
        $0.backgroundColor = ColorResourceManager.shared.searchBackground
    }
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
    }
    
    private lazy var mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        
        $0.register(cellType: CategoryContainerCell.self)
        $0.register(cellType: RecommendedCell.self)
        
        $0.register(
            supplementaryViewType: RecommendedHeaderView.self,
            ofKind: UICollectionView.elementKindSectionHeader
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupSearchBar()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCategories(categories: [Category]) {
        self.categories = categories
    }
    
    func reloadProducts() {
        mainCollectionView.reloadSections(IndexSet(integer: HomeSection.products.rawValue))
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
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
            return categories.count
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
            
            guard let category = categories[safe: indexPath.item] else { return cell }
            
            return cell.then {
                $0.setCategory(category: category)
                $0.isImpact = false
                
                $0.setFavorite(FavoritesService.shared.contains(category))
                //                $0.onHeartTapped = { [weak cell] in
                //                    FavoritesService.shared.toggle(category)
                //                    cell?.setFavorite(FavoritesService.shared.contains(category))
                //                }
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
        guard let category = categories[safe: indexPath.item] else { return }
        onCategorySelected?(category)
    }
}

extension HomeView: CategoryContainerCellDelegate {
    func didTapShowAllCategories() {
        onShowAllCategoriesTapped?()
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
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
        case .categories: .init(top: 0, left: 0, bottom: 5, right: 0)
        case .products: .init(top: 0, left: ProductGrid.sideInset, bottom: 0, right: ProductGrid.sideInset)
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

private extension HomeView {
    
    func setupView() {
        backgroundColor = ColorResourceManager.shared.appBackground
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    
    func addSubviews() {
        searchContainer.addSubview(searchingTextField)
        addSubview(mainCollectionView)
    }
    
    func setupSearchBar() {
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass")).then {
            $0.tintColor = ColorResourceManager.shared.magnifyingGlass
            $0.frame = CGRect(x: 12, y: 8, width: 23, height: 20)
        }
        
        let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 36)).then {
            $0.addSubview(icon)
        }
        
        searchingTextField.then {
            $0.placeholder = "Поиск"
            $0.leftView = leftContainer
            $0.leftViewMode = .always
        }
    }
    
    func setupConstraints() {
        searchContainer.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 30)
            $0.height.equalTo(36)
        }
        
        searchingTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview()
        }
        
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

final class ExpandingContainerView: UIView {
    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }
}
