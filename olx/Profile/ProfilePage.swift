import UIKit

class ProfilePage: UIViewController {
    
    private let loginView = LoginView()
    private let registerView = RegisterView()
    private let stackView = UIStackView()
    let mainColor = UIColor(red: 0/255, green: 47/255, blue: 52/255, alpha: 1.0)
    let segmentedControl = UIView()
    let loginButton = UIButton(type: .system)
    let registerButton = UIButton(type: .system)
    var indicatorLeadingConstraint: NSLayoutConstraint!
    let titleLabel = UILabel()
    let indicatorView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedToView)))
        
        setupUI()
        setupConstraints()
    }
    
    @objc func tappedToView() {
        view.endEditing(true)
    }
}

private extension ProfilePage {
    func setupUI() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "Создать"
        titleLabel.textColor = mainColor
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        view.addSubview(segmentedControl)
        segmentedControl.backgroundColor = .systemGray6
        segmentedControl.layer.cornerRadius = 5
        segmentedControl.clipsToBounds = true
        
        registerView.isHidden = true
        
        view.addSubview(loginView)
        view.addSubview(registerView)
        
        loginButton.setTitle( "Войти", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        registerButton.setTitle( "Зарегистрироваться", for: .normal)
        registerButton.setTitleColor(.gray, for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        segmentedControl.addSubview(stackView)
        stackView.addArrangedSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        stackView.addArrangedSubview(registerButton)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        segmentedControl.addSubview(indicatorView)
        indicatorView.backgroundColor = .white
        indicatorView.layer.cornerRadius = 5
        
        indicatorLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor)
        
        segmentedControl.sendSubviewToBack(indicatorView)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        loginView.translatesAutoresizingMaskIntoConstraints = false
        registerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    @objc func segmentUpdated(isLogin: Bool) {
        
        indicatorLeadingConstraint.constant = isLogin ? 0: segmentedControl.frame.width/2
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        loginButton.setTitleColor(isLogin ? .black: .gray, for: .normal)
        registerButton.setTitleColor(isLogin ? .gray: .black, for: .normal)
        
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
