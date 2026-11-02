import UIKit

struct Category {
    let image: UIImage?
    let title: String
    let result: String?
    let backgroundColor: UIColor?
    let imageBackgroundColor: UIColor?
    let priceNumbers: String?
    let phoneNumber: String?
    let locationAndTime: String?
    let contactName: String?
    let descriptionProduct: String?
    let online: String?
    let id = UUID()
    
    init(
        image: UIImage?,
        title: String,
        result: String? = nil,
        backgroundColor: UIColor? = nil,
        imageBackgroundColor: UIColor? = nil,
        priceNumbers: String? = nil,
        phoneNumber: String? = nil,
        locationAndTime: String? = nil,
        contactName: String? = nil,
        descriptionProduct: String? = nil,
        online: String? = nil
    ) {
        self.image = image
        self.title = title
        self.result = result
        self.backgroundColor = backgroundColor
        self.imageBackgroundColor = imageBackgroundColor
        self.priceNumbers = priceNumbers
        self.phoneNumber = phoneNumber
        self.locationAndTime = locationAndTime
        self.contactName = contactName
        self.descriptionProduct = descriptionProduct
        self.online = online
    }
}
