//  
//  CategoriesViewInstaller.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import UIKit
import SnapKit

protocol CategoriesViewInstaller: ViewInstaller {
    var tableView: UITableView! { get set }
}

extension CategoriesViewInstaller {
    
    func initSubViews() {
        mainView.backgroundColor = ColorResourceManager.shared.cardBackground
        
        tableView = .init().then {
            $0.register(cellType: CategoryCell.self)
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
        }
    }
    
    func addSubViews() {
        mainView.addSubview(tableView)
    }
    
    func addSubViewConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
