import UIKit

class ProfilePage: UIViewController {
    var indicatorLeadingConstraint: NSLayoutConstraint!
    
    private let loginView = LoginView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let registerView = RegisterView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Создать"
        $0.textColor = ColorResourceManager.shared.mainColor
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    
    private lazy var stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    private lazy var segmentedControl = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hex: "#F2F2F7")
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private lazy var loginButton = UIButton(type: .system).then {
        $0.setTitle( "Войти", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private lazy var registerButton = UIButton(type: .system).then {
        $0.setTitle( "Зарегистрироваться", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    private lazy var indicatorView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hex: "#FFFFFF")
        $0.layer.cornerRadius = 5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }
}

private extension ProfilePage {
    
    func setupView() {
        view.backgroundColor = UIColor(hex: "#FFFFFF")
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedToView)))
    }
    
    func addSubviews() {
        view.addarrangedSubviews([
            titleLabel,
            segmentedControl,
            loginView,
            registerView
        ])
        
        segmentedControl.addarrangedSubviews([
            stackView,
            indicatorView
        ])
        
        stackView.addarrangedSubviews([
            loginButton,
            registerButton
        ])
    }
    
    func setupConstraints() {
        indicatorLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor)
        segmentedControl.sendSubviewToBack(indicatorView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 145),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            segmentedControl.heightAnchor.constraint(equalToConstant: 31),
            
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            registerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: segmentedControl.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            
            indicatorLeadingConstraint,
            indicatorView.topAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: 2),
            indicatorView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: -2),
            indicatorView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 0.5, constant: -2)
        ])
    }
    
    @objc func tappedToView() {
        view.endEditing(true)
    }
    
    @objc func segmentUpdated(isLogin: Bool) {
        
        indicatorLeadingConstraint.constant = isLogin ? 0: segmentedControl.frame.width/2
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        loginButton.setTitleColor(isLogin ? UIColor(hex: "#000000"): UIColor(hex: "#808080"), for: .normal)
        registerButton.setTitleColor(isLogin ? UIColor(hex: "#808080"): UIColor(hex: "#000000"), for: .normal)
        
        loginView.isHidden = !isLogin
        registerView.isHidden = isLogin
    }
    
    @objc func loginTapped() {
        segmentUpdated(isLogin: true)
    }
    
    @objc func registerTapped() {
        segmentUpdated(isLogin: false)
    }
}
