import UIKit

class Message: UIViewController {
    
    var chatPartnerName = "Сообщения"
    
    private var inputBarButtomConstraint: NSLayoutConstraint!
    
    private lazy var image = UIImageView(image: UIImage( named: "chatWallpaper")).then {
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .interactive
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var inputBar = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var textField = UITextField().then {
        $0.placeholder = "Сообщения..."
        $0.backgroundColor = .systemGray6
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
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
        
        view.insertSubview(image, at: 0)
        
        let phone = UIBarButtonItem(image: UIImage(systemName: "phone.fill"),style: .plain, target: self, action: #selector(phoneTapped))
        
        let ellipses = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),style: .plain, target: self, action: #selector(ellipsisTapped))
        
        navigationItem.title = chatPartnerName
        navigationItem.rightBarButtonItems = [ellipses, phone]
        
        setupTableView()
        addSubviews()
        setupInputBar()
        setupConstraints()
        setupKeyboardObservers()
    }
}

extension Message: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseID, for: indexPath) as! MessageCell
        cell.configure(with: messages[indexPath.row])
        return cell
    }
}

private extension Message {
    func setupTableView() {
       tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseID)
       tableView.dataSource = self
       tableView.delegate = self
   }
       
    func setupInputBar() {
       textField.rightView = sendButton
       textField.rightViewMode = .always
        
       inputBarButtomConstraint = inputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
   }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(inputBar)
        inputBar.addSubview(textField)
    }
    
     func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            inputBar.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBarButtomConstraint,
            inputBar.heightAnchor.constraint(equalToConstant: 56),
            
            textField.leadingAnchor.constraint(equalTo: inputBar.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: inputBar.trailingAnchor, constant: -12),
            textField.centerYAnchor.constraint(equalTo: inputBar.centerYAnchor),
        ])
    }
}

extension Message {
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
}

extension Message {
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let keyboardHeight = view.frame.height - endFrame.origin.y
        inputBarButtomConstraint.constant = notification.name == UIResponder.keyboardWillHideNotification ? 0 : -keyboardHeight + view.safeAreaInsets.bottom
        
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
