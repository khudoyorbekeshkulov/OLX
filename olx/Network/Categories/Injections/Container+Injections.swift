//
//  Container+Injections.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import FactoryKit

@MainActor
extension Container {
    var categoriesGateway: Factory<CategoriesGateway> {
         self { CategoriesGatewayImpl() }
    }
    
    var categoriesUsecase: Factory<CategoriesUsecase> {
         self { CategoriesUsecaseImpl() }
    }
}
