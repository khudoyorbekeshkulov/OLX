//  
//  CreateRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import Foundation

protocol CreateRouter {
    
}

class CreateRouterImpl: CreateRouter {
    
    private weak var controller: CreateController?
    
    init(_ controller: CreateController?) {
        self.controller = controller
    }
    
}
