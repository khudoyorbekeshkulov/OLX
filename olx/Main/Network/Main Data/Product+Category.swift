//
//  Product+Category.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 25/11/26.
//

import UIKit

extension Product {
    func toCategory() -> Category {
        Category(
            image: nil,
            title: title,
            priceNumbers: String(format: "$%.2f", price),
            locationAndTime: category.capitalized,
            contactName: brand,
            descriptionProduct: description,
        )
    }
}
