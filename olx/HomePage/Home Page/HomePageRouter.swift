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
            CategoriesViewController(),
            animated: true
        )
    }
        
    func openDetails(category: Category, categories: [Category]) {
        let detailVC = DetailViewController().then{
            $0.category = category
            $0.categories = categories
        }
        controller?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
