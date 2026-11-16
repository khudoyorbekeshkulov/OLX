//  
//  CategoriesController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import UIKit
import Core


class CategoriesController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: CategoriesPresenter!
    // swiftlint:enable implicitly_unwrapped_optional
    private init(with configurator: CategoriesConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UIViewController Lifecycle
extension CategoriesController: CategoriesViewInstaller {
    
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        installSubviews()
    }
    
}

// MARK: View Protocol Conformation
extension CategoriesController:  CategoriesView {
    
}

// MARK: Static Initializer
extension CategoriesController {
    
    static func instantiate() -> CategoriesController {
        let configurator = CategoriesConfiguratorImpl()
        let vc = CategoriesController(with: configurator)
        return vc
    }
    
}
