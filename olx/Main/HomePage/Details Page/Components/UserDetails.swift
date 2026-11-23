//
//  UserDetails.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 21/11/26.
//

import UIKit
import SnapKit

final class UserDetails: UIView {
    
    var onOwnerTapped: (() -> Void)?
    
    private let phoneNumber = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    private let userName = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOwnerTap)))
    }
    private let onlineTime = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = ColorResourceManager.shared.secondaryText
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

extension UserDetails {
    func configure(category: Category) {
        phoneNumber.text = category.phoneNumber
        userName.text = category.contactName
        onlineTime.text = category.online
    }
}

private extension UserDetails {
    
    func addSubviews() {
        addSubviews([
            phoneNumber,
            userName,
            onlineTime
        ])
    }
    
    func setupConstraints() {
        phoneNumber.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview().offset(15)
        }
        
        userName.snp.makeConstraints {
            $0.top.equalTo(phoneNumber.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().offset(15)
        }
        
        onlineTime.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func handleOwnerTap() {
        onOwnerTapped?()
    }
}
