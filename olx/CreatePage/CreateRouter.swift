//  
//  CreatePageRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 05/11/26.
//

import Foundation

protocol CreateRouter {
    
}

class CreatePageRouterImpl: CreateRouter {
    
    private weak var controller: CreateController?
    
    init(_ controller: CreateController?) {
        self.controller = controller
    }
    
}
