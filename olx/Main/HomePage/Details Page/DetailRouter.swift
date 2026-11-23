//  
//  Details PageRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import UIKit

protocol DetailRouter {
    func openMessage(ownerName: String)
    func openDetails(category: Category, categories: [Category])
}

class Details_PageRouterImpl: DetailRouter {
    
    private weak var controller: DetailControllerMVP?
    
    init(_ controller: DetailControllerMVP?) {
        self.controller = controller
    }
    
    func openMessage(ownerName: String) {
        let messageVC = MessageViewController(navigationTitle: ownerName)
        controller?.navigationController?.pushViewController(messageVC, animated: true)
    }
    
    func openDetails(category: Category, categories: [Category]) {
        let detailVC = DetailControllerMVP.instantiate(category: category, categories: categories)
        controller?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
