//  
//  HomePageViewInstaller.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 03/11/26.
//

import UIKit
import SnapKit

protocol HomePageViewInstaller: ViewInstaller {
    var searchContainer: ExpandingContainerView! { get set }
    var searchingTextField: UITextField! { get set }
    var collectionViewLayout: UICollectionViewFlowLayout! { get set }
    var mainCollectionView: UICollectionView! { get set }
}

extension HomePageViewInstaller {
    
    func initSubViews() {
        mainView.backgroundColor = ColorResourceManager.shared.appBackground
        
        searchContainer = .init().then {
            $0.backgroundColor = ColorResourceManager.shared.searchBackground
            $0.layer.cornerRadius = 8
        }
        
        searchingTextField = .init().then {
            $0.backgroundColor = ColorResourceManager.shared.searchBackground
        }
        
        collectionViewLayout = .init().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 0
        }
        
        mainCollectionView = .init(
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
    }
    
    func addSubViews() {
        searchContainer.addSubview(searchingTextField)
        mainView.addSubview(mainCollectionView)
    }
    
    func addSubViewConstraints() {
        searchContainer.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 30)
            $0.height.equalTo(36)
        }
        
        searchingTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview()
        }
        
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainView.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func willLayout() {
        
    }
    
    func didLayout() {
        
    }
    
    func localizeTexts() {
        
    }
}
