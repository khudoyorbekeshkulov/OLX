//  
//  Details PagePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import Foundation

protocol DetailViewMVP: AnyObject {
    
}

protocol DetailPresenter {
    func viewDidLoad()
}

class Details_PagePresenterImpl: DetailPresenter {
    
    private weak var view: DetailViewMVP?
    private let router: DetailRouter
    
    init(view: DetailViewMVP, router: DetailRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {

    }
}
