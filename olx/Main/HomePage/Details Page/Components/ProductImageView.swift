//
//  ImageView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 21/11/26.
//

import UIKit
import SnapKit

final class ProductImageView: UIView {
    
    private let image = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
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

extension ProductImageView {
    func configure(category: Category) {
        image.image = category.image
    }
}

private extension ProductImageView {
    
    func addSubviews() {
        addSubview(image)
    }
    
    func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(280)
        }
        
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
