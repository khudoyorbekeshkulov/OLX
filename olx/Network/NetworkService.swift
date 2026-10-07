//
//  NetworkService.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 06/10/26.
//

import Foundation

protocol NetworkServiceProvider {
    func getCategories() -> [CategoryItem]
}

final class NetworkServiceImplementation: NetworkServiceProvider {
    static let shared = NetworkServiceImplementation()
    private init() {}
    
    func getCategories() -> [CategoryItem] {
        [
            CategoryItem(
                image: "cobalt",
                title: "Cobalt sotiladi",
                numberOfSales: "150 million so'm",
                locationAndTime: "Бухара. Сегодня 12:01",
                productOwner: "Алишер",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "Онлайн в 12:02"
            ),
            
            CategoryItem(
                image: "salenHome",
                title: "Дом на продажу",
                numberOfSales: "2 миллиард 240 миллиона сумов",
                locationAndTime: "Ташкент. Вчера 18:12",
                productOwner: "Алекс",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "Онлайн в 12:02"
            ),
            
            CategoryItem(
                image: "gentra",
                title: "Гентра на продажу",
                numberOfSales: "164 миллиона сумов",
                locationAndTime: "Ташкент. Вчера 23:59",
                productOwner: "Достон",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "Онлайн в 12:02"
            ),
            
            CategoryItem(
                image: "nexia2",
                title: "Нексия 2 на продажу",
                numberOfSales: "70 миллиона сумов",
                locationAndTime: "Самарканд. 14 августа 12:01",
                productOwner: "Лазиз",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "Онлайн в 12:02"
            ),
            
            CategoryItem(
                image: "spark",
                title: "Spark sotiladi",
                numberOfSales: "96 million so'm",
                locationAndTime: "Ташкент. Сегодня 9:06",
                productOwner: "Али",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "Онлайн в 12:02"
            ),
            
            CategoryItem(
                image: "nexia3",
                title: "Nexia 3 sotiladi",
                numberOfSales: "126 million so'm",
                locationAndTime: "Ташкент. Сегодня 11:56",
                productOwner: "Бехзод",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "Онлайн в 12:02"
            ),
        ]
    }
}
