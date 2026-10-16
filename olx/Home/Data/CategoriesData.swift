import UIKit

struct Category {
    let image: UIImage?
    let title: String
    let result: String?
    let backgroundColor: UIColor?
    let imageBackgroundColor: UIColor?
    let numberOfSales: String?
    let locationAndTime: String?
    let productOwner: String?
    let infoProduct: String?
    let online: String?
    
    init(
        image: UIImage?,
        title: String,
        result: String? = nil,
        backgroundColor: UIColor? = nil,
        imageBackgroundColor: UIColor? = nil,
        numberOfSales: String? = nil,
        locationAndTime: String? = nil,
        productOwner: String? = nil,
        infoProduct: String? = nil,
        online: String? = nil
    ) {
        self.image = image
        self.title = title
        self.result = result
        self.backgroundColor = backgroundColor
        self.imageBackgroundColor = imageBackgroundColor
        self.numberOfSales = numberOfSales
        self.locationAndTime = locationAndTime
        self.productOwner = productOwner
        self.infoProduct = infoProduct
        self.online = online
    }
}
