//  
//  CategoriesPresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import Foundation

protocol CategoriesView: AnyObject {
    
}

protocol CategoriesPresenter {
    func viewDidLoad()
}

class CategoriesPresenterImpl: CategoriesPresenter {
    
    private weak var view: CategoriesView?
    private let router: CategoriesRouter
    
    init(view: CategoriesView, router: CategoriesRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {

    }
}
