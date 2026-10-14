import UIKit
import SnapKit

class MessageCell: UITableViewCell {
    static let reuseID = "MessageCell"
    
    private var leadingConstraint: Constraint!
    private var trailingConstraint: Constraint!
    
    private lazy var bubbleView = UIView().then {
        $0.layer.cornerRadius = 16
    }
    
    private lazy var messageLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessageCell {
    func configure(with message: ChatMessage) {
        messageLabel.text = message.text        
        messageLabel.textColor = message.isFromCurrentUser ? UIColor(hex: "#FFFFFF") : .label
        bubbleView.backgroundColor = message.isFromCurrentUser ? UIColor(hex: "#007AFF") : UIColor(hex: "#E5E5EA")
        leadingConstraint.isActive = !message.isFromCurrentUser
        trailingConstraint.isActive = message.isFromCurrentUser
    }
}

private extension MessageCell {
    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    func addSubviews() {
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
    }
    
    func setupConstraints() {
        bubbleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
            $0.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.75)
            
            leadingConstraint = $0.leading.equalToSuperview().offset(12).constraint
            trailingConstraint = $0.trailing.equalToSuperview().offset(-12).constraint
            
            leadingConstraint.deactivate()
            trailingConstraint.deactivate()
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(bubbleView.snp.top).offset(8)
            $0.leading.equalTo(bubbleView.snp.leading).offset(12)
            $0.trailing.equalTo(bubbleView.snp.trailing).offset(-12)
            $0.bottom.equalTo(bubbleView.snp.bottom).offset(-8)
        }
    }
}
