import UIKit

struct CategoryItem {
    let image: String
    let title: String
    let numberOfSales: String
    let phoneNumber: String
    let locationAndTime: String
    let productOwner: String
    let infoProduct: String
    let online: String
}

extension [CategoryItem] {
    var toCategories: [Category] {
        map { product in
            Category(
                image: UIImage(named: product.image),
                title: product.title,
                priceNumbers: product.numberOfSales,
                phoneNumber: product.phoneNumber,
                locationAndTime: product.locationAndTime,
                contactName: product.productOwner,
                descriptionProduct: product.infoProduct,
                online: product.online
            )
        }
    }
}
