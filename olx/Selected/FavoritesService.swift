//
//  FavoritesService.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 21/10/26.
//

import Foundation

final class FavoritesService {
    static let shared = FavoritesService()
    private init(){}
    
    private(set) var items = [Category]()
    
    func contains(_ category: Category) -> Bool {
        items.contains { $0.id == category.id }
    }
    
    func toggle(_ category: Category) {
        if let index = items.firstIndex(where: { $0.id == category.id }) {
            items.remove(at: index)
        } else {
            items.append(category)
        }
    }
}
