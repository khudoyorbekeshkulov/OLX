import UIKit

class ProductService {
    func getProducts() {
        print("Loaded products")
    }
}

class ProductsViewModel {
    private let service: ProductService
    
    init(service: ProductService) {
        self.service = service
    }
    
    func loadedProducts() {
        service.getProducts()
    }
}

let productService = ProductService()
let viewModel = ProductsViewModel(service: productService)
//viewModel.loadedProducts()
