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
                title: L10n.AllGategories.allListingsLabel,
                result: "634123 \(L10n.Overall.resultsLabel)",
                backgroundColor: "#FFFFFF",
            ),
            
            CategoryMainProductsChapter (
                image: "img_home",
                title: L10n.AllGategories.realEstateLabel,
                result: "28341 \(L10n.Overall.resultsLabel)",
                backgroundColor: "#EBFAF0",
            ),
            
            CategoryMainProductsChapter (
                image: "img_stroller",
                title: L10n.AllGategories.childrenWorldLabel,
                result: "44123 \(L10n.Overall.resultsLabel)",
                backgroundColor: "#FDF6DE",
            ),
            
            CategoryMainProductsChapter(
                image: "img_dress",
                title: L10n.AllGategories.clothesLabel,
                result: "18934 \(L10n.Overall.resultsLabel)",
                backgroundColor: "#F0F7F7",
            ),
            
            CategoryMainProductsChapter (
                image: "img_car_chapter",
                title: L10n.AllGategories.carsLabel,
                result: "7123 \(L10n.Overall.resultsLabel)",
                backgroundColor: "#E1F0FF",
            ),
            
            CategoryMainProductsChapter (
                image: "img_cat",
                title: L10n.AllGategories.animalsLabel,
                result: "5473 \(L10n.Overall.resultsLabel)",
                backgroundColor: "#FFF3E6",
            ),
            
            CategoryMainProductsChapter (
                image: "img_phone",
                title: L10n.AllGategories.electronicsLabel,
                result: "3573 \(L10n.Overall.resultsLabel)",
                backgroundColor: "#F3EBFF",
            ),
        ]
    }
}
