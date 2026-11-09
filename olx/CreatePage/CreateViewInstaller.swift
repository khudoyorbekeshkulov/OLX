//  
//  CreateViewInstaller.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import UIKit
import SnapKit

private enum Constants {
    static let fieldHeight: CGFloat = 52
    static let textAreaHeight: CGFloat = 150
    static let cornerRadius: CGFloat = 8
    static let sideInset: CGFloat = 15
}

protocol CreateViewInstaller: ViewInstaller {
    var scrollView: UIScrollView! { get set }
    var contentView: UIView! { get set }
    var formStack: UIStackView! { get set }
    var aboutLabel: UILabel! { get set }
    var photoBanner: UIControl! { get set }
    var selectedImageView: UIImageView! { get set }
    var uploadImageView: UIImageView! { get set }
    var addPhotoLabel: UILabel! { get set }
    var photoStack: UIStackView! { get set }
    var titleLabel: UILabel! { get set }
    var titleField: UITextField! { get set }
    var titleHintLabel: UILabel! { get set }
    var titleCounter: UILabel! { get set }
    var titleHintRow: UIStackView! { get set }
    var priceLabel: UILabel! { get set }
    var priceTextField: UITextField! { get set }
    var descriptionLabel: UILabel! { get set }
    var descriptionBox: UIView! { get set }
    var descriptionView: UITextView! { get set }
    var descriptionPlaceholder: UILabel! { get set }
    var descriptionHintLabel: UILabel! { get set }
    var descriptionCounter: UILabel! { get set }
    var descriptionHintRow: UIStackView! { get set }
    var contactsLabel: UILabel! { get set }
    var contactLabel: UILabel! { get set }
    var contactField: UITextField! { get set }
    var phoneLabel: UILabel! { get set }
    var phoneField: UITextField! { get set }
    var publishButton: UIButton! { get set }
}

extension CreateViewInstaller {
    
    func initSubViews() {
        mainView.backgroundColor = ColorResourceManager.shared.appBackground
        
        scrollView = UIScrollView().then {
            $0.showsVerticalScrollIndicator = false
            $0.keyboardDismissMode = .interactive
        }
        
        contentView = UIView()
        
        formStack = UIStackView().then {
            $0.axis = .vertical
        }
        
        aboutLabel = UILabel().then {
            $0.text = L10n.Create.aboutYourAdvertisementTitle
            $0.font = .systemFont(ofSize: 18, weight: .bold)
            $0.textColor = ColorResourceManager.shared.primaryText
            $0.numberOfLines = 0
        }
        
        photoBanner = UIControl().then {
            $0.backgroundColor = ColorResourceManager.shared.addImgBackground
            $0.layer.cornerRadius = Constants.cornerRadius
            $0.clipsToBounds = true
        }
        
        selectedImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.isHidden = true
        }
        
        uploadImageView = UIImageView(
            image: UIImage(
                systemName: "photo.badge.plus.fill",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 50)
            )
        ).then {
            $0.tintColor = ColorResourceManager.shared.white
            $0.contentMode = .scaleAspectFit
        }
        
        addPhotoLabel = UILabel().then {
            $0.attributedText = NSAttributedString(
                string: L10n.Create.addPhoto,
                attributes: [
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                    .foregroundColor: ColorResourceManager.shared.white
                ]
            )
        }
        
        photoStack = UIStackView(arrangedSubviews: [uploadImageView, addPhotoLabel]).then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 12
            $0.isUserInteractionEnabled = false
        }
        
        titleLabel = UILabel().then {
            $0.text = L10n.Create.titleLabelInput
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = ColorResourceManager.shared.primaryText
        }
        
        titleField = UITextField().then {
            $0.attributedPlaceholder = NSAttributedString(
                string: L10n.Create.inputProductNameTextField,
                attributes: [.foregroundColor: ColorResourceManager.shared.secondaryLabel]
            )
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = ColorResourceManager.shared.primaryText
            $0.backgroundColor = ColorResourceManager.shared.separator
            $0.layer.cornerRadius = Constants.cornerRadius
            $0.autocapitalizationType = .sentences
            $0.setLeftPadding(16)
        }
        
        titleHintLabel = UILabel().then {
            $0.text = L10n.Create.checkInputProductNameLatterNumber
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = ColorResourceManager.shared.secondaryLabel
        }
        
        titleCounter = UILabel().then {
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = ColorResourceManager.shared.secondaryLabel
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }
        
        titleHintRow = UIStackView(arrangedSubviews: [titleHintLabel, titleCounter]).then {
            $0.axis = .horizontal
        }
        
        priceLabel = UILabel().then {
            $0.text = L10n.Overall.priceLabel
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = ColorResourceManager.shared.primaryText
        }
        
        priceTextField = UITextField().then {
            $0.attributedPlaceholder = NSAttributedString(
                string: L10n.Overall.inputPricePlaceholder,
                attributes: [.foregroundColor: ColorResourceManager.shared.secondaryLabel]
            )
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = ColorResourceManager.shared.primaryText
            $0.backgroundColor = ColorResourceManager.shared.separator
            $0.layer.cornerRadius = Constants.cornerRadius
            $0.keyboardType = .emailAddress
            $0.autocapitalizationType = .none
            $0.setLeftPadding(16)
        }
        
        descriptionLabel = UILabel().then {
            $0.text = L10n.Overall.description
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = ColorResourceManager.shared.primaryText
        }
        
        descriptionBox = UIView().then {
            $0.backgroundColor = ColorResourceManager.shared.separator
            $0.layer.cornerRadius = Constants.cornerRadius
        }
        
        descriptionView = UITextView().then {
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = ColorResourceManager.shared.primaryText
            $0.backgroundColor = .clear
            $0.textContainerInset = .init(top: 14, left: 12, bottom: 14, right: 12)
        }
        
        descriptionPlaceholder = UILabel().then {
            $0.text = L10n.Create.descriptionPlaceholderInCreateView
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = ColorResourceManager.shared.secondaryLabel
            $0.numberOfLines = 0
        }
        
        descriptionHintLabel = UILabel().then {
            $0.text = L10n.Create.checkDescriptionLetterNumber
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = ColorResourceManager.shared.secondaryLabel
        }
        
        descriptionCounter = UILabel().then {
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = ColorResourceManager.shared.secondaryLabel
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }
        
        descriptionHintRow = UIStackView(arrangedSubviews: [descriptionHintLabel, descriptionCounter]).then {
            $0.axis = .horizontal
        }
        
        contactsLabel = UILabel().then {
            $0.text = L10n.Overall.contactDetailsLabel
            $0.font = .systemFont(ofSize: 18, weight: .bold)
            $0.textColor = ColorResourceManager.shared.primaryText
            $0.numberOfLines = 0
        }
        
        contactLabel = UILabel().then {
            $0.text = L10n.Overall.contactPersonLabel
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = ColorResourceManager.shared.primaryText
        }
        
        contactField = UITextField().then {
            $0.attributedPlaceholder = NSAttributedString(
                string: L10n.Overall.nameLabel,
                attributes: [.foregroundColor: ColorResourceManager.shared.secondaryLabel]
            )
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = ColorResourceManager.shared.primaryText
            $0.backgroundColor = ColorResourceManager.shared.separator
            $0.layer.cornerRadius = Constants.cornerRadius
            $0.autocapitalizationType = .sentences
            $0.setLeftPadding(16)
        }
        
        phoneLabel = UILabel().then {
            $0.text = L10n.Overall.phoneNumberLabel
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = ColorResourceManager.shared.primaryText
        }
        
        phoneField = UITextField().then {
            $0.attributedPlaceholder = NSAttributedString(
                string: "90 123 45 67",
                attributes: [.foregroundColor: ColorResourceManager.shared.secondaryLabel]
            )
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = ColorResourceManager.shared.primaryText
            $0.backgroundColor = ColorResourceManager.shared.separator
            $0.layer.cornerRadius = Constants.cornerRadius
            $0.keyboardType = .phonePad
            $0.setLeftPadding(16)
        }
        
        publishButton = UIButton(type: .system).then {
            $0.setTitle(L10n.Create.postAnAddButton, for: .normal)
            $0.setTitleColor(.systemBackground, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.backgroundColor = ColorResourceManager.shared.mainManager
            $0.layer.cornerRadius = Constants.cornerRadius
        }
    }
    
    func addSubViews() {
        mainView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(formStack)
        
        photoBanner.addSubviews([selectedImageView, photoStack])
        descriptionBox.addSubviews([descriptionView, descriptionPlaceholder])
        
        add(aboutLabel, after: 12)
        add(photoBanner, after: 20)
        
        add(titleLabel, after: 8)
        add(titleField, after: 6)
        add(titleHintRow, after: 20)
        
        add(priceLabel, after: 8)
        add(priceTextField, after: 20)
        
        add(descriptionLabel, after: 8)
        add(descriptionBox, after: 6)
        add(descriptionHintRow, after: 24)
        
        add(contactsLabel, after: 12)
        
        add(contactLabel, after: 8)
        add(contactField, after: 20)
        
        add(phoneLabel, after: 8)
        add(phoneField, after: 24)
        
        add(publishButton, after: 0)
    }
    
    func addSubViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(mainView.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        formStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.horizontalEdges.equalToSuperview().inset(Constants.sideInset)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        photoBanner.snp.makeConstraints {
            $0.height.equalTo(photoBanner.snp.width).multipliedBy(0.5)
        }
        
        selectedImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        photoStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        [titleField, contactField, priceTextField, phoneField, publishButton].forEach {
            $0.snp.makeConstraints { $0.height.equalTo(Constants.fieldHeight) }
        }
        
        descriptionBox.snp.makeConstraints {
            $0.height.equalTo(Constants.textAreaHeight)
        }
        
        descriptionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        descriptionPlaceholder.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.horizontalEdges.equalToSuperview().inset(17)
        }
    }
}

private extension CreateViewInstaller {
    func add(_ view: UIView, after spacing: CGFloat) {
        formStack.addArrangedSubview(view)
        formStack.setCustomSpacing(spacing, after: view)
    }
}
