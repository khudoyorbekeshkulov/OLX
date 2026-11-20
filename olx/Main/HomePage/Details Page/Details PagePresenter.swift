//  
//  Details PagePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import Foundation

protocol Details_PageView: AnyObject {
    
}

protocol Details_PagePresenter {
    func viewDidLoad()
}

class Details_PagePresenterImpl: Details_PagePresenter {
    
    private weak var view: Details_PageView?
    private let router: Details_PageRouter
    
    init(view: Details_PageView, router: Details_PageRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {

    }
}
