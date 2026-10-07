//
//  CategoryItem.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 06/10/26.
//

import UIKit

struct CategoryItem {
    let image: String
    let title: String
    let numberOfSales: String
    let locationAndTime: String
    let productOwner: String
    let infoProduct: String
    let online: String
}

extension [CategoryItem] {
    var toCategories: [Category] {
        self.map { product in
            Category(
                image: UIImage(named: product.image),
                title: product.title,
                numberOfSales: product.numberOfSales,
                locationAndTime: product.locationAndTime,
                productOwner: product.productOwner,
                infoProduct: product.infoProduct,
                online: product.online
            )
        }
    }
}
