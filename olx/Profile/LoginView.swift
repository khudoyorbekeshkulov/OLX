import UIKit

final class LoginView: UIView {
    
    private let mainColor = UIColor(red: 0/255, green: 47/255, blue: 52/255, alpha: 1.0)
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let container = UIView()
    private let showButton = UIButton(type: .system)
    private let forgetPassword = UILabel()
    private let loginButton = UIButton(type: .system)
    private let line1 = UIView()
    private let or = UILabel()
    private let line2 = UIView()
    private let appleButton = UIButton()
    private let text = UILabel()
    private let text2 = UILabel()
    
    private var isSecuretyEntry = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupAction()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showTapped() {
        isSecuretyEntry.toggle()
        passwordTextField.isSecureTextEntry = isSecuretyEntry
    }
}

private extension LoginView {
    func setupUI() {
        
        addSubview(emailLabel)
        emailLabel.text = "Электронная почта или телефон"
        emailLabel.textColor = mainColor
        emailLabel.font = UIFont.systemFont(ofSize: 12)
        
        addSubview(emailTextField)
        emailTextField.backgroundColor = .systemGray6
        emailTextField.layer.cornerRadius = 5
        emailTextField.placeholder = "Введите свой электронной почты..."

        addSubview(passwordLabel)
        passwordLabel.text = "Пароль"
        passwordLabel.textColor = mainColor
        passwordLabel.font = UIFont.systemFont(ofSize: 12)

        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.placeholder = "Введите свой пароль..."
        
        container.addSubview(showButton)
        
        showButton.setTitle("Показать", for: .normal)
        showButton.setTitleColor(mainColor, for: .normal)
        
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = container
        passwordTextField.rightViewMode = .always
        
        addSubview(forgetPassword)
        forgetPassword.text = "Забыли пароль"
        forgetPassword.textColor = mainColor
        forgetPassword.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        addSubview(loginButton)
        loginButton.backgroundColor = .systemGray6
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        loginButton.backgroundColor = mainColor
        loginButton.layer.cornerRadius = 5
 
        addSubview(line1)
        line1.backgroundColor = .systemGray3

        addSubview(or)
        or.text = "или"
        or.textColor = mainColor
        or.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        addSubview(line2)
        line2.backgroundColor = .systemGray3
        
        var config = UIButton.Configuration.plain()
        config.title = "Продолжить с Apple"
        config.image = UIImage(systemName: "applelogo")
        config.imagePadding = 50
        config.baseForegroundColor = .black
        config.background.cornerRadius = 5
        config.attributedTitle = AttributedString("Продолжить с Apple", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 18, weight: .bold)]))
        appleButton.configuration = config
        addSubview(appleButton)
        appleButton.backgroundColor = .white
        appleButton.layer.borderWidth = 1
        appleButton.layer.borderColor = UIColor.black.cgColor

        addSubview(text)
        text.text = "При входе вы соглашаетесь с нашими"
        text.font = UIFont.systemFont(ofSize: 12, weight: .medium)
  
        addSubview(text2)
        text2.text = "Условиями использования"
        text2.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    func setupConstraints() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        showButton.translatesAutoresizingMaskIntoConstraints = false
        forgetPassword.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        line1.translatesAutoresizingMaskIntoConstraints = false
        or.translatesAutoresizingMaskIntoConstraints = false
        line2.translatesAutoresizingMaskIntoConstraints = false
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        text2.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    func setupAction() {
        
        showButton.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
    }
}
