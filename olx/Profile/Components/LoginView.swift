import UIKit
import SnapKit

final class LoginView: UIView {
    private lazy var emailLabel = UILabel().then {
        $0.text = "Электронная почта или телефон"
        $0.textColor = ColorResourceManager.shared.mainManager
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var emailTextField = UITextField().then {
        $0.placeholder = "Введите свой электронной почты..."
        $0.backgroundColor = ColorResourceManager.shared.separator
        $0.layer.cornerRadius = 5
        $0.leftViewMode = .always
        $0.setLeftPadding(12)
    }
    
    private lazy var passwordLabel = UILabel().then {
        $0.text = "Пароль"
        $0.textColor = ColorResourceManager.shared.mainManager
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.backgroundColor = ColorResourceManager.shared.separator
        $0.placeholder = "Введите свой пароль..."
        $0.layer.cornerRadius = 5
        $0.isSecureTextEntry = true
        $0.rightView = container
        $0.rightViewMode = .always
        $0.leftViewMode = .always
        $0.setLeftPadding(12)
    }
    
    private let container = UIView()
    
    private lazy var showButton = UIButton(type: .system).then {
        $0.setTitle("Показать", for: .normal)
        $0.setTitleColor(ColorResourceManager.shared.mainManager, for: .normal)
        $0.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
    }
    
    private lazy var forgetPassword = UILabel().then {
        $0.text = "Забыли пароль"
        $0.textColor = ColorResourceManager.shared.mainManager
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    private lazy var loginButton = UIButton(type: .system).then {
        $0.backgroundColor = ColorResourceManager.shared.darkMainManager
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(ColorResourceManager.shared.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.layer.cornerRadius = 5
    }
    
    private lazy var line1 = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.lineProfile
    }
    
    private lazy var textBetweenLines = UILabel().then {
        $0.text = "или"
        $0.textColor = ColorResourceManager.shared.mainManager
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private lazy var line2 = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.lineProfile
    }
    
    private lazy var appleButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "Продолжить с Apple"
        config.image = UIImage(systemName: "applelogo")
        config.imagePadding = 50
        config.baseForegroundColor = ColorResourceManager.shared.primaryText
        config.background.cornerRadius = 5
        config.attributedTitle = AttributedString("Продолжить с Apple", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 18, weight: .bold)]))
        $0.configuration = config
        $0.backgroundColor = ColorResourceManager.shared.searchBackground
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    private lazy var text = UILabel().then {
        $0.text = "При входе вы соглашаетесь с нашими"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }
    
    private lazy var text2 = UILabel().then {
        $0.text = "Условиями использования"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    private var isSecuretyEntry = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    func addSubviews() {
        addSubviews([
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            forgetPassword,
            loginButton,
            line1,
            textBetweenLines,
            line2,
            appleButton,
            text,
            text2
        ])
        
        container.addSubview(showButton)
    }
    
    func setupConstraints() {
        emailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(15)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(45)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(15)
            $0.size.equalTo(CGSize(width: 70, height: 14))
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(45)
        }
        
        container.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 80, height: 45))
        }
        
        showButton.snp.makeConstraints {
            $0.centerY.equalTo(container.snp.centerY)
            $0.trailing.equalTo(container.snp.trailing).offset(-10)
        }
        
        forgetPassword.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(15)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(forgetPassword.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(45)
        }
        
        textBetweenLines.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        line1.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalTo(textBetweenLines.snp.leading).offset(-15)
            $0.height.equalTo(1)
        }
        
        line2.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(35)
            $0.leading.equalTo(textBetweenLines.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(1)
        }
        
        appleButton.snp.makeConstraints {
            $0.top.equalTo(textBetweenLines.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(45)
        }
        
        text.snp.makeConstraints {
            $0.top.equalTo(appleButton.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        text2.snp.makeConstraints {
            $0.top.equalTo(text.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func showTapped() {
        isSecuretyEntry.toggle()
        passwordTextField.isSecureTextEntry = isSecuretyEntry
    }
    
    func setupAction() {
        showButton.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
    }
}
