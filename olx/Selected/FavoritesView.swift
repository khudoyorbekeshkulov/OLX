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
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
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
    ).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(cellType: RecommendedCell.self)
    }
    
    private let emptyLabel = UILabel().then {
        $0.text = "Нет избранных"
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
        let category = items[indexPath.item]
        
        return cell.then {
            $0.profileImage.image = category.image
            $0.additionalLabel.text = category.title
            $0.saleLabel.text = category.numberOfSales
            $0.timeLabel.text = category.locationAndTime
            $0.isImpact = false
            
            $0.setFavorite(true)
            $0.onHeartTapped = { [weak self] in
                FavoritesService.shared.toggle(category)
                self?.items = FavoritesService.shared.items
            }
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
        onItemSelected?(items[indexPath.item])
    }
}
