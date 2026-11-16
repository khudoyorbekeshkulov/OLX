//  
//  CategoriesRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import Foundation

protocol CategoriesRouter {
    
}

class CategoriesRouterImpl: CategoriesRouter {
    
    private weak var controller: CategoriesController?
    
    init(_ controller: CategoriesController?) {
        self.controller = controller
    }
    
}
