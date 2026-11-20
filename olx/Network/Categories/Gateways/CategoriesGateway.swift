//
//  CategoriesGateway.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import Foundation

protocol CategoriesGateway {
    func getCategories() async throws -> [Category]
    func getRecommandedProducts() async throws -> [Category]
}

class CategoriesGatewayImpl: CategoriesGateway {
    
    func getCategories() async throws -> [Category] {
        let categories = NetworkServiceMainProductChapterImplementation
            .shared
            .getCategoriesAllInfo()
            .toCategoryMainProductsChapter
        
        return categories
    }
    
    func getRecommandedProducts() async throws -> [Category] {
        let recommendedProducts = NetworkServiceImplementation
            .shared
            .getCategories()
            .toCategories
        
        return recommendedProducts
    }
}
