//
//  CategoriesUsecase.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import FactoryKit

protocol CategoriesUsecase {
    func getCategories() async throws -> [Category]
    func getRecommendedProducts() async throws -> [Category]
}

class CategoriesUsecaseImpl: CategoriesUsecase {
   
    @Injected(\.categoriesGateway)
    private var categoriesGateway: CategoriesGateway
    
    func getCategories() async throws -> [Category] {
        let categories = try await categoriesGateway.getCategories()
        return categories
    }
    
    func getRecommendedProducts() async throws -> [Category] {
        let recommendedProducts = try await categoriesGateway.getRecommandedProducts()
        return recommendedProducts
    }
}
