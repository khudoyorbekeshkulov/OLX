import UIKit

final class RegisterView: UIView {
    private let mainColor = UIColor(red: 0/255, green: 47/255, blue: 52/255, alpha: 1.0)
    private let appleButton = UIButton()
    private let line1 = UIView()
    private let or = UILabel()
    private let line2 = UIView()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let container = UIView()
    private let showButton = UIButton(type: .system)
    private let text = UILabel()
    private let text2 = UILabel()
    private let checkBox = UIButton(type: .system)
    private var isChecked = false
    private let registerButton = UIButton(type: .system)
    private var isSecuretyEntry = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showTapped() {
        isSecuretyEntry.toggle()
        passwordTextField.isSecureTextEntry = isSecuretyEntry
    }
    
    @objc func checkBoxTapped() {
        isChecked.toggle()
        
        let imageName = isChecked ? "checkmark.square.fill" : "square"
        checkBox.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

private extension RegisterView {
    func setupUI() {
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
        
        addSubview(line1)
        line1.backgroundColor = .systemGray3
        
        addSubview(or)
        or.text = "или"
        or.textColor = mainColor
        or.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        addSubview(line2)
        line2.backgroundColor = .systemGray3
        
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
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.placeholder = "Введите свой пароль..."
        
        container.addSubview(showButton)
        
        showButton.setTitle("Показать", for: .normal)
        showButton.setTitleColor(mainColor, for: .normal)
        showButton.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
        
        passwordTextField.rightView = container
        passwordTextField.rightViewMode = .always
        
        addSubview(text)
        text.text = "Пароль дольжен содержать минимум 6 симболов. Чтобы пароль получился супернадежными, добавьте заглавные и строчные буквы, цыфры и специальные символы"
        text.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        
        addSubview(checkBox)
        checkBox.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox.tintColor = mainColor
        checkBox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        
        addSubview(text2)
        text2.text = "Я соглащаюсь с правилами использования сервиса, а также с передачей и обработкой моих данных в OLX. Я подверждаю свое совершеннолетие и отвественность за размещение объявления "
        text2.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        text2.numberOfLines = 0
        text2.lineBreakMode = .byWordWrapping
        
        addSubview(registerButton)
        registerButton.backgroundColor = .systemGray6
        registerButton.setTitle("Зарегистроваться", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        registerButton.backgroundColor = mainColor
        registerButton.layer.cornerRadius = 5
    }
    
    func setupConstraints() {
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        line1.translatesAutoresizingMaskIntoConstraints = false
        or.translatesAutoresizingMaskIntoConstraints = false
        line2.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        showButton.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        text2.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            appleButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            appleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            appleButton.heightAnchor.constraint(equalToConstant: 45),
            
            or.centerXAnchor.constraint(equalTo: centerXAnchor),
            or.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 25),
            
            line1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            line1.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 35),
            line1.trailingAnchor.constraint(equalTo: or.leadingAnchor, constant: -15),
            line1.heightAnchor.constraint(equalToConstant: 1),
            
            line2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            line2.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 35),
            line2.leadingAnchor.constraint(equalTo: or.trailingAnchor, constant: 15),
            line2.heightAnchor.constraint(equalToConstant: 1),
            
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            emailLabel.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 35),
            
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
            
            text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            text.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            checkBox.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 20),
            checkBox.widthAnchor.constraint(equalToConstant: 24),
            checkBox.heightAnchor.constraint(equalToConstant: 24),
            
            text2.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 15),
            text2.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 20),
            text2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            registerButton.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            registerButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
