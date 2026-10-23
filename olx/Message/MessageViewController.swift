import UIKit
import SnapKit

class MessageViewController: UIViewController {
    let rootView = MessageView()
    
    private let navigationTitle: String
    
    var messages: [ChatMessage] = []
    
    init(navigationTitle: String) {
        self.navigationTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNetworkCalls()
        setupViewBinders()
        setupKeyboardObservers()
    }
}

private extension MessageViewController {
    func setupView() {
        navigationItem.title = navigationTitle
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: "ellipsis"),
                style: .plain,
                target: self,
                action: #selector(ellipsisTapped)
            ),
            UIBarButtonItem(
                image: UIImage(systemName: "phone.fill"),
                style: .plain,
                target: self,
                action: #selector(phoneTapped)
            )
        ]
    }
    
    func setupViewBinders() {
        rootView.onSendTapped = { [weak self] in
            self?.sendTapped()
        }
    }
    
    func sendTapped() {
        guard let text = rootView.textField.text,
              !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return }
        
        messages.append(ChatMessage(text: text, isFromCurrentUser: true))
        rootView.onMessageSend(messages: messages)
    }
    
    @objc func phoneTapped() {
        print("phone tapped")
    }
    
    @objc func ellipsisTapped() {
        print("ellipsis tapped")
    }
}
