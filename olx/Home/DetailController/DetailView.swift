//
//  DetailView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 15/10/26.
//

import UIKit
import SnapKit

final class DetailView: UIView {
    
    private var categories: [Category] = []
    
    var onProductOwnerTapped: (() -> Void)?
    var onCategorySelected: ((Category) -> Void)?
    
    private lazy var image = UIImageView().then {
        $0.clipsToBounds = true
    }
    
    private lazy var infoFrame = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.cardBackground
    }
    
    private lazy var postedTime = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = ColorResourceManager.shared.secondaryText
    }
    
    private lazy var nameProduct = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
    }
    
    private lazy var saleProduct = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    private lazy var infoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.text = "Описание"
    }
    
    private lazy var infoProduct = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 3
    }
    
    private lazy var productOwner = UILabel().then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProductOwnerTap)))
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var onlineTime = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = ColorResourceManager.shared.secondaryText
    }
    
    private lazy var feedbackButton = UIButton(type: .system).then {
        $0.setTitle("Оставить отзыв", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        $0.setTitleColor(ColorResourceManager.shared.mainManager, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    private lazy var adsLabelFrame = UILabel().then {
        $0.attributedText = NSAttributedString(
            string: "Все объявления автора",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 13, weight: .medium),
                .foregroundColor: ColorResourceManager.shared.mainManager
            ]
        )
    }
        
    private lazy var headerLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "Похожие объявления"
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
        $0.delegate = self
        $0.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailView {
    func configure(category: Category) {
        image.image = category.image
        postedTime.text = category.locationAndTime
        nameProduct.text = category.title
        saleProduct.text = category.numberOfSales
        infoProduct.text = category.infoProduct
        productOwner.text = category.productOwner
        onlineTime.text = category.online
    }
    
    func configureCategories(categories: [Category]) {
        self.categories = categories
    }
}

extension DetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueCell(RecommendedCell.self, for: indexPath)
        guard let category = categories[safe: indexPath.item] else { return cell }
        
        return cell.then {
            $0.profileImage.image = category.image
            $0.additionalLabel.text = category.title
            $0.timeLabel.text = category.locationAndTime
            $0.saleLabel.text = category.numberOfSales
            $0.isImpact = true
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        onCategorySelected?(categories[indexPath.item])
    }
}

private extension DetailView {
    func setupUI() {
        backgroundColor = ColorResourceManager.shared.appBackground
    }
    
    func addSubviews() {
        addSubviews([
            image,
            infoFrame,
            headerLabel,
            detailCollectionView
        ])
        
        infoFrame.addSubviews([
            postedTime,
            nameProduct,
            saleProduct,
            infoLabel,
            infoProduct,
            productOwner,
            onlineTime,
            feedbackButton,
            adsLabelFrame
        ])
    }
    
    func setupConstraints() {
        image.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(280)
        }
        
        infoFrame.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(280)
        }
        
        postedTime.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(15)
        }
        
        nameProduct.snp.makeConstraints {
            $0.top.equalTo(postedTime.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().offset(15)
        }
        
        saleProduct.snp.makeConstraints {
            $0.top.equalTo(nameProduct.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().offset(15)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(saleProduct.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
        }
        
        infoProduct.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().offset(15)
        }
        
        productOwner.snp.makeConstraints {
            $0.top.equalTo(infoProduct.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().offset(15)
        }
        
        onlineTime.snp.makeConstraints {
            $0.top.equalTo(productOwner.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(15)
        }
        
        feedbackButton.snp.makeConstraints {
            $0.top.equalTo(onlineTime.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.size.equalTo(CGSize(width: 160, height: 40))
        }
        
        adsLabelFrame.snp.makeConstraints {
            $0.top.equalTo(onlineTime.snp.bottom).offset(15)
            $0.leading.equalTo(feedbackButton.snp.trailing).offset(10)
            $0.size.equalTo(CGSize(width: 160, height: 40))
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(infoFrame.snp.bottom).offset(20)
            $0.leading.equalTo(infoFrame.snp.leading).offset(15)
        }
        
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(175)
        }
    }
    
    @objc func handleProductOwnerTap() {
        onProductOwnerTapped?()
    }
}
