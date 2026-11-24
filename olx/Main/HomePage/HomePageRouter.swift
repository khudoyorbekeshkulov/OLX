//  
//  HomePageRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 03/11/26.
//

import UIKit

class HomePageRouterImpl: HomePageRouter {
    
    private weak var controller: HomePageController?
    
    init(_ controller: HomePageController?) {
        self.controller = controller
    }
    
    func openAllCategories() {
        controller?.navigationController?.pushViewController(
            CategoriesController.instantiate(),
            animated: true
        )
    }
        
    func openDetails(category: Category, categories: [Category]) {
        let detailVC = DetailController.instantiate(category: category, categories: categories)
        controller?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
