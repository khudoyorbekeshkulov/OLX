//
//  CategoriesData.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/10/26.
//

import UIKit

final class CategoriesDataHomePage {
    static let shared = CategoriesDataHomePage()
    private init() {}
    
    static let categories: [Category] = [
        Category(
            image: UIImage(named: "img_olx"),
            title: L10n.AllGategories.allListingsLabel
        ),
        Category(
            image: UIImage(named: "img_home"),
            title: L10n.AllGategories.realEstateLabel
        ),
        Category(
            image: UIImage(named: "img_stroller"),
            title: L10n.AllGategories.childrenWorldLabel,
            imageBackgroundColor: UIColor(hex: "#FFCC00")
        ),
        Category(
            image: UIImage(named: "img_dress"),
            title: L10n.AllGategories.clothesLabel
        ),
        Category(
            image: UIImage(named: "img_car_chapter"),
            title: L10n.AllGategories.carsLabel
        )
    ]
}
