import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    private let loginView = LoginView()

    private let registerView = RegisterView().then {
        $0.isHidden = true
    }

    private lazy var titleLabel = UILabel().then {
        $0.text = "Создать"
        $0.textColor = UIColor(named: "main_manager_color")
        $0.font = .systemFont(ofSize: 28, weight: .bold)
    }

    private lazy var segmentedControl = UIView().then {
        $0.backgroundColor = UIColor(named: "separator_color")
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }

    private lazy var authStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }

    private lazy var loginButton = UIButton(type: .system).then {
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }

    private lazy var registerButton = UIButton(type: .system).then {
        $0.setTitle("Зарегистрироваться", for: .normal)
        $0.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitleColor(.gray, for: .normal)
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        segmentUpdated(isLogin: true)
    }
}

private extension ProfileViewController {
    func setupView() {
        view.backgroundColor = UIColor(named: "profile_background_color")
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(tappedToView))
        )
    }

    func addSubviews() {
        view.addSubviews([
            titleLabel,
            segmentedControl,
            loginView,
            registerView
        ])

        segmentedControl.addSubview(authStackView)

        authStackView.addArrangedSubviews([
            loginButton,
            registerButton
        ])
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(70)
        }

        segmentedControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.height.equalTo(32)
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

        authStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
        }
    }

    @objc func tappedToView() {
        view.endEditing(true)
    }

    func segmentUpdated(isLogin: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            
            loginButton.then {
                $0.backgroundColor = isLogin ? UIColor(named: "segmented_control_color") : .clear
                $0.setTitleColor(isLogin ? .black : .gray, for: .normal)
            }
            
            registerButton.then {
                $0.backgroundColor = isLogin ? .clear : UIColor(named: "segmented_control_color")
                $0.setTitleColor(isLogin ? .gray : .black, for: .normal)
            }
        }

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
