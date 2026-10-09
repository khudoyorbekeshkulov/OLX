import UIKit

struct CategoryAllProductInfo {
    let image: String
    let title: String
    let result: String
    let backgroundColor: String
}

extension [CategoryAllProductInfo] {
    var toCategoryAllProductInfo: [Category] {
        map { product in
            Category(
                image: UIImage(named: product.image),
                title: product.title,
                result: product.result,
                backgroundColor: UIColor(named: product.backgroundColor)
            )
        }
    }
}
