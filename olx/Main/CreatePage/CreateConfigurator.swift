//  
//  CreateConfigurator.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import Foundation

protocol CreateConfigurator {
    func configure(_ controller: CreateController)
}

class CreateConfiguratorImpl: CreateConfigurator {
    
    func configure(_ controller: CreateController) {
        let router: CreateRouter = CreateRouterImpl(controller)
        
        let presenter: CreatePresenter = CreatePresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
