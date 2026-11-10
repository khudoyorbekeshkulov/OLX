//
//  CreatePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import Foundation

private enum Constants {
    static let titleMinLength = 5
    static let titleMaxLength = 70
    static let descriptionMinLength = 10
    static let descriptionMaxLength = 9000
    static let negotiablePrice = "Договорная"
    static let justNowLabel = "Только что"
}

protocol CreateView: AnyObject {
    func setupLabelDetails(
        fromTitleCounter: Int,
        toTitleCounter: Int,
        fromDescriptionCounter: Int,
        toDescriptionCounter: Int
    )
    
    func setupTitleCounter(
        fromTitleCounter: Int,
        toTitleCounter: Int
    )
    
    func setupDescriptionCounter(
        fromDescriptionCounter: Int,
        toDescriptionCounter: Int
    )
}

protocol CreatePresenter: CreateControllerProtocols {
    func viewDidLoad()
    func updateTitleCounter(counter: Int)
    func updateDescriptionCounter(counter: Int)
    func publish(form: AddForm)
}

class CreatePresenterImpl: CreatePresenter {
    
    private weak var view: CreateView?
    private let router: CreateRouter
    
    init(view: CreateView, router: CreateRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupLabelDetails(
            fromTitleCounter: 0,
            toTitleCounter: Constants.titleMaxLength,
            fromDescriptionCounter: 0,
            toDescriptionCounter: Constants.descriptionMaxLength
        )
    }
    
    func updateTitleCounter(counter: Int) {
        view?.setupTitleCounter(
            fromTitleCounter: counter,
            toTitleCounter: Constants.titleMaxLength
        )
    }
    
    func updateDescriptionCounter(counter: Int) {
        view?.setupDescriptionCounter(
            fromDescriptionCounter: counter,
            toDescriptionCounter: Constants.descriptionMaxLength
        )
    }
    
    func publish(form: AddForm) {
        guard form.title.count >= Constants.titleMinLength else { return fail(.titleTooShort(Constants.titleMinLength)) }
        guard form.description.count >= Constants.descriptionMinLength else { return fail(.descriptionTooShort(Constants.descriptionMinLength)) }
        guard !form.contactName.isEmpty else { return fail(.contactNameMissing) }
        guard let image = form.image else { return fail(.photoMissing) }
        
        let listing = Category(
            image: image,
            title: form.title,
            priceNumbers: form.price.isEmpty ? Constants.negotiablePrice : form.price,
            phoneNumber: form.phoneNumber,
            locationAndTime: Constants.justNowLabel,
            contactName: form.contactName,
            descriptionProduct: form.description
        )
        
        ListingsService.shared.add(listing)
        router.showHome()
    }
}

private extension CreatePresenterImpl {
    func fail(_ error: ValidationError) {
        router.showAlert(message: error.message)
    }
}

extension CreatePresenterImpl {
    func titleFieldView(didChangeText text: String) {
        updateTitleCounter(counter: text.count)
    }
    
    func descriptionFieldView(didChangeText text: String) {
        updateDescriptionCounter(counter: text.count)
    }
}
