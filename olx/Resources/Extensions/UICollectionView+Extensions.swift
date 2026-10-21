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

    func dequeueCell<Cell: UICollectionViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        let dequeuedCell = dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath)
        guard let typedCell = dequeuedCell as? Cell else {
            fatalError(
                "Wrong cell type \(String(describing: dequeuedCell.self)) for identifier \(String(describing: cell))"
            )
        }
        return typedCell
    }

    // MARK: - Supplementary views (headers / footers)

    func register(supplementaryViewType: (some UICollectionReusableView).Type, ofKind kind: String) {
        register(
            supplementaryViewType,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: String(describing: supplementaryViewType)
        )
    }

    func dequeueSupplementaryView<View: UICollectionReusableView>(
        _ viewType: View.Type,
        ofKind kind: String,
        for indexPath: IndexPath
    ) -> View {
        let dequeuedView = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: viewType),
            for: indexPath
        )
        guard let typedView = dequeuedView as? View else {
            fatalError(
                "Wrong view type \(String(describing: dequeuedView.self)) for identifier \(String(describing: viewType))"
            )
        }
        return typedView
    }
}
