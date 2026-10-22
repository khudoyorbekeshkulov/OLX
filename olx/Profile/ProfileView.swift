//
//  ProfileView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/10/26.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    let loginView = LoginView()
    
    let registerView = RegisterView().then {
        $0.isHidden = true
    }
    
    let titleLabel = UILabel().then {
        $0.text = "Создать"
        $0.textColor = ColorResourceManager.shared.mainManager
        $0.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    var segmentedControl = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.separator
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    var authStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIViews()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileView {
    
    func setupUIViews() {
        backgroundColor = ColorResourceManager.shared.profileBackground
    }
    
    func addSubviews() {
        addSubviews([
            titleLabel,
            segmentedControl,
            loginView,
            registerView
        ])
        
        segmentedControl.addSubview(authStackView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(70)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.height.equalTo(32)
        }
        
        loginView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
        }
        
        registerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
        }
        
        authStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
        }
    }
}
