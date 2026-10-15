import UIKit
import SnapKit

class MessageViewController: UIViewController {
    var chatPartnerName = "Сообщения"
    
    private var inputBarButtomConstraint: Constraint!
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = UIColor(named: "chat_background_color")
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .interactive
        $0.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseID)
        $0.dataSource = self
        $0.delegate = self
    }
    
    private lazy var inputBar = UIView()
    
    private lazy var textField = UITextField().then {
        $0.placeholder = "Сообщения..."
        $0.backgroundColor = .systemGray6
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.rightView = sendButton
        $0.rightViewMode = .always
    }
    
    private lazy var sendButton = UIButton(type: .system).then {
        let config = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold)
        let sendImage = UIImage(systemName: "paperplane.circle.fill", withConfiguration: config)
        
        $0.setImage(sendImage, for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        $0.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
    }
    
    private var messages: [ChatMessage] = [
        ChatMessage(text: "Привет брат.", isFromCurrentUser: false),
        ChatMessage(text: "Привет.", isFromCurrentUser: true),
        ChatMessage(text: "Сколько, по-твоему, стоит?", isFromCurrentUser: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phone = UIBarButtonItem(image: UIImage(systemName: "phone.fill"),style: .plain, target: self, action: #selector(phoneTapped))
        
        let ellipses = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),style: .plain, target: self, action: #selector(ellipsisTapped))
        
        navigationItem.title = chatPartnerName
        navigationItem.rightBarButtonItems = [ellipses, phone]
        
        insertSubviews()
        addSubviews()
        setupConstraints()
        setupKeyboardObservers()
    }
}

extension MessageViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseID, for: indexPath) as! MessageCell
        cell.configure(with: messages[indexPath.row])
        return cell
    }
}

private extension MessageViewController {
    
    func insertSubviews() {
        view.insertSubview(tableView, at: 0)
    }
    
    func addSubviews() {
        view.addSubviews([
            tableView,
            inputBar
        ])
        
        inputBar.addSubview(textField)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        inputBar.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            inputBarButtomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            $0.height.equalTo(56)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc func phoneTapped() {
        print("Phone tapped")
    }
    
    @objc func ellipsisTapped() {
        print("Ellipses tapped")
    }
    
    @objc func sendTapped() {
        guard let text = textField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        
        messages.append(ChatMessage(text: text, isFromCurrentUser: true))
        textField.text = ""
        
        tableView.reloadData()
        scrollToBottom()
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let keyboardHeight = view.frame.height - endFrame.origin.y
        
        let offset = notification.name == UIResponder.keyboardWillHideNotification
        ? 0
        : -keyboardHeight + view.safeAreaInsets.bottom
        
        inputBarButtomConstraint.update(offset: offset)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollToBottom() {
        guard !messages.isEmpty else {return}
        
        let lastRow = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: lastRow, at: .bottom, animated: true)
    }
}
