//
//  UITableView+Extensions.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 21/10/26.
//

import UIKit

public extension UITableView {
    func register(cellType: (some UITableViewCell).Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
    
    func dequeueCell<Cell: UITableViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        let dequeuedCell = dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath)
        guard let typedCell = dequeuedCell as? Cell else {
            fatalError(
                "Wrong cell type \(String(describing: dequeuedCell.self)) for identifier \(String(describing: cell))"
            )
        }
        return typedCell
    }
}
