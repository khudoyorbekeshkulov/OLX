import UIKit
import SnapKit

final class RegisterView: UIView {
    private var isChecked = false
    private var isSecuretyEntry = true
    
    private lazy var appleButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "Продолжить с Apple"
        config.image = UIImage(systemName: "applelogo")
        config.imagePadding = 25
        config.baseForegroundColor = ColorResourceManager.shared.primaryText
        config.background.cornerRadius = 5
        config.attributedTitle = AttributedString("Продолжить с Apple", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 18, weight: .bold)]))
        $0.configuration = config
        $0.backgroundColor = ColorResourceManager.shared.searchBackground
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    private lazy var line1 = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.lineProfile
    }
    
    private lazy var or = UILabel().then {
        $0.text = "или"
        $0.textColor = ColorResourceManager.shared.mainManager
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private lazy var line2 = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.lineProfile
    }
    
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
        $0.placeholder = "Введите свой пароль..."
        $0.backgroundColor = ColorResourceManager.shared.separator
        $0.layer.cornerRadius = 5
        $0.rightView = container
        $0.rightViewMode = .always
        $0.leftViewMode = .always
        $0.setLeftPadding(12)
    }
    
    private lazy var container = UIView()
    
    private lazy var showButton = UIButton(type: .system).then {
        $0.setTitle("Показать", for: .normal)
        $0.setTitleColor(ColorResourceManager.shared.mainManager, for: .normal)
        $0.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
    }
    
    private lazy var text = UILabel().then {
        $0.text = "Пароль дольжен содержать минимум 6 симболов. Чтобы пароль получился супернадежными, добавьте заглавные и строчные буквы, цыфры и специальные символы"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private lazy var text2 = UILabel().then {
        $0.text = "Я соглащаюсь с правилами использования сервиса, а также с передачей и обработкой моих данных в OLX. Я подверждаю свое совершеннолетие и отвественность за размещение объявления "
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var checkBox = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "square"), for: .normal)
        $0.tintColor = ColorResourceManager.shared.mainManager
        $0.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
    }
    
    private lazy var registerButton = UIButton(type: .system).then {
        $0.backgroundColor = ColorResourceManager.shared.darkMainManager
        $0.setTitle("Зарегистроваться", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.layer.cornerRadius = 5
    }
    
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

private extension RegisterView {
    
    func addSubviews() {
        addSubviews([
            appleButton,
            line1,
            or,
            line2,
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            text,
            checkBox,
            text2,
            registerButton
        ])
        
        container.addSubview(showButton)
    }
    
    func setupConstraints() {
        appleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(45)
        }
        
        or.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(appleButton.snp.bottom).offset(25)
        }
        
        line1.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(appleButton.snp.bottom).offset(35)
            $0.height.equalTo(1)
        }
        
        line2.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(appleButton.snp.bottom).offset(35)
            $0.height.equalTo(1)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(line1.snp.bottom).offset(35)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.height.equalTo(45)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.width.equalTo(70)
            $0.height.equalTo(14)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.height.equalTo(45)
        }
        
        container.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.width.equalTo(80)
        }
        
        showButton.snp.makeConstraints {
            $0.centerY.equalTo(container.snp.centerY)
            $0.trailing.equalTo(container.snp.trailing).offset(-10)
        }
        
        text.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
        
        checkBox.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(text.snp.bottom).offset(20)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        text2.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(text.snp.bottom).offset(20)
        }
        
        registerButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(text2.snp.bottom).offset(20)
            $0.height.equalTo(45)
        }
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
    
    func setupAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(checkBoxTapped))
        text2.addGestureRecognizer(tap)
    }
}
