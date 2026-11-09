//  
//  CreateController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import UIKit
import PhotosUI

class CreateController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: CreatePresenter!
    
    var titleSection: FormFieldView!
    var priceSection: FormFieldView!
    var contactSection: FormFieldView!
    var phoneSection: FormFieldView!
    var aboutLabel: UILabel!
    var addPhotoLabel: UILabel!
    var contactsLabel: UILabel!
    var scrollView: UIScrollView!
    var contentView: UIView!
    var formStack: UIStackView!
    var photoBanner: UIControl!
    var selectedImageView: UIImageView!
    var uploadImageView: UIImageView!
    var photoStack: UIStackView!
    var descriptionLabel: UILabel!
    var descriptionBox: UIView!
    var descriptionView: UITextView!
    var descriptionPlaceholder: UILabel!
    var descriptionHintLabel: UILabel!
    var descriptionCounter: UILabel!
    var descriptionHintRow: UIStackView!
    var publishButton: UIButton!

    // swiftlint:enable implicitly_unwrapped_optional
    private init(with configurator: CreateConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UIViewController Lifecycle
extension CreateController: CreateViewInstaller {
    
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        installSubviews()
        setupViewController()
        presenter.viewDidLoad()
    }
}

// MARK: View Protocol Conformation
extension CreateController: CreateView {
    func setupLabelDetails(
        fromTitleCounter fromTitle: Int,
        toTitleCounter toTitle: Int,
        fromDescriptionCounter fromDescription: Int,
        toDescriptionCounter toDescription: Int
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
           
            titleSection.setCounter("\(fromTitle)/\(toTitle)")
            descriptionCounter.text = "\(fromDescription)/\(toDescription)"
        }
    }
    
    func setupTitleCounter(fromTitleCounter: Int, toTitleCounter: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
           
            titleSection.setCounter("\(fromTitleCounter)/\(toTitleCounter)")
        }
    }
    
    func setupDescriptionCounter(fromDescriptionCounter: Int, toDescriptionCounter: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
           
            descriptionCounter.text = "\(fromDescriptionCounter)/\(toDescriptionCounter)"
        }
    }
}

// MARK: Static Initializer
extension CreateController {
    static func instantiate() -> CreateController {
        let configurator = CreateConfiguratorImpl()
        let vc = CreateController(with: configurator)
        return vc
    }
}

private extension CreateController {
    func setupViewController() {
        navigationItem.title = L10n.Overall.create
        
        photoBanner.addTarget(self, action: #selector(photoTapped), for: .touchUpInside)
        titleSection.textField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
        publishButton.addTarget(self, action: #selector(publishTapped), for: .touchUpInside)
        descriptionView.delegate = self
    }
    
    @objc func photoTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func titleChanged() {
        presenter.updateTitleCounter(counter: titleSection.textField.text?.count ?? 0)
    }
    
    @objc func publishTapped() {
        publish(
            AddForm(
                image: selectedImageView.image,
                title: titleSection.textField.text.trimmed,
                price: priceSection.textField.text.trimmed,
                description: descriptionView.text.trimmed,
                contactName: contactSection.textField.text.trimmed,
                phoneNumber: phoneSection.textField.text.trimmed
            )
        )
    }
    
    func publish(_ form: AddForm) {
        let validations: [(isValid: Bool, message: String)] = [
            (form.title.count >= 5, "Введите не менее 5 символов в заголовке"),
            (form.description.count >= 10, "Введите не менее 10 символов в описании"),
            (!form.contactName.isEmpty, "Укажите контактное лицо"),
            (form.image != nil, "Добавьте фото")
        ]

        if let error = validations.first(where: { !$0.isValid }) {
            showAlert(error.message)
            return
        }

        guard let image = form.image else { return }
        
        let category = Category(
            image: image,
            title: form.title,
            priceNumbers: form.price.isEmpty ? "Договорная" : form.price,
            phoneNumber: form.phoneNumber,
            locationAndTime: "Только что",
            contactName: form.contactName,
            descriptionProduct: form.description
        )
        
        ListingsService.shared.add(category)
        
        tabBarController?.selectedIndex = 0
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension CreateController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else { return }
        
        provider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
            guard let image = object as? UIImage else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
               
                selectedImageView.image = image
                selectedImageView.isHidden = false
                photoStack.isHidden = true
            }
        }
    }
}


extension CreateController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        descriptionPlaceholder.isHidden = !textView.text.isEmpty
        presenter.updateDescriptionCounter(counter: textView.text.count)
    }
}
