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

}

protocol CreatePresenter {
    func viewDidLoad()
}

class CreatePresenterImpl: CreatePresenter {
    
    private weak var view: CreateView?
    private let router: CreateRouter
    
    init(view: CreateView, router: CreateRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {

    }
}
