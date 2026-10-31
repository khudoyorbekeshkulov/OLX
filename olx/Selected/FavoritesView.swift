//
//  FavoritesView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 24/10/26.
//

import UIKit
import SnapKit

final class FavoritesView: UIView {
    var onItemSelected: ((Category) -> Void)?
    
    private var items = [Category]() {
        didSet {
            collectionView.reloadData()
            emptyLabel.isHidden = !items.isEmpty
        }
    }
    
    private lazy var collectionLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = ProductGrid.lineSpacing
        $0.minimumInteritemSpacing = ProductGrid.interitemSpacing
        $0.sectionInset = .init(
            top: 10,
            left: ProductGrid.sideInset,
            bottom: 0,
            right: ProductGrid.sideInset
        )
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionLayout
    ).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(cellType: RecommendedCell.self)
    }
    
    private let emptyLabel = UILabel().then {
        $0.text = L10n.Favorites.notFavoritesTitle
        $0.textColor = ColorResourceManager.shared.secondaryText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItems(_ items: [Category]) {
        self.items = items
    }
}

private extension FavoritesView {
    func setupView() {
        backgroundColor = ColorResourceManager.shared.appBackground
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func addSubviews() {
        addSubviews([
            collectionView,
            emptyLabel
        ])
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension FavoritesView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(RecommendedCell.self, for: indexPath)
        guard let category = items[safe: indexPath.item] else { return cell }
        
        return cell.then {
            $0.setCategory(category: category)
            $0.isImpact = false
            
            $0.setFavorite(true)
            $0.delegate = self
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        ProductGrid.itemSize(for: collectionView.bounds.width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let category = items[safe: indexPath.item] else { return }
        onItemSelected?(category)
    }
}

extension FavoritesView: RecommendedCellProtocol {
    func onHeartTapped(category: Category) {
        FavoritesService.shared.toggle(category)
        items = FavoritesService.shared.items
    }
}
