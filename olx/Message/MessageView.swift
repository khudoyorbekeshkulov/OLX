//
//  MessageView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/10/26.
//

import UIKit
import SnapKit

class MessageView: UIView {
    
    var onSendTappet: (() -> Void)?
    var inputBarButtomConstraint: Constraint!
        
    var tableView = UITableView().then {
        $0.backgroundColor = UIColor(named: "chat_background_color")
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .interactive
        $0.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseID)
    }
    
    let inputBar = UIView()
    
    private lazy var sendButton = UIButton(type: .system).then {
        let config = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold)
        let sendImage = UIImage(systemName: "paperplane.circle.fill", withConfiguration: config)
        
        $0.setImage(sendImage, for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        $0.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
    }
    
    lazy var textField = UITextField().then {
        $0.placeholder = "Сообщения..."
        $0.backgroundColor = .systemGray6
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.rightView = sendButton
        $0.rightViewMode = .always
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        insertSubviews()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MessageView {
    
    func insertSubviews() {
        insertSubview(tableView, at: 0)
    }
    
    func addSubviews() {
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
            inputBarButtomConstraint = $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).constraint
            $0.height.equalTo(56)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }
    }
}

extension MessageView {
    
    @objc func sendTapped() {
        onSendTappet?()
    }

    func scrollToBottom(rowCount: Int) {
        guard rowCount > 0 else {return}
        
        let lastRow = IndexPath(row: rowCount - 1, section: 0)
        tableView.scrollToRow(at: lastRow, at: .bottom, animated: true)
    }
}
