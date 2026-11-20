//  
//  Details PageRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import Foundation

protocol Details_PageRouter {
    
}

class Details_PageRouterImpl: Details_PageRouter {
    
    private weak var controller: Details_PageController?
    
    init(_ controller: Details_PageController?) {
        self.controller = controller
    }
    
}
