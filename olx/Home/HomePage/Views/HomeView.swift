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
            mainCollectionView.reloadData()
        }
    }
    
    var onShowAllCategoriesTapped: (() -> Void)?
    var onCategorySelected: ((Category) -> Void)?
        
    let searchContainer = UIView().then {
        $0.backgroundColor = UIColor(named: "search_background_color")
        $0.layer.cornerRadius = 8
    }
    
    let searchingTextField = UITextField().then {
        $0.backgroundColor = UIColor(named: "search_background_color")
    }
    
    private let mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
    }
    ).then{
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .systemGray6
        
        $0.register(
            CategoryContainerCell.self,
            forCellWithReuseIdentifier: "categoryContainerCell"
        )
        
        $0.register(
            RecommendedCell.self,
            forCellWithReuseIdentifier: "recommendedCategoryCell"
        )
        
        $0.register(
            RecommendedHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "recommendedHeader"
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
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch HomeSection(rawValue: section) {
        case .categories:
            return 1
        default:
            return categories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch HomeSection(rawValue: indexPath.section) {
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryContainerCell", for: indexPath) as? CategoryContainerCell else {
                return UICollectionViewCell()
            }
            
            return cell.then {
                $0.delegate = self
            }
            
        case .products:
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
        guard indexPath.section == HomeSection.products.rawValue else { return }
            onCategorySelected?(categories[indexPath.item])
    }
}

extension HomeView: CategoryContainerCellDelegate {
    func didTapShowAllCategories() {
        onShowAllCategoriesTapped?()
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch HomeSection(rawValue: indexPath.section) {
        case .categories:
            return .init(width: collectionView.bounds.width, height: 200)
        default:
            return .init(width: 180, height: 180)
        }
    }
    
    //MARK: Header bilan recommendedCell orasidagi spacing ni control qilish
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        section == HomeSection.products.rawValue ? .init(width: collectionView.bounds.width, height: 60) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch HomeSection(rawValue: section) {
        case .categories: .init(top: 0, left: 0, bottom: 5, right: 0)
        case .products: .init(top: 0, left: 13, bottom: 0, right: 13)
        default: .zero
        }
    }
    
    //MARK: Bitta section ichidagi qatorlar orasidagi minimal masofani belgilaydi
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        section == 0 ? 20 : 15
    }
}

private extension HomeView {
    
    func setupView() {
        backgroundColor = .systemGray6
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    
    func addSubviews() {
        searchContainer.addSubview(searchingTextField)
        addSubview(mainCollectionView)
    }
    
    func setupSearchBar() {
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass")).then {
            $0.tintColor = .systemGray
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
