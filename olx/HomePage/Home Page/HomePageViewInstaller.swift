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
    var mainCollectionView: UICollectionView! { get set }
}

private enum Constants {
    static let fieldLeftsideIcon = UIImage(systemName: "magnifyingglass")
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
        
        mainCollectionView = .init(
            frame: .zero,
            collectionViewLayout: collectionLayout()
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
        
        setupSearchBar()
    }
    
    func addSubViews() {
        mainView.addSubview(searchContainer)
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
}

private extension HomePageViewInstaller {
    func setupView() {
        mainView.backgroundColor = ColorResourceManager.shared.appBackground
    }
    
    func setupSearchBar() {
        let icon = UIImageView(image: Constants.fieldLeftsideIcon).then {
            $0.tintColor = ColorResourceManager.shared.magnifyingGlass
            $0.frame = CGRect(x: 12, y: 8, width: 24, height: 20)
        }
        
        let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 36)).then {
            $0.addSubview(icon)
        }
        
        searchingTextField.then {
            $0.placeholder = L10n.Overall.searchPlaceholder
            $0.leftView = leftContainer
            $0.leftViewMode = .always
        }
    }
    
    func collectionLayout() -> UICollectionViewLayout {
        UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 0
        }
    }
}
