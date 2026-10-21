//
//  UICollectionView+Extensions.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 21/10/26.
//

import UIKit

public extension UICollectionView {
    func register(cellType: (some UICollectionViewCell).Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }

    func cellForItem<Cell: UICollectionViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        let cellAt = self.cellForItem(at: indexPath)
        guard let typedCell = cellAt as? Cell else {
            fatalError(
                "Wrong cell type \(String(describing: cellAt.self)) for identifier \(String(describing: cell))"
            )
        }
        return typedCell
    }
}
