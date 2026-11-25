//  
//  HomePagePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 03/11/26.
//

import Foundation
import FactoryKit
import Combine

protocol HomePageView: AnyObject {
    func setupCategories(categories: [Category])
    func reloadProducts()
}

protocol HomePageRouter: AnyObject {
    func openAllCategories()
    func openDetails(category: Category, categories: [Category])
}

protocol HomePagePresenter {
    func viewDidLoad()
    func viewWillAppear()
    var numberOfProducts: Int { get }
    func product(at index: Int) -> Category?
    func isFavorite(_ category: Category) -> Bool
    func toggleFavorite(_ category: Category)
    func search(text: String)
    func openAllCategories()
    func openDetails(category: Category)
    
    var loadedProductsCount: Int { get }
    func loadedProduct(at index: Int) -> Product?
}

class HomePagePresenterImpl: HomePagePresenter {
    
    private let networkService = NetworkService()
    private var loadedProducts: [Product] = []
    private var apiProducts: [Category] = []
    
    private weak var view: HomePageView?
    private let router: HomePageRouter
    private var categories = [Category]()
    private var searchText = ""
    
    private var products: [Category] {
        let all = ListingsService.shared.items + categories + apiProducts
        guard !searchText.isEmpty else { return all }
        return all.filter{ $0.title.localizedCaseInsensitiveContains(searchText)}
    }
    
    private let searchSubject = PassthroughSubject<String, Never>()
    private var cancelLabels = Set<AnyCancellable>()
    
    var numberOfProducts: Int{ products.count }
    
    @Injected(\.categoriesUsecase)
    private var categoriesUsecase: CategoriesUsecase
    
    init(view: HomePageView, router: HomePageRouter) {
        self.view = view
        self.router = router
        
        bindSearch()
    }
    
    func bindSearch() {
        searchSubject
            .map{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self else { return }
                searchText = text
                view?.reloadProducts()
            }
            .store(in: &cancelLabels)
    }
    
    func search(text: String) {
        searchSubject.send(text)
    }
    
    func viewDidLoad() {
        fetchCategories()
        
        networkService.fetchProducts { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let fetched):
                loadedProducts = fetched
                    apiProducts = fetched.map { $0.toCategory() }
                view?.reloadProducts()
            case .failure(let error):
                print("Request failed:", error)
            }
        }
    }
    
    func viewWillAppear() {
        view?.reloadProducts()
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
    
    var loadedProductsCount: Int {
        loadedProducts.count
    }
    
    func loadedProduct(at index: Int) -> Product? {
        loadedProducts[safe: index]
    }
}

private extension HomePagePresenterImpl {
    func fetchCategories() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let result = try await categoriesUsecase.getRecommendedProducts()
                
                await MainActor.run {
                    self.categories = result
                    self.view?.reloadProducts()
                }
            } catch {
                // TODO: show user alert or toast
            }
        }
    }
}
