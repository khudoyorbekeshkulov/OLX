//
//  DescriptionFieldView.swift
//  olx
//

import UIKit
import SnapKit

protocol DescriptionFieldViewDelegate: AnyObject {
    func descriptionFieldView(didChangeText text: String)
}

/// Multi-line description field: title, text area with placeholder, hint and a character counter.
/// It is its own `UITextViewDelegate`; the screen only listens through `DescriptionFieldViewDelegate`.
final class DescriptionFieldView: UIView {

    private enum Constants {
        static let boxHeight: CGFloat = 150
        static let cornerRadius: CGFloat = 8
        static let textInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
        static let titleSpacing: CGFloat = 8
        static let boxSpacing: CGFloat = 6
    }

    private let titleLabel = UILabel()
    private let boxView = UIView()
    private let textView = UITextView()
    private let placeholderLabel = UILabel()
    private let hintLabel = UILabel()
    private let counterLabel = UILabel()
    private let contentStack = UIStackView()

    weak var delegate: DescriptionFieldViewDelegate?

    /// Current text without leading/trailing whitespace.
    var trimmedText: String { textView.text.trimmed }

    init(title: String, placeholder: String, hint: String) {
        super.init(frame: .zero)
        setup(title: title, placeholder: placeholder, hint: hint)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Sets the counter text, e.g. "12/9000".
    func setCounter(_ text: String) {
        counterLabel.text = text
    }
}

// MARK: UITextViewDelegate
extension DescriptionFieldView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        delegate?.descriptionFieldView(didChangeText: textView.text)
    }
}

private extension DescriptionFieldView {
    func setup(title: String, placeholder: String, hint: String) {
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = ColorResourceManager.shared.primaryText

        boxView.backgroundColor = ColorResourceManager.shared.separator
        boxView.layer.cornerRadius = Constants.cornerRadius

        textView.font = .systemFont(ofSize: 16)
        textView.textColor = ColorResourceManager.shared.primaryText
        textView.backgroundColor = .clear
        textView.textContainerInset = Constants.textInset
        textView.delegate = self

        placeholderLabel.text = placeholder
        placeholderLabel.font = .systemFont(ofSize: 16)
        placeholderLabel.textColor = ColorResourceManager.shared.secondaryLabel
        placeholderLabel.numberOfLines = 0

        hintLabel.text = hint
        hintLabel.font = .systemFont(ofSize: 13)
        hintLabel.textColor = ColorResourceManager.shared.secondaryLabel

        counterLabel.font = .systemFont(ofSize: 13)
        counterLabel.textColor = ColorResourceManager.shared.secondaryLabel
        counterLabel.setContentHuggingPriority(.required, for: .horizontal)

        let hintRow = UIStackView(arrangedSubviews: [hintLabel, counterLabel])
        hintRow.axis = .horizontal

        contentStack.axis = .vertical
        contentStack.addArrangedSubview(titleLabel)
        contentStack.setCustomSpacing(Constants.titleSpacing, after: titleLabel)
        contentStack.addArrangedSubview(boxView)
        contentStack.setCustomSpacing(Constants.boxSpacing, after: boxView)
        contentStack.addArrangedSubview(hintRow)

        addSubview(contentStack)
        boxView.addSubviews([textView, placeholderLabel])

        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        boxView.snp.makeConstraints {
            $0.height.equalTo(Constants.boxHeight)
        }

        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // Line the placeholder up with the text the user will type.
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.textInset.top)
            $0.horizontalEdges.equalToSuperview().inset(
                Constants.textInset.left + textView.textContainer.lineFragmentPadding
            )
        }
    }
}
