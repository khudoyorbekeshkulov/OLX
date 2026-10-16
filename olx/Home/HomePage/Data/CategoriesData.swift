//
//  CategoriesData.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/10/26.
//

import UIKit

enum CategoriesData {
    static let categories: [Category] = [
        Category(
            image: UIImage(named: "img_olx"),
            title: "Все объявления"
        ),
        Category(
            image: UIImage(named: "img_home"),
            title: "Недвижимость"
        ),
        Category(
            image: UIImage(named: "img_stroller"),
            title: "Детский мир",
            imageBackgroundColor: UIColor(hex: "#FFCC00")
        ),
        Category(
            image: UIImage(named: "img_dress"),
            title: "Одежда и обувь"
        ),
        Category(
            image: UIImage(named: "img_car_chapter"),
            title: "Автомобили"
        )
    ]
}
