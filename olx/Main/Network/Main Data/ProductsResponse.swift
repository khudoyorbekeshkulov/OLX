//
//  ProductsResponse.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 25/11/26.
//

import Foundation

nonisolated struct ProductsResponse: Decodable, Sendable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

nonisolated struct Product: Decodable, Sendable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let rating: Double
    let brand: String?
    let thumbnail: String
}
