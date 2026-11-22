//  
//  Details PageConfigurator.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import Foundation

protocol DetailConfigurator {
    func configure(_ controller: DetailControllerMVP)
}

class Details_PageConfiguratorImpl: DetailConfigurator {
    
    func configure(_ controller: DetailControllerMVP) {
        let router: DetailRouter = Details_PageRouterImpl(controller)
        
        let presenter: DetailPresenter = Details_PagePresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
