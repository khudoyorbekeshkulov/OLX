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
                backgroundColor: "white",
            ),
            
            CategoryMainProductsChapter (
                image: "home",
                title: "Недвижимость",
                result: "28341 результатов",
                backgroundColor: "white",
            ),
            
            CategoryMainProductsChapter (
                image: "stroller",
                title: "Детский мир",
                result: "44123 результатов",
                backgroundColor: "lightGreen",
            ),
            
            CategoryMainProductsChapter(
                image: "dress",
                title: "Одежда и обувь",
                result: "18934 результатов",
                backgroundColor: "yellow",
            ),
            
            CategoryMainProductsChapter (
                image: "car",
                title: "Автомобили",
                result: "7123 результатов",
                backgroundColor: "lightGray",
            ),
            
            CategoryMainProductsChapter (
                image: "cat",
                title: "Животные",
                result: "5473 результатов",
                backgroundColor: "lightBlue",
            ),
            
            CategoryMainProductsChapter (
                image: "phone",
                title: "Электроника",
                result: "3573 результатов",
                backgroundColor: "lightOrange",
            ),
        ]
    }
}
