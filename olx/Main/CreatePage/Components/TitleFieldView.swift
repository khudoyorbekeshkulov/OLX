//
//  TitleFieldView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 10/11/26.
//

import UIKit
import SnapKit

protocol TitleFieldViewDelegate: AnyObject {
    func titleFieldView(didChangeText text: String)
}

/// Title input with a hint and character counter.
/// Wraps `FormFieldView` and reports edits through `TitleFieldViewDelegate`.
final class TitleFieldView: UIView {

    private let field: FormFieldView

    weak var delegate: TitleFieldViewDelegate?

    /// Current text without leading/trailing whitespace.
    var trimmedText: String { field.textField.text.trimmed }

    init(title: String, placeholder: String, hint: String) {
        field = FormFieldView(title: title, placeholder: placeholder, hint: hint)

        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Sets the counter text, e.g. "12/70".
    func setCounter(_ text: String) {
        field.setCounter(text)
    }
}

private extension TitleFieldView {
    func setup() {
        field.textField.autocapitalizationType = .sentences
        field.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)

        addSubview(field)
        field.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc func textChanged() {
        delegate?.titleFieldView(didChangeText: field.textField.text ?? "")
    }
}
