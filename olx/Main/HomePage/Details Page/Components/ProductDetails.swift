//
//  ProductDetails.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 21/11/26.
//

import UIKit
import SnapKit

final class ProductDetails: UIView {
    
    private let postedTimeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = ColorResourceManager.shared.secondaryText
    }
    private let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
    }
    private let priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    private let descriptionTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.text = L10n.Overall.description
    }
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductDetails {
    func configure(category: Category) {
        postedTimeLabel.text = category.locationAndTime
        nameLabel.text = category.title
        priceLabel.text = category.priceNumbers
        descriptionLabel.text = category.descriptionProduct
    }
}

private extension ProductDetails {
    func addSubviews() {
        addSubviews([
            postedTimeLabel,
            nameLabel,
            priceLabel,
            descriptionTitleLabel,
            descriptionLabel,
        ])
    }
    
    func setupConstraints() {
        postedTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(15)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(postedTimeLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().offset(15)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().offset(15)
        }
        
        descriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview()
        }
    }
}
