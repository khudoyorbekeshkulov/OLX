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
                image: "img_cobalt",
                title: "Cobalt sotiladi",
                numberOfSales: "150 million so'm",
                locationAndTime: "Бухара. \(L10n.Detail.postedTimeToday) 12:01",
                productOwner: "Алишер",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "\(L10n.Detail.onlineTime) 12:02"
            ),
            
            CategoryItem(
                image: "img_salen_home",
                title: "Дом на продажу",
                numberOfSales: "2 миллиард 240 миллиона сумов",
                locationAndTime: "Ташкент. \(L10n.Detail.postedTimeYesterday) 18:12",
                productOwner: "Алекс",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "\(L10n.Detail.onlineTime) 12:02"
            ),
            
            CategoryItem(
                image: "img_gentra",
                title: "Гентра на продажу",
                numberOfSales: "164 миллиона сумов",
                locationAndTime: "Ташкент. \(L10n.Detail.postedTimeYesterday) 23:59",
                productOwner: "Достон",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "\(L10n.Detail.onlineTime) 12:02"
            ),
            
            CategoryItem(
                image: "img_nexia2",
                title: "Нексия 2 на продажу",
                numberOfSales: "70 миллиона сумов",
                locationAndTime: "Самарканд. \(L10n.Detail.postedTimeYesterday) 12:01",
                productOwner: "Лазиз",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "\(L10n.Detail.onlineTime) 12:02"
            ),
            
            CategoryItem(
                image: "img_spark",
                title: "Spark sotiladi",
                numberOfSales: "96 million so'm",
                locationAndTime: "Ташкент. \(L10n.Detail.postedTimeToday) 9:06",
                productOwner: "Али",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "\(L10n.Detail.onlineTime) 12:02"
            ),
            
            CategoryItem(
                image: "img_nexia3",
                title: "Nexia 3 sotiladi",
                numberOfSales: "126 million so'm",
                locationAndTime: "Ташкент. \(L10n.Detail.postedTimeToday) 11:56",
                productOwner: "Бехзод",
                infoProduct: "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67",
                online: "\(L10n.Detail.onlineTime) 12:02"
            ),
        ]
    }
}
