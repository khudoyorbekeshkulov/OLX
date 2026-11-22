//  
//  Details PageRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import Foundation

protocol DetailRouter {
    
}

class Details_PageRouterImpl: DetailRouter {
    
    private weak var controller: DetailControllerMVP?
    
    init(_ controller: DetailControllerMVP?) {
        self.controller = controller
    }
    
}
