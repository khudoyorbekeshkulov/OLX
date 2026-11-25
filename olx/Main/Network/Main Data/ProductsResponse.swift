//
//  ProductsResponse.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 25/11/26.
//

import Foundation

struct ProductsResponse: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let rating: Double
    let brand: String?
    let thumbnail: String
}
