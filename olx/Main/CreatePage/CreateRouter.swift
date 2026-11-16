//
//  CreateRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 09/11/26.
//

import UIKit

protocol CreateRouter {
    func showHome()
    func showAlert(message: String)
}

class CreateRouterImpl: CreateRouter {
    
    private enum Constants {
        static let homeTabIndex = 0
    }
    
    private weak var controller: CreateController?
    
    init(_ controller: CreateController?) {
        self.controller = controller
    }
    
    func showHome() {
        controller?.tabBarController?.selectedIndex = Constants.homeTabIndex
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        controller?.present(alert, animated: true)
    }
}
