//  
//  Details PageConfigurator.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import Foundation

protocol Details_PageConfigurator {
    func configure(_ controller: Details_PageController)
}

class Details_PageConfiguratorImpl: Details_PageConfigurator {
    
    func configure(_ controller: Details_PageController) {
        let router: Details_PageRouter = Details_PageRouterImpl(controller)
        
        let presenter: Details_PagePresenter = Details_PagePresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
