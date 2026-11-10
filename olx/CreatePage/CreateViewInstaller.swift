//
//  CreateViewInstaller.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import UIKit
import SnapKit

protocol CreateViewInstaller: ViewInstaller {
    var formView: ScrollableFormView! { get set }
    var photoBanner: PhotoBannerView! { get set }
    var titleSection: TitleFieldView! { get set }
    var priceSection: FormFieldView! { get set }
    var descriptionSection: DescriptionFieldView! { get set }
    var contactSection: ContactSectionView! { get set }
    var publishButton: PrimaryButton! { get set }
}

extension CreateViewInstaller {
    
    func initSubViews() {
        mainView.backgroundColor = ColorResourceManager.shared.appBackground
        
        formView = ScrollableFormView()
        
        photoBanner = PhotoBannerView(title: L10n.Create.addPhoto)
        
        titleSection = TitleFieldView(
            title: L10n.Create.titleLabelInput,
            placeholder: L10n.Create.inputProductNameTextField,
            hint: L10n.Create.checkInputProductNameLatterNumber
        )
        
        priceSection = FormFieldView(
            title: L10n.Overall.inputPricePlaceholder,
            placeholder: L10n.Overall.inputPricePlaceholder
        ).then {
            $0.textField.keyboardType = .numberPad
        }
        
        descriptionSection = DescriptionFieldView(
            title: L10n.Overall.description,
            placeholder: L10n.Create.descriptionPlaceholderInCreateView,
            hint: L10n.Create.checkDescriptionLetterNumber
        )
        
        contactSection = ContactSectionView(
            header: L10n.Overall.contactDetailsLabel,
            nameTitle: L10n.Overall.contactPersonLabel,
            namePlaceholder: L10n.Overall.nameLabel,
            phoneTitle: L10n.Overall.phoneNumberLabel,
            phonePlaceholder: "90 123 45 67"
        )
        
        publishButton = PrimaryButton(title: L10n.Create.postAnAddButton)
    }
    
    func addSubViews() {
        mainView.addSubview(formView)
        
        formView.add(SectionHeaderLabel(text: L10n.Create.aboutYourAdvertisementTitle), after: 12)
        formView.add(photoBanner, after: 20)
        formView.add(titleSection, after: 20)
        formView.add(priceSection, after: 20)
        formView.add(descriptionSection, after: 24)
        formView.add(contactSection, after: 24)
        formView.add(publishButton)
    }
    
    func addSubViewConstraints() {
        formView.snp.makeConstraints {
            $0.top.equalTo(mainView.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
