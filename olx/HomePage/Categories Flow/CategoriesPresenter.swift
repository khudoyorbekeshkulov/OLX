//
//  CategoriesPresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import Foundation

protocol CategoriesViewMVP: AnyObject {
    func setupCategories(categories: [Category])
}

protocol CategoriesPresenter {
    func viewDidLoad()
    func didSelectCategory(at index: Int)
}

class CategoriesPresenterImpl: CategoriesPresenter {
    
    private weak var view: CategoriesViewMVP?
    private let router: CategoriesRouter
    
    init(view: CategoriesViewMVP, router: CategoriesRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        let categories = NetworkServiceMainProductChapterImplementation
            .shared
            .getCategoriesAllInfo()
            .toCategoryMainProductsChapter
        
        view?.setupCategories(categories: categories)
    }
    
    func didSelectCategory(at index: Int) {
        guard index != 0 else { return }
        router.openSelectedCategory()
    }
}
