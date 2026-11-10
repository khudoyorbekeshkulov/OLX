//
//  PrimaryButton.swift
//  olx
//

import UIKit
import SnapKit

protocol PrimaryButtonDelegate: AnyObject {
    func primaryButtonDidTap()
}

/// Main call-to-action button: filled background, rounded corners, fixed height.
/// Taps are reported through `PrimaryButtonDelegate`.
final class PrimaryButton: UIButton {

    private enum Constants {
        static let height: CGFloat = 52
        static let cornerRadius: CGFloat = 8
        static let highlightedAlpha: CGFloat = 0.7
    }

    weak var delegate: PrimaryButtonDelegate?

    init(title: String) {
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        setTitleColor(.systemBackground, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        backgroundColor = ColorResourceManager.shared.mainManager
        layer.cornerRadius = Constants.cornerRadius
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)

        snp.makeConstraints {
            $0.height.equalTo(Constants.height)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // A plain (non-.system) UIButton doesn't dim on touch, so do it manually.
    override var isHighlighted: Bool {
        didSet { alpha = isHighlighted ? Constants.highlightedAlpha : 1 }
    }
}

private extension PrimaryButton {
    @objc func handleTap() {
        delegate?.primaryButtonDidTap()
    }
}
