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
                image: "olxImage",
                title: "Все обявления",
                result: "634123 результатов",
                backgroundColor: "#FFFFFF",
            ),
            
            CategoryMainProductsChapter (
                image: "home",
                title: "Недвижимость",
                result: "28341 результатов",
                backgroundColor: "#EBFAF0",
            ),
            
            CategoryMainProductsChapter (
                image: "stroller",
                title: "Детский мир",
                result: "44123 результатов",
                backgroundColor: "#FDF6DE",
            ),
            
            CategoryMainProductsChapter(
                image: "dress",
                title: "Одежда и обувь",
                result: "18934 результатов",
                backgroundColor: "#F0F7F7",
            ),
            
            CategoryMainProductsChapter (
                image: "car",
                title: "Автомобили",
                result: "7123 результатов",
                backgroundColor: "#E1F0FF",
            ),
            
            CategoryMainProductsChapter (
                image: "cat",
                title: "Животные",
                result: "5473 результатов",
                backgroundColor: "#FFF3E6",
            ),
            
            CategoryMainProductsChapter (
                image: "phone",
                title: "Электроника",
                result: "3573 результатов",
                backgroundColor: "#F3EBFF",
            ),
        ]
    }
}
