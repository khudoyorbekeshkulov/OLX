//  
//  CreatePageConfigurator.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 05/11/26.
//

import Foundation

protocol CreateConfigurator {
    func configure(_ controller: CreateController)
}

class CreatePageConfiguratorImpl: CreateConfigurator {
    
    func configure(_ controller: CreateController) {
        let router: CreateRouter = CreatePageRouterImpl(controller)
        
        let presenter: CreatePagePresenter = CreatePagePresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
