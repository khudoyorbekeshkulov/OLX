//  
//  HomePageRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 03/11/26.
//

import Foundation

protocol HomePageRouter {
    
}

class HomePageRouterImpl: HomePageRouter {
    
    private weak var controller: HomePageController?
    
    init(_ controller: HomePageController?) {
        self.controller = controller
    }
    
}
