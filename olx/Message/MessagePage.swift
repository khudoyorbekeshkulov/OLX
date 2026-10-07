

import UIKit

class Message: UIViewController {
    
    var chatPartnerName = "Сообщения"
    private let image = UIImageView(image: UIImage(named: "chatWallpaper"))
    private let tableView = UITableView()
    private let inputBar = UIView()
    private let tf = UITextField()
    private let sendButton = UIButton(type: .system)
    
    private var inputBarButtomConstraint: NSLayoutConstraint!
    
    private var messages: [ChatMessage] = [
        ChatMessage(text: "Привет брат.", isFromCurrentUser: false),
        ChatMessage(text: "Привет.", isFromCurrentUser: true),
        ChatMessage(text: "Сколько, по-твоему, стоит?", isFromCurrentUser: false),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(image, at: 0)
        image.contentMode = .scaleAspectFill
        
        let phone = UIBarButtonItem(image: UIImage(systemName: "phone.fill"),style: .plain, target: self, action: #selector(phoneTapped))
        
        let ellipses = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),style: .plain, target: self, action: #selector(ellipsisTapped))
        
        navigationItem.title = chatPartnerName
        navigationItem.rightBarButtonItems = [ellipses, phone]
        
        setupTableView()
        setupInputBar()
        setupConstraints()
        setupKeyboardObservers()
    }
}

extension Message: UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - UITableViewDataSource / Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseID, for: indexPath) as! MessageCell
        
        cell.configure(with: messages[indexPath.row])
        return cell
    }
    
    
    // MARK: - Table view
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .clear
    }
    
    // MARK: - Input bar
    
    private func setupInputBar() {
        view.addSubview(inputBar)
        inputBar.addSubview(tf)
        
        tf.placeholder = "Сообщения..."
        tf.backgroundColor = .systemGray6
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 15
        tf.clipsToBounds = true
        
        // send button controller
        let config = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold)
        let sendImage = UIImage(systemName: "paperplane.circle.fill", withConfiguration: config)
        
        sendButton.setImage(sendImage, for: .normal)
        sendButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        
        tf.rightView = sendButton
        tf.rightViewMode = .always
        
        inputBarButtomConstraint = inputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
}


extension Message {
    private func setupConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        inputBar.translatesAutoresizingMaskIntoConstraints = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            tf.leadingAnchor.constraint(equalTo: inputBar.leadingAnchor, constant: 12),
            tf.trailingAnchor.constraint(equalTo: inputBar.trailingAnchor, constant: -12),
            tf.centerYAnchor.constraint(equalTo: inputBar.centerYAnchor),
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
        guard let text = tf.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        
        messages.append(ChatMessage(text: text, isFromCurrentUser: true))
        tf.text = ""
        
        tableView.reloadData()
        scrollToBottom()
    }
    
    private func scrollToBottom() {
        guard !messages.isEmpty else {return}
        
        let lastRow = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: lastRow, at: .bottom, animated: true)
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
}
