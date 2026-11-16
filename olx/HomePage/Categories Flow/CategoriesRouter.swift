//
//  CategoriesRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import UIKit

protocol CategoriesRouter {
    func openSelectedCategory()
}

class CategoriesRouterImpl: CategoriesRouter {
    
    private weak var controller: CategoriesController?
    
    init(_ controller: CategoriesController?) {
        self.controller = controller
    }
    
    func openSelectedCategory() {
        controller?.navigationController?.pushViewController(
            SelectedCategoryController(),
            animated: true
        )
    }
}
