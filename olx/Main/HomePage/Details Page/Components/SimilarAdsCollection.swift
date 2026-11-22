//
//  SimilarAdsCollection.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 22/11/26.
//

import UIKit
import SnapKit

final class SimilarAdsCollection: UIView {
    
    private lazy var headerLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = L10n.Detail.similarAdvertisements
    }
    
    private lazy var layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 15
        $0.itemSize = CGSize(width: 155, height: 175)
        $0.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 0)
    }
    
    private lazy var detailCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout
    ).then {
        $0.backgroundColor = .clear
        $0.register(cellType: RecommendedCell.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SimilarAdsCollection {
    func addSubviews() {
        addSubviews([
            headerLabel,
            detailCollectionView
        ])
    }
    
    func setupConstraints() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(15)
        }
        
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(175)
            $0.bottom.equalToSuperview()
        }
    }
}
