//
//  CreateController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import UIKit
import PhotosUI

typealias CreateControllerProtocols = TitleFieldViewDelegate & DescriptionFieldViewDelegate

class CreateController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: CreatePresenter!
    
    var formView: ScrollableFormView!
    var photoBanner: PhotoBannerView!
    var titleSection: TitleFieldView!
    var priceSection: FormFieldView!
    var descriptionSection: DescriptionFieldView!
    var contactSection: ContactSectionView!
    var publishButton: PrimaryButton!

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
            descriptionSection.setCounter("\(fromDescription)/\(toDescription)")
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
           
            descriptionSection.setCounter("\(fromDescriptionCounter)/\(toDescriptionCounter)")
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
        
        photoBanner.delegate = self
        publishButton.delegate = self
     
        titleSection.delegate = presenter
        descriptionSection.delegate = presenter
    }
}

// MARK: Form Blocks Delegates
extension CreateController: PhotoBannerViewDelegate {
    func photoBannerViewDidTap(_ banner: PhotoBannerView) {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension CreateController: PrimaryButtonDelegate {
    func primaryButtonDidTap() {
        presenter.publish(
            form: AddForm(
                image: photoBanner.image,
                title: titleSection.trimmedText,
                price: priceSection.textField.text.trimmed,
                description: descriptionSection.trimmedText,
                contactName: contactSection.trimmedName,
                phoneNumber: contactSection.trimmedPhone
            )
        )
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
               
                photoBanner.setImage(image)
            }
        }
    }
}
