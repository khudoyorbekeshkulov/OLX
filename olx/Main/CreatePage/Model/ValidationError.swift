//
//  ValidationError.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 10/11/26.
//

import Foundation

enum ValidationError {
    case titleTooShort(Int)
    case descriptionTooShort(Int)
    case contactNameMissing
    case photoMissing
    
    var message: String {
        switch self {
        case let .titleTooShort(minLength):
            return "Введите не менее \(minLength) символов в заголовке"
        case let .descriptionTooShort(minLength):
            return "Введите не менее \(minLength) символов в описании"
        case .contactNameMissing:
            return "Укажите контактное лицо"
        case .photoMissing:
            return "Добавьте фото"
        }
    }
}

