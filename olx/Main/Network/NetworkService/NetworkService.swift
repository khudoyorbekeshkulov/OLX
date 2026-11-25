//
//  NetworkService.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 25/11/26.
//

import Foundation
import Alamofire

final class NetworkService {
    
    func fetchProducts(completion: @escaping (Result<[Product], AFError>) -> Void) {
        let url = "https://dummyjson.com/products"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: ProductsResponse.self) { response in
                switch response.result {
                case.success(let data):
                    completion(.success(data.products))
                case.failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
