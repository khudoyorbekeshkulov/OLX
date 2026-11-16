//
//  CategoriesPresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import FactoryKit

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
    
    @Injected(\.categoriesUsecase)
    private var categoriesUsecase: CategoriesUsecase
    
    init(view: CategoriesViewMVP, router: CategoriesRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        fetchCategories()
    }
    
    func didSelectCategory(at index: Int) {
        guard index != 0 else { return }
        router.openSelectedCategory()
    }
}

private extension CategoriesPresenterImpl {
    func fetchCategories() {
        Task {
            do {
                let categories = try await categoriesUsecase.getCategories()
                
                await MainActor.run {
                    view?.setupCategories(categories: categories)
                }
            } catch {
                // TODO: Here capture error, and show user alert or toast
            }
        }
    }
}
