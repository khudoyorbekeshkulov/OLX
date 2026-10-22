import UIKit

final class ProfileViewController: UIViewController {
    let rootView = ProfileView()
    
    private lazy var loginButton = UIButton(type: .system).then {
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(UIColor(hex: "#000000"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.backgroundColor = UIColor(hex: "#FFFFFF")
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private lazy var registerButton = UIButton(type: .system).then {
        $0.setTitle("Зарегистрироваться", for: .normal)
        $0.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitleColor(UIColor(hex: "#8E8E93"), for: .normal)
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 5
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        segmentUpdated(isLogin: true)
    }
}

private extension ProfileViewController {
    func setupView() {
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(tappedToView)
            )
        )
    }
    
    func addSubviews() {
        rootView.authStackView.addArrangedSubviews([
            loginButton,
            registerButton
        ])
    }
    
    @objc func tappedToView() {
        view.endEditing(true)
    }
    
    func segmentUpdated(isLogin: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            
            loginButton.then {
                $0.backgroundColor = isLogin ? UIColor(hex: "#FFFFFF") : .clear
                $0.setTitleColor(isLogin ? UIColor(hex: "#000000") : UIColor(hex: "#8E8E93"), for: .normal)
            }
            
            registerButton.then {
                $0.backgroundColor = isLogin ? .clear : UIColor(hex: "#FFFFFF")
                $0.setTitleColor(isLogin ? UIColor(hex: "#8E8E93") : UIColor(hex: "#000000"), for: .normal)
            }
        }
        
        rootView.loginView.isHidden = !isLogin
        rootView.registerView.isHidden = isLogin
    }
    
    @objc func loginTapped() {
        segmentUpdated(isLogin: true)
    }
    
    @objc func registerTapped() {
        segmentUpdated(isLogin: false)
    }
}
