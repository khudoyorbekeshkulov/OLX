//  
//  CreatePagePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 05/11/26.
//

import Foundation

protocol CreateViewMVP: AnyObject {
    
}

protocol CreatePagePresenter {
    func viewDidLoad()
}

class CreatePagePresenterImpl: CreatePagePresenter {
    
    private weak var view: CreateViewMVP?
    private let router: CreateRouter
    
    init(view: CreateViewMVP, router: CreateRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {

    }
}
