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
    var numberOfProducts: Int { get }
    func product(at index: Int) -> Category?
    func isFavorite(_ category: Category) -> Bool
    func toggleFavorite(_ category: Category)
    func openAllCategories()
    func openDetails(category: Category)
}

class HomePagePresenterImpl: HomePagePresenter {
    
    private weak var view: HomePageView?
    private let router: HomePageRouter
    private var categories = [Category]()
    
    private var products: [Category] {
        ListingsService.shared.items + categories
    }
    
    var numberOfProducts: Int{ products.count }
    
    init(view: HomePageView, router: HomePageRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        categories = NetworkServiceImplementation.shared.getCategories().toCategories
        
        view?.setupCategories(categories: categories)
    }
    
    func product(at index: Int) -> Category? {
        products[safe: index]
    }
    
    func isFavorite(_ category: Category) -> Bool {
        FavoritesService.shared.contains(category)
    }
    
    func toggleFavorite(_ category: Category) {
        FavoritesService.shared.toggle(category)
    }
    
    func openAllCategories() {
        router.openAllCategories()
    }
    
    func openDetails(category: Category) {
        router.openDetails(category: category, categories: categories)
    }
}
