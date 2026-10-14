import UIKit
import SnapKit

class ProfilePage: UIViewController {
    var indicatorLeadingConstraint: Constraint!
    
    private let loginView = LoginView()
    
    let registerView = RegisterView().then {
        $0.isHidden = true
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "Создать"
        $0.textColor = ColorResourceManager.shared.mainColor
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    private lazy var segmentedControl = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private lazy var loginButton = UIButton(type: .system).then {
        $0.setTitle( "Войти", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private lazy var registerButton = UIButton(type: .system).then {
        $0.setTitle( "Зарегистрироваться", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    private lazy var indicatorView = UIView().then {
        $0.backgroundColor = .white
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
        view.backgroundColor = .white
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
        segmentedControl.sendSubviewToBack(indicatorView)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(70)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(145)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(31)
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
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints {
            indicatorLeadingConstraint = $0.leading.equalToSuperview().offset(2).constraint
            $0.top.equalToSuperview().offset(2)
            $0.bottom.equalToSuperview().offset(-2)
            $0.width.equalTo(segmentedControl.snp.width).multipliedBy(0.5).offset(-2)
        }
    }
    
    @objc func tappedToView() {
        view.endEditing(true)
    }
    
    @objc func segmentUpdated(isLogin: Bool) {
        
        let offset = isLogin ? 0 : view.frame.width/2
        
        indicatorLeadingConstraint.update(offset: offset)
        
        loginButton.setTitleColor(isLogin ? .black : .gray, for: .normal)
        registerButton.setTitleColor(isLogin ? .gray : .black, for: .normal)
        
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
