//
//  Details PageViewInstaller.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import UIKit
import SnapKit

protocol DetailViewInstaller: ViewInstaller {
    var image: ProductImageView! { get set }
    var infoFrame: UIView! { get set }
    var productDetails: ProductDetails! { get set }
    var userDetails: UserDetails! { get set }
    var authorActions: AuthorActions! { get set }
    var headerLabel: UILabel! { get set }
    var layout: UICollectionViewFlowLayout! { get set }
    var detailCollectionView: UICollectionView! { get set }
}

extension DetailViewInstaller {
    
    func initSubViews() {
        mainView.backgroundColor = ColorResourceManager.shared.appBackground
        
        image = .init()
        
        infoFrame = .init().then {
            $0.backgroundColor = ColorResourceManager.shared.cardBackground
        }
        
        productDetails = .init()
        
        userDetails = .init()
        
        authorActions = .init()
    
        headerLabel = .init().then {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.text = L10n.Detail.similarAdvertisements
        }
        
        layout = .init().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 15
            $0.itemSize = CGSize(width: 155, height: 175)
            $0.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 0)
        }
        
        detailCollectionView = .init(
            frame: .zero,
            collectionViewLayout: layout
        ).then {
            $0.backgroundColor = .clear
        }
    }
    
    func addSubViews() {
        mainView.addSubviews([
            image,
            infoFrame,
            headerLabel,
            detailCollectionView
        ])
        
        infoFrame.addSubviews([
            productDetails,
            userDetails,
            authorActions,
        ])
    }
    
    func addSubViewConstraints() {
        image.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        infoFrame.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(authorActions.snp.bottom).offset(10)
        }
        
        productDetails.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        userDetails.snp.makeConstraints {
            $0.top.equalTo(productDetails.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        authorActions.snp.makeConstraints {
            $0.top.equalTo(userDetails.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(infoFrame.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(15)
        }
        
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(175)
        }
    }
}
