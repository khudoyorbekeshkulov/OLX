import UIKit

final class RegisterView: UIView {
    
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
        $0.layer.cornerRadius = 5
        $0.placeholder = "Введите свой пароль..."
        $0.rightView = container
        $0.rightViewMode = .always
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var container = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var showButton = UIButton(type: .system).then {
        $0.setTitle("Показать", for: .normal)
        $0.setTitleColor(ColorResourceManager.shared.mainColor, for: .normal)
        $0.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var text = UILabel().then {
        $0.text = "Пароль дольжен содержать минимум 6 симболов. Чтобы пароль получился супернадежными, добавьте заглавные и строчные буквы, цыфры и специальные символы"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var text2 = UILabel().then {
        $0.text = "Я соглащаюсь с правилами использования сервиса, а также с передачей и обработкой моих данных в OLX. Я подверждаю свое совершеннолетие и отвественность за размещение объявления "
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var checkBox = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "square"), for: .normal)
        $0.tintColor = ColorResourceManager.shared.mainColor
        $0.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var registerButton = UIButton(type: .system).then {
        $0.backgroundColor = .systemGray6
        $0.setTitle("Зарегистроваться", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.backgroundColor = ColorResourceManager.shared.mainColor
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private var isChecked = false
    private var isSecuretyEntry = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RegisterView {
    
    func addSubviews() {
        addSubview(appleButton)
        addSubview(line1)
        addSubview(or)
        addSubview(line2)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        container.addSubview(showButton)
        addSubview(text)
        addSubview(checkBox)
        addSubview(text2)
        addSubview(registerButton)
    }
    
    func setupConstraints() {
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
