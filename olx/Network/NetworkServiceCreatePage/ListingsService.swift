//
//  ListingsService.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 28/10/26.
//

import UIKit

final class ListingsService {
    static let shared = ListingsService()
    private init() {}
    
    private(set) var items = [Category]()
    
    func add(_ category: Category) {
        items.insert(category, at: 0)
    }
}
