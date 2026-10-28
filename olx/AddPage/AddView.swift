//
//  AddView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 24/10/26.
//

import UIKit
import SnapKit

private enum Constants {
    static let fieldHeight: CGFloat = 52
    static let textAreaHeight: CGFloat = 150
    static let cornerRadius: CGFloat = 8
    static let sideInset: CGFloat = 15
    static let titleMaxLength = 70
    static let descriptionMaxLength = 9000
}

final class AddView: UIView {
    
    var onAddPhotoTapped: (() -> Void)?
    var onPublishTapped: ((AddForm) -> Void)?
        
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.keyboardDismissMode = .interactive
    }
    
    private let contentView = UIView()
    
    private let formStack = UIStackView().then {
        $0.axis = .vertical
    }
        
    private let aboutLabel = UILabel().then {
        $0.text = "Расскажите нам о вашей рекламе"
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = ColorResourceManager.shared.primaryText
        $0.numberOfLines = 0
    }
    
    private let photoBanner = UIControl().then {
        $0.backgroundColor = ColorResourceManager.shared.addImgBackground
        $0.layer.cornerRadius = Constants.cornerRadius
        $0.clipsToBounds = true
    }
    
    private let selectedImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isHidden = true
    }
    
    private let uploadImageView = UIImageView(
        image: UIImage(
            systemName: "photo.badge.plus.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 50)
        )
    ).then {
        $0.tintColor = ColorResourceManager.shared.white
        $0.contentMode = .scaleAspectFit
    }
    
    private let addPhotoLabel = UILabel().then {
        $0.attributedText = NSAttributedString(
            string: "Добавить фото",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: ColorResourceManager.shared.white
            ]
        )
    }
    
    private lazy var photoStack = UIStackView(arrangedSubviews: [uploadImageView, addPhotoLabel]).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 12
        $0.isUserInteractionEnabled = false
    }
        
    private let titleLabel = UILabel().then {
        $0.text = "Заголовок*"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = ColorResourceManager.shared.primaryText
    }
    
    private let titleField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "Например, iPhone 11 с гарантией",
            attributes: [.foregroundColor: ColorResourceManager.shared.secondaryLabel]
        )
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = ColorResourceManager.shared.primaryText
        $0.backgroundColor = ColorResourceManager.shared.separator
        $0.layer.cornerRadius = Constants.cornerRadius
        $0.autocapitalizationType = .sentences
        $0.setLeftPadding(16)
    }
    
    private let titleHintLabel = UILabel().then {
        $0.text = "Введите не менее 16 символов"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = ColorResourceManager.shared.secondaryLabel
    }
    
    private let titleCounter = UILabel().then {
        $0.text = "0/\(Constants.titleMaxLength)"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = ColorResourceManager.shared.secondaryLabel
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private lazy var titleHintRow = UIStackView(arrangedSubviews: [titleHintLabel, titleCounter]).then {
        $0.axis = .horizontal
    }
        
    private let descriptionLabel = UILabel().then {
        $0.text = "Описание*"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = ColorResourceManager.shared.primaryText
    }
    
    private let descriptionBox = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.separator
        $0.layer.cornerRadius = Constants.cornerRadius
    }
    
    private let descriptionView = UITextView().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = ColorResourceManager.shared.primaryText
        $0.backgroundColor = .clear
        $0.textContainerInset = .init(top: 14, left: 12, bottom: 14, right: 12)
    }
    
    private let descriptionPlaceholder = UILabel().then {
        $0.text = "Представьте себя на месте покупателя и опишите товар :)"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = ColorResourceManager.shared.secondaryLabel
        $0.numberOfLines = 0
    }
    
    private let descriptionHintLabel = UILabel().then {
        $0.text = "Введите не менее 40 символов"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = ColorResourceManager.shared.secondaryLabel
    }
    
    private let descriptionCounter = UILabel().then {
        $0.text = "0/\(Constants.descriptionMaxLength)"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = ColorResourceManager.shared.secondaryLabel
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private lazy var descriptionHintRow = UIStackView(arrangedSubviews: [descriptionHintLabel, descriptionCounter]).then {
        $0.axis = .horizontal
    }
        
    private let contactsLabel = UILabel().then {
        $0.text = "Контактные данные"
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = ColorResourceManager.shared.primaryText
        $0.numberOfLines = 0
    }
    
    private let contactLabel = UILabel().then {
        $0.text = "Контактное лицо*"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = ColorResourceManager.shared.primaryText
    }
    
    private let contactField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "Имя",
            attributes: [.foregroundColor: ColorResourceManager.shared.secondaryLabel]
        )
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = ColorResourceManager.shared.primaryText
        $0.backgroundColor = ColorResourceManager.shared.separator
        $0.layer.cornerRadius = Constants.cornerRadius
        $0.autocapitalizationType = .sentences
        $0.setLeftPadding(16)
    }
    
    private let emailLabel = UILabel().then {
        $0.text = "Email"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = ColorResourceManager.shared.primaryText
    }
    
    private let emailField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "example@mail.com",
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
    
    private let phoneLabel = UILabel().then {
        $0.text = "Номер телефона"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = ColorResourceManager.shared.primaryText
    }
    
    private let phoneField = UITextField().then {
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
    
    private let publishButton = UIButton(type: .system).then {
        $0.setTitle("Опубликовать объявление", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = ColorResourceManager.shared.mainManager
        $0.layer.cornerRadius = Constants.cornerRadius
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhoto(_ image: UIImage) {
        selectedImageView.image = image
        selectedImageView.isHidden = false
        photoStack.isHidden = true
    }
}

private extension AddView {
    func setupView() {
        backgroundColor = ColorResourceManager.shared.appBackground
        
        photoBanner.addTarget(self, action: #selector(photoTapped), for: .touchUpInside)
        titleField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
        descriptionView.delegate = self
    }
    
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(formStack)
        
        photoBanner.addSubviews([selectedImageView, photoStack])
        descriptionBox.addSubviews([descriptionView, descriptionPlaceholder])
        
        add(aboutLabel, after: 12)
        add(photoBanner, after: 20)
        
        add(titleLabel, after: 8)
        add(titleField, after: 6)
        add(titleHintRow, after: 20)
        
        add(descriptionLabel, after: 8)
        add(descriptionBox, after: 6)
        add(descriptionHintRow, after: 24)
        
        add(contactsLabel, after: 12)
        
        add(contactLabel, after: 8)
        add(contactField, after: 20)
        
        add(emailLabel, after: 8)
        add(emailField, after: 20)
        
        add(phoneLabel, after: 8)
        add(phoneField, after: 24)
        
        add(publishButton, after: 0)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
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
        
        [titleField, contactField, emailField, phoneField, publishButton].forEach {
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
    
    func add(_ view: UIView, after spacing: CGFloat) {
        formStack.addArrangedSubview(view)
        formStack.setCustomSpacing(spacing, after: view)
    }
    
    @objc func photoTapped() {
        onAddPhotoTapped?()
    }

    @objc func titleChanged() {
        let count = titleField.text?.count ?? 0
        titleCounter.text = "\(count)/\(Constants.titleMaxLength)"
    }
}

extension AddView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        descriptionPlaceholder.isHidden = !textView.text.isEmpty
        descriptionCounter.text = "\(textView.text.count)/\(Constants.descriptionMaxLength)"
    }
}
