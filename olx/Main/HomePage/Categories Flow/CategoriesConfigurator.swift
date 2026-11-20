//  
//  CategoriesConfigurator.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import Foundation

protocol CategoriesConfigurator {
    func configure(_ controller: CategoriesController)
}

class CategoriesConfiguratorImpl: CategoriesConfigurator {
    
    func configure(_ controller: CategoriesController) {
        let router: CategoriesRouter = CategoriesRouterImpl(controller)
        
        let presenter: CategoriesPresenter = CategoriesPresenterImpl(
            view: controller,
            router: router,
        )
        
        controller.presenter = presenter
    }
    
}
