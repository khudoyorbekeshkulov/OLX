//
//  ProfileView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/10/26.
//

import UIKit
import SnapKit

enum Segment {
    case login
    case register
}

final class ProfileView: UIView {
    
    private let loginView = LoginView()
    
    private let registerView = RegisterView().then {
        $0.isHidden = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "Создать"
        $0.textColor = ColorResourceManager.shared.mainManager
        $0.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    private var segmentedControl = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.separator
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private let authStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private lazy var loginButton =  makeSegmentButton(
        title: "Войти",
        action: #selector(loginTapped)
    )
    
    private lazy var registerButton =  makeSegmentButton(
        title: "Зарегистрироваться",
        action: #selector(registerTapped)
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSegment(.login, animated: false)
        setupUIViews()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView {
    func setSegment(_ segment: Segment, animated: Bool = true) {
        let isLogin = segment == .login
        
        let updateButtons = {
            self.loginButton.backgroundColor = isLogin ? ColorResourceManager.shared.white : .clear
            self.loginButton.setTitleColor(
                isLogin ? ColorResourceManager.shared.black : ColorResourceManager.shared.secondaryText,
                for: .normal
            )
            
            self.registerButton.backgroundColor = isLogin ? .clear : ColorResourceManager.shared.white
            self.registerButton.setTitleColor(
                isLogin ? ColorResourceManager.shared.secondaryText : ColorResourceManager.shared.black,
                for: .normal
            )
            
        }
        
        UIView.animate(withDuration: animated ? 0.2 : 0, animations: updateButtons)
        
        loginView.isHidden = !isLogin
        registerView.isHidden = isLogin
    }
}

private extension ProfileView {
    
    func makeSegmentButton(title: String, action: Selector) -> UIButton {
        UIButton(type: .system).then {
            $0.setTitle(title, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.layer.cornerRadius = 5
            $0.addTarget(self, action: action, for: .touchUpInside)
        }
    }
    
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
        authStackView.addArrangedSubviews([
            loginButton,
            registerButton
        ])
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
    
    @objc func loginTapped() {
        setSegment(.login)
    }
    
    @objc func registerTapped() {
        setSegment(.register)
    }
}
