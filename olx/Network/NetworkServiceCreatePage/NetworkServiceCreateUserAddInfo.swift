//
//  NetworkServiceAddUserInfo.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 27/10/26.
//

import UIKit

struct AddForm {
    let image: UIImage?
    let title: String
    let price: String
    let description: String
    let contactName: String
    let phone: String
    let id = UUID()
}

struct NetworkServiceAddUserInfo: Encodable {
    let image: String?
    let title: String
    let price: String
    let description: String
    let contactName: String
    let phone: String
}

extension AddForm {
    var toNetworkModel: NetworkServiceAddUserInfo {
        NetworkServiceAddUserInfo(
            image: image?.jpegData(compressionQuality: 0.7)?.base64EncodedString(),
            title: title,
            price: price,
            description: description,
            contactName: contactName,
            phone: phone
        )
    }
}
