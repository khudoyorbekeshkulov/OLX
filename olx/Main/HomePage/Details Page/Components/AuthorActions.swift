//
//  AuthorActions.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 22/11/26.
//

import UIKit
import SnapKit

final class AuthorActions: UIView {
    
    private let feedbackButton = UIButton().then {
        $0.setTitle(L10n.Detail.leaveFeedback, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        $0.setTitleColor(ColorResourceManager.shared.mainManager, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    private let allAdsByUserLabel = UILabel().then {
        $0.attributedText = NSAttributedString(
            string: L10n.Detail.allListingsByUser,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 13, weight: .medium),
                .foregroundColor: ColorResourceManager.shared.mainManager
            ]
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AuthorActions {
    func addSubviews() {
        addSubviews([
            feedbackButton,
            allAdsByUserLabel
        ])
    }
    
    func setupConstraints() {
        feedbackButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.size.equalTo(CGSize(width: 160, height: 40))
            $0.bottom.equalToSuperview()
        }
        
        allAdsByUserLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(feedbackButton.snp.trailing).offset(10)
            $0.size.equalTo(CGSize(width: 160, height: 40))
            $0.bottom.equalToSuperview()
        }
    }
}
