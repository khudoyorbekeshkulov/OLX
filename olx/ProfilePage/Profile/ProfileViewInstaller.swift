//  
//  ProfileViewInstaller.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 04/11/26.
//

import UIKit
import SnapKit

protocol ProfileViewInstaller: ViewInstaller {
    var titleLabel: UILabel! { get set }
    var segmentedControl: UIView! { get set }
    var authStackView: UIStackView! { get set }
    var loginButton: UIButton! { get set }
    var registerButton: UIButton! { get set }
    var loginView: LoginView! { get set }
    var registerView: RegisterView! { get set }
}

extension ProfileViewInstaller {
    
    func initSubViews() {
        mainView.backgroundColor = ColorResourceManager.shared.appBackground
        
        titleLabel = .init().then {
            $0.text = L10n.Overall.create
            $0.textColor = ColorResourceManager.shared.mainManager
            $0.font = .systemFont(ofSize: 28, weight: .bold)
        }
        
        loginView = .init()
        registerView = RegisterView().then {
            $0.isHidden = true
        }
        
        segmentedControl = .init().then {
            $0.backgroundColor = ColorResourceManager.shared.separator
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
        }
        
        authStackView = .init().then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.alignment = .fill
        }
        
        loginButton =  makeSegmentButton(
            title: L10n.Overall.logIn,
        )
        
        registerButton =  makeSegmentButton(
            title: L10n.Overall.register,
        )
    }
    
    func addSubViews() {
        mainView.addSubviews([
            titleLabel,
            segmentedControl,
            loginView,
            registerView
        ])
        
        segmentedControl.addSubview(authStackView)
        authStackView.addArrangedSubviews([
            loginButton,
            registerButton
        ])
    }
    
    func addSubViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mainView.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(16)
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

private extension ProfileViewInstaller {
    func makeSegmentButton(title: String) -> UIButton {
        UIButton(type: .system).then {
            $0.setTitle(title, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.layer.cornerRadius = 5
        }
    }
}
