//
//  Collection+Extensions.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 21/10/26.
//

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    var nilIfEmpty: Self? {
        isEmpty ? nil : self
    }
}
