//
//  HomeView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/10/26.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    let searchContainer = UIView().then {
        $0.backgroundColor = UIColor(named: "search_background_color")
        $0.layer.cornerRadius = 8
    }
    
    let searchingTextField = UITextField().then {
        $0.backgroundColor = UIColor(named: "search_background_color")
    }
    
    var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
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
        
        setupUIView()
        addSubviews()
        setupSearchBar()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeView {
    
    func setupUIView() {
        backgroundColor = .systemGray6
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
