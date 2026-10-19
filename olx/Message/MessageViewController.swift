import UIKit
import SnapKit

class MessageViewController: UIViewController {
    let rootView = MessageView()
    
    var chatPartnerName = "Сообщения"

    private var messages: [ChatMessage] = [
        ChatMessage(text: "Привет брат.", isFromCurrentUser: false),
        ChatMessage(text: "Привет.", isFromCurrentUser: true),
        ChatMessage(text: "Сколько, по-твоему, стоит?", isFromCurrentUser: false),
    ]
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.onSendTappet = { [weak self] in self?.sendTapped() }
        
        let phone = UIBarButtonItem(image: UIImage(systemName: "phone.fill"),style: .plain, target: self, action: #selector(phoneTapped))
        
        let ellipses = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),style: .plain, target: self, action: #selector(ellipsisTapped))
        
        navigationItem.title = chatPartnerName
        navigationItem.rightBarButtonItems = [ellipses, phone]
        
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
    
    @objc func phoneTapped() {
        print("phone tapped")
    }
    
    @objc func ellipsisTapped() {
        print("ellipsis tapped")
    }
    
    func sendTapped() {
        guard let text = rootView.textField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        
        messages.append(ChatMessage(text: text, isFromCurrentUser: true))
        rootView.textField.text = ""
        
        rootView.tableView.reloadData()
        rootView.scrollToBottom(rowCount: messages.count)
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let keyboardHeight = rootView.frame.height - endFrame.origin.y
        
        let offset = notification.name == UIResponder.keyboardWillHideNotification
        ? 0
        : -keyboardHeight + rootView.safeAreaInsets.bottom
        
        rootView.inputBarButtomConstraint.update(offset: offset)
        
        UIView.animate(withDuration: duration) {
            self.rootView.layoutIfNeeded()
        }
    }
}
