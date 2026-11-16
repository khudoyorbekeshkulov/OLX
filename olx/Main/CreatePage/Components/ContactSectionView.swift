//
//  ContactSectionView.swift
//  olx
//

import UIKit
import SnapKit

/// "Contact details" block: header, contact name field and phone number field.
final class ContactSectionView: UIView {

    private enum Constants {
        static let headerSpacing: CGFloat = 12
        static let fieldSpacing: CGFloat = 20
    }

    private let nameField: FormFieldView
    private let phoneField: FormFieldView

    /// Contact name without leading/trailing whitespace.
    var trimmedName: String { nameField.textField.text.trimmed }

    /// Phone number without leading/trailing whitespace.
    var trimmedPhone: String { phoneField.textField.text.trimmed }

    init(
        header: String,
        nameTitle: String,
        namePlaceholder: String,
        phoneTitle: String,
        phonePlaceholder: String
    ) {
        nameField = FormFieldView(title: nameTitle, placeholder: namePlaceholder)
        phoneField = FormFieldView(title: phoneTitle, placeholder: phonePlaceholder)

        super.init(frame: .zero)
        setup(header: header)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ContactSectionView {
    func setup(header: String) {
        nameField.textField.autocapitalizationType = .sentences
        phoneField.textField.keyboardType = .phonePad

        let headerLabel = SectionHeaderLabel(text: header)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(headerLabel)
        stack.setCustomSpacing(Constants.headerSpacing, after: headerLabel)
        stack.addArrangedSubview(nameField)
        stack.setCustomSpacing(Constants.fieldSpacing, after: nameField)
        stack.addArrangedSubview(phoneField)

        addSubview(stack)
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
