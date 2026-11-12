//  
//  HomePagePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 03/11/26.
//

import Foundation

protocol HomePageView: AnyObject {
    func setupCategories(categories: [Category])
}

protocol HomePageRouter: AnyObject {
    func openAllCategories()
    func openDetails(category: Category, categories: [Category])
}

protocol HomePagePresenter {
    func viewDidLoad()
    func openAllCategories()
    func openDetails(category: Category)
}

class HomePagePresenterImpl: HomePagePresenter {
    
    private weak var view: HomePageView?
    private let router: HomePageRouter
    private var categories = [Category]()
    
    init(view: HomePageView, router: HomePageRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        categories = NetworkServiceImplementation.shared.getCategories().toCategories
        
        view?.setupCategories(categories: categories)
    }
    
    func openAllCategories() {
        router.openAllCategories()
    }
    
    func openDetails(category: Category) {
        router.openDetails(category: category, categories: categories)
    }
}
