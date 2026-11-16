//
//  FormFieldView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import UIKit
import SnapKit

private enum Constants {
    static let fieldHeight: CGFloat = 52
    static let cornerRadius: CGFloat = 8
}

final class FormFieldView: UIView {
    
    let textField = UITextField()
    
    private let titleLabel = UILabel()
    private let hintLabel = UILabel()
    private let counterLabel = UILabel()
    private let stack = UIStackView()
    
    init(title: String, placeholder: String, hint: String? = nil) {
        super.init(frame: .zero)
        setupViews(title: title, placeholder: placeholder, hint: hint)
        
        addSubviews()
        setupContraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FormFieldView {
    func setCounter(_ text: String) {
        counterLabel.text = text
    }
}

private extension FormFieldView {
    func setupViews(title: String, placeholder: String, hint: String?) {
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = ColorResourceManager.shared.primaryText
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: ColorResourceManager.shared.secondaryLabel]
        )
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = ColorResourceManager.shared.primaryText
        textField.backgroundColor = ColorResourceManager.shared.separator
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.setLeftPadding(16)
        
        stack.axis = .vertical
        stack.spacing = 6
        stack.addArrangedSubview(titleLabel)
        stack.setCustomSpacing(6, after: titleLabel)
        stack.addArrangedSubview(textField)
        
        if let hint {
            hintLabel.text = hint
            hintLabel.font = .systemFont(ofSize: 13)
            hintLabel.textColor = ColorResourceManager.shared.secondaryLabel
            
            counterLabel.font = .systemFont(ofSize: 13)
            counterLabel.textColor = ColorResourceManager.shared.secondaryLabel
            counterLabel.setContentHuggingPriority(.required, for: .horizontal)
            
            let hintRow = UIStackView(arrangedSubviews: [hintLabel, counterLabel])
            hintRow.axis = .horizontal
            stack.addArrangedSubview(hintRow)
        }
    }
    
    func addSubviews() {
        addSubview(stack)
    }
    
    func setupContraints() {
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.height.equalTo(Constants.fieldHeight)
        }
    }
}
