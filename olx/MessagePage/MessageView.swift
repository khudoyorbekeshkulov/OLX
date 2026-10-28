//
//  MessageView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/10/26.
//

import UIKit
import SnapKit

final class MessageView: UIView {
    var onSendTapped: (() -> Void)?
    var inputBarBottomConstraint: Constraint!
    
    private var messages = [ChatMessage]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                tableView.reloadData()
                scrollToBottom(rowCount: messages.count)
            }
        }
    }
    
    var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(cellType: MessageCell.self)
        $0.keyboardDismissMode = .interactive
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
    }
    
    let inputBar = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var sendButton = UIButton(type: .system).then {
        let config = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold)
        let sendImage = UIImage(systemName: "paperplane.circle.fill", withConfiguration: config)
        
        $0.setImage(sendImage, for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        $0.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
    }
    
    lazy var textField = UITextField().then {
        $0.placeholder = "Сообщения..."
        $0.backgroundColor = ColorResourceManager.shared.keyboardAreaColor
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.rightView = sendButton
        $0.rightViewMode = .always
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMessages(messages: [ChatMessage]) {
        self.messages = messages
    }
    
    func onMessageSend(messages: [ChatMessage]) {
        textField.text = ""
        self.messages = messages
    }
}

private extension MessageView {
    func setupView() {
        backgroundColor = ColorResourceManager.shared.chatBackground
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func addSubviews() {
        insertSubview(tableView, at: 0)
        
        addSubviews([
            tableView,
            inputBar
        ])
        
        inputBar.addSubview(textField)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        inputBar.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            inputBarBottomConstraint = $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).constraint
            $0.height.equalTo(56)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }
    }
}

extension MessageView: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        messages.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        tableView.dequeueCell(MessageCell.self, for: indexPath).then {
            guard let message = messages[safe: indexPath.row] else { return }
            $0.configure(with: message)
        }
    }
}

extension MessageView {
    @objc func sendTapped() {
        onSendTapped?()
    }
    
    func scrollToBottom(rowCount: Int) {
        guard rowCount > 0 else { return }
      
        tableView.scrollToRow(
            at: IndexPath(row: rowCount - 1, section: 0),
            at: .bottom,
            animated: true
        )
    }
}
