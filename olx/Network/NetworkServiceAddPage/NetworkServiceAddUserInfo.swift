//
//  NetworkServiceAddUserInfo.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 27/10/26.
//

import UIKit

struct AddForm {
    let title: String
    let description: String
    let contactName: String
    let email: String
    let phone: String
    let image: UIImage?
}

struct NetworkServiceAddUserInfo: Encodable {
    let title: String
    let description: String
    let contactName: String
    let email: String
    let phone: String
    let imageBase64: String?
}

extension AddForm {
    var toNetworkModel: NetworkServiceAddUserInfo {
        NetworkServiceAddUserInfo(
            title: title,
            description: description,
            contactName: contactName,
            email: email,
            phone: phone,
            imageBase64: image?.jpegData(compressionQuality: 0.7)?.base64EncodedString()
        )
    }
}
