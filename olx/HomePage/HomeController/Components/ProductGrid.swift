//
//  ProductGrit.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 25/10/26.
//

import UIKit

enum ProductGrid {
    static let sideInset: CGFloat = 13
    static let interitemSpacing: CGFloat = 10
    static let lineSpacing: CGFloat = 15
    static let minItemWidth: CGFloat = 160
    
    static func itemSize(for width: CGFloat) -> CGSize {
        let available = width - ProductGrid.sideInset * 2
        let spacing = ProductGrid.interitemSpacing
        let columns = max(2, Int((available + spacing) / (ProductGrid.minItemWidth + spacing)))
        let itemWidth = floor((available - spacing * CGFloat(columns - 1)) / CGFloat(columns))
        return CGSize(width: itemWidth, height: RecommendedCell.height(forWidth: itemWidth))
    }
}
