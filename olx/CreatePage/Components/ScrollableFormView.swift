//
//  ScrollableFormView.swift
//  olx
//

import UIKit
import SnapKit

/// Vertical scroll container that stacks its sections one under another.
/// Owns the scroll view / content view / stack view boilerplate so screens only call `add(_:after:)`.
final class ScrollableFormView: UIScrollView {

    private enum Constants {
        static let topInset: CGFloat = 15
        static let sideInset: CGFloat = 15
        static let bottomInset: CGFloat = 20
    }

    private let contentView = UIView()
    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Appends a section to the form and sets the gap between it and the next one.
    func add(_ view: UIView, after spacing: CGFloat = 0) {
        stackView.addArrangedSubview(view)
        stackView.setCustomSpacing(spacing, after: view)
    }
}

private extension ScrollableFormView {
    func setup() {
        showsVerticalScrollIndicator = false
        keyboardDismissMode = .interactive

        stackView.axis = .vertical

        addSubview(contentView)
        contentView.addSubview(stackView)

        contentView.snp.makeConstraints {
            $0.edges.equalTo(contentLayoutGuide)
            $0.width.equalTo(frameLayoutGuide)
        }

        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.topInset)
            $0.horizontalEdges.equalToSuperview().inset(Constants.sideInset)
            $0.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
    }
}
