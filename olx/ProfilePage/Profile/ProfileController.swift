//  
//  ProfileController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 04/11/26.
//

import UIKit

class ProfileController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: ProfilePresenter!
    var titleLabel: UILabel!
    var segmentedControl: UIView!
    var authStackView: UIStackView!
    var loginButton: UIButton!
    var registerButton: UIButton!
    var loginView: LoginView!
    var registerView: RegisterView!
    // swiftlint:enable implicitly_unwrapped_optional
    private init(with configurator: ProfileConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UIViewController Lifecycle
extension ProfileController: ProfileViewInstaller {
    
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installSubviews()
        presenter.viewDidLoad()
        bindActions()
    }
}

// MARK: View Protocol Conformation
extension ProfileController:  ProfileViewMVP {
    func updateSegment(isLogin: Bool, animated: Bool) {
        DispatchQueue.main.async {
            self.setSegment(login: isLogin, animated: animated)
        }
    }
}

// MARK: Static Initializer
extension ProfileController {
    static func instantiate() -> ProfileController {
        let configurator = ProfileConfiguratorImpl()
        let vc = ProfileController(with: configurator)
        return vc
    }
}

private extension ProfileController {
    func bindActions() {
        loginButton.addAction(UIAction { [weak self] _ in
            self?.presenter.didTapSegment(isLogin: true)
        }, for: .touchUpInside)
        
        registerButton.addAction(UIAction { [weak self] _ in
            self?.presenter.didTapSegment(isLogin: false)
        }, for: .touchUpInside)
        
        loginView.onLoginTapped = { [weak self] email, password in
            self?.presenter.didTapLogin(email: email, password: password)
        }
        
        registerView.onRegisterTapped = { [weak self] email, password, isAgreed in
            self?.presenter.didTapRegister(email: email, password: password, isAgreed: isAgreed)
        }
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(tappedToView)
            )
        )
    }
    
    @objc func tappedToView() {
        view.endEditing(true)
    }
    
    func setSegment(login isLogin: Bool, animated: Bool) {
        UIView.animate(withDuration: animated ? 0.2 : 0) {
            self.styleSegmentButton(self.loginButton, isSelected: isLogin)
            self.styleSegmentButton(self.registerButton, isSelected: !isLogin)
        }

        loginView.isHidden = !isLogin
        registerView.isHidden = isLogin
    }

    func styleSegmentButton(_ button: UIButton, isSelected: Bool) {
        let colors = ColorResourceManager.shared
        button.backgroundColor = isSelected ? colors.white : .clear
        button.setTitleColor(isSelected ? colors.black : colors.secondaryText, for: .normal)
    }
}
