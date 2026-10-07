import UIKit

final class LoginView: UIView {
    
    private lazy var emailLabel = UILabel().then {
        $0.text = "Электронная почта или телефон"
        $0.textColor = ColorResourceManager.shared.mainColor
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var emailTextField = UITextField().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 5
        $0.placeholder = "Введите свой электронной почты..."
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var passwordLabel = UILabel().then {
        $0.text = "Пароль"
        $0.textColor = ColorResourceManager.shared.mainColor
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.backgroundColor = .systemGray6
        $0.placeholder = "Введите свой пароль..."
        $0.layer.cornerRadius = 5
        $0.isSecureTextEntry = true
        $0.rightView = container
        $0.rightViewMode = .always
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let container = UIView()
    
    private lazy var showButton = UIButton(type: .system).then {
        $0.setTitle("Показать", for: .normal)
        $0.setTitleColor(ColorResourceManager.shared.mainColor, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var forgetPassword = UILabel().then {
        $0.text = "Забыли пароль"
        $0.textColor = ColorResourceManager.shared.mainColor
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var loginButton = UIButton(type: .system).then {
        $0.backgroundColor = .systemGray6
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.backgroundColor = ColorResourceManager.shared.mainColor
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var line1 = UIView().then {
        $0.backgroundColor = .systemGray3
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var or = UILabel().then {
        $0.text = "или"
        $0.textColor = ColorResourceManager.shared.mainColor
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var line2 = UIView().then {
        $0.backgroundColor = .systemGray3
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var appleButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "Продолжить с Apple"
        config.image = UIImage(systemName: "applelogo")
        config.imagePadding = 50
        config.baseForegroundColor = .black
        config.background.cornerRadius = 5
        config.attributedTitle = AttributedString("Продолжить с Apple", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 18, weight: .bold)]))
        $0.configuration = config
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var text = UILabel().then {
        $0.text = "При входе вы соглашаетесь с нашими"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var text2 = UILabel().then {
        $0.text = "Условиями использования"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        container.addSubview(showButton)
        addSubview(forgetPassword)
        addSubview(loginButton)
        addSubview(line1)
        addSubview(or)
        addSubview(line2)
        addSubview(appleButton)
        addSubview(text)
        addSubview(text2)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            emailLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordLabel.widthAnchor.constraint(equalToConstant: 70),
            passwordLabel.heightAnchor.constraint(equalToConstant: 14),
            
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            container.heightAnchor.constraint(equalToConstant: 45),
            container.widthAnchor.constraint(equalToConstant: 80),
            
            showButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            showButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            forgetPassword.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            forgetPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            loginButton.topAnchor.constraint(equalTo: forgetPassword.bottomAnchor, constant: 10),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            
            line1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            line1.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 35),
            line1.trailingAnchor.constraint(equalTo: or.leadingAnchor, constant: -15),
            line1.heightAnchor.constraint(equalToConstant: 1),
            
            or.centerXAnchor.constraint(equalTo: centerXAnchor),
            or.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 25),
            
            line2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            line2.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 35),
            line2.leadingAnchor.constraint(equalTo: or.trailingAnchor, constant: 15),
            line2.heightAnchor.constraint(equalToConstant: 1),
            
            appleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            appleButton.topAnchor.constraint(equalTo: or.bottomAnchor, constant: 30),
            appleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            appleButton.heightAnchor.constraint(equalToConstant: 45),
            
            text.centerXAnchor.constraint(equalTo: centerXAnchor),
            text.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 25),
            
            text2.centerXAnchor.constraint(equalTo: centerXAnchor),
            text2.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 5)
        ])
    }
    
    @objc func showTapped() {
        isSecuretyEntry.toggle()
        passwordTextField.isSecureTextEntry = isSecuretyEntry
    }
    
    func setupAction() {
        
        showButton.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
    }
}
