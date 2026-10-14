import Foundation

protocol NetworkServiceProviderAllInfo {
    func getCategoriesAllInfo() -> [CategoryMainProductsChapter]
}

final class NetworkServiceMainProductChapterImplementation: NetworkServiceProviderAllInfo {
    static let shared = NetworkServiceMainProductChapterImplementation()
    private init() {}

    func getCategoriesAllInfo() -> [CategoryMainProductsChapter] {
        [
            CategoryMainProductsChapter (
                image: "img_olx",
                title: "Все обявления",
                result: "634123 результатов",
                backgroundColor: "#FFFFFF",
            ),
            
            CategoryMainProductsChapter (
                image: "img_home",
                title: "Недвижимость",
                result: "28341 результатов",
                backgroundColor: "#EBFAF0",
            ),
            
            CategoryMainProductsChapter (
                image: "img_stroller",
                title: "Детский мир",
                result: "44123 результатов",
                backgroundColor: "#FDF6DE",
            ),
            
            CategoryMainProductsChapter(
                image: "img_dress",
                title: "Одежда и обувь",
                result: "18934 результатов",
                backgroundColor: "#F0F7F7",
            ),
            
            CategoryMainProductsChapter (
                image: "img_car_chapter",
                title: "Автомобили",
                result: "7123 результатов",
                backgroundColor: "#E1F0FF",
            ),
            
            CategoryMainProductsChapter (
                image: "img_cat",
                title: "Животные",
                result: "5473 результатов",
                backgroundColor: "#FFF3E6",
            ),
            
            CategoryMainProductsChapter (
                image: "img_phone",
                title: "Электроника",
                result: "3573 результатов",
                backgroundColor: "#F3EBFF",
            ),
        ]
    }
}
