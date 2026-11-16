//  
//  HomePageConfigurator.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 03/11/26.
//

import Foundation

protocol HomePageConfigurator {
    func configure(_ controller: HomePageController)
}

class HomePageConfiguratorImpl: HomePageConfigurator {
    
    func configure(_ controller: HomePageController) {
        let router: HomePageRouter = HomePageRouterImpl(controller)
        
        let presenter: HomePagePresenter = HomePagePresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
