//  
//  ProfileConfigurator.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 04/11/26.
//

import Foundation

protocol ProfileConfigurator {
    func configure(_ controller: ProfileController)
}

class ProfileConfiguratorImpl: ProfileConfigurator {
    
    func configure(_ controller: ProfileController) {
        let router: ProfileRouter = ProfileRouterImpl(controller)
        
        let presenter: ProfilePresenter = ProfilePresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
