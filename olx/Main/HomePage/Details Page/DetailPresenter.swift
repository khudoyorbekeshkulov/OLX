//  
//  Details PagePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import Foundation

protocol DetailViewMVP: AnyObject {
    func setupDetails(category: Category)
    func reloadSimilarAds()
    func setFavorite(_ isFavorite: Bool)
}

protocol DetailPresenter {
    func viewDidLoad()
    var numberOfSimilarAds: Int { get }
    func similarAd(at index: Int) -> Category?
    func isFavorite(_ category: Category) -> Bool
    func toggleFavorite(_ category: Category)
    func didTapFavorite()
    func didTapOwner()
    func didSelectSimilarAd(at index: Int)
}

class Details_PagePresenterImpl: DetailPresenter {

    private weak var view: DetailViewMVP?
    private let router: DetailRouter
    private let category: Category
    private let categories: [Category]
    
    private var products: [Category] {
        ListingsService.shared.items + categories
    }
    
    init(view: DetailViewMVP, router: DetailRouter, category: Category, categories: [Category]) {
        self.view = view
        self.router = router
        self.category = category
        self.categories = categories
    }
    
    func viewDidLoad() {
        view?.setupDetails(category: category)
        view?.reloadSimilarAds()
        view?.setFavorite(FavoritesService.shared.contains(category))
    }
    
    var numberOfSimilarAds: Int {
        products.count
    }
    
    func similarAd(at index: Int) -> Category? {
        products[safe: index]
    }
    
    func isFavorite(_ category: Category) -> Bool {
        FavoritesService.shared.contains(category)
    }
    
    func toggleFavorite(_ category: Category) {
        FavoritesService.shared.toggle(category)
    }
    
    func didTapFavorite() {
        toggleFavorite(category)
        view?.setFavorite(isFavorite(category))
    }
    
    func didTapOwner() {
        router.openMessage(ownerName: category.contactName ?? "")
    }
    
    func didSelectSimilarAd(at index: Int) {
        guard let selected = similarAd(at: index) else { return }
        router.openDetails(category: selected, categories: categories)
    }
}
