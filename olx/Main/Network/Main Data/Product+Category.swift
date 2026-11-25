//
//  Product+Category.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 25/11/26.
//

import UIKit

extension Product {
    func toCategory() async -> Category {
        let image = await loadThumbnail()

        return Category(
            image: image,
            title: title,
            priceNumbers: String(format: "$%.2f", price),
            locationAndTime: category.capitalized,
            contactName: brand,
            descriptionProduct: description
        )
    }

    private func loadThumbnail() async -> UIImage? {
        guard let url = URL(string: thumbnail) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
