//  
//  CreatePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import Foundation

private enum Constants {
    static let titleMaxLength = 70
    static let descriptionMaxLength = 9000
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

protocol CreatePresenter {
    func viewDidLoad()
    func updateTitleCounter(counter: Int)
    func updateDescriptionCounter(counter: Int)
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
}
