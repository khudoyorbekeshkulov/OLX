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
    
    private let category: Category
    private let categories: [Category]
    
    init(category: Category, categories: [Category]) {
        self.category = category
        self.categories = categories
    }
    
    func configure(_ controller: DetailControllerMVP) {
        let router: DetailRouter = Details_PageRouterImpl(controller)
        
        controller.presenter = Details_PagePresenterImpl(
            view: controller,
            router: router,
            category: category,
            categories: categories
        )
    }
    
}
