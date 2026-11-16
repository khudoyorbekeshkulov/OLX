//
//  SectionHeaderLabel.swift
//  olx
//

import UIKit

/// Bold title shown above a group of form fields.
final class SectionHeaderLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)

        self.text = text
        font = .systemFont(ofSize: 18, weight: .bold)
        textColor = ColorResourceManager.shared.primaryText
        numberOfLines = 0
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
