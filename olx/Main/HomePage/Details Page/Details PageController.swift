//  
//  Details PageController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import UIKit


class Details_PageController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: Details_PagePresenter!
    // swiftlint:enable implicitly_unwrapped_optional
    private init(with configurator: Details_PageConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UIViewController Lifecycle
extension Details_PageController: Details_PageViewInstaller {
    
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        installSubviews()
    }
    
}

// MARK: View Protocol Conformation
extension Details_PageController:  Details_PageView {
    
}

// MARK: Static Initializer
extension Details_PageController {
    
    static func instantiate() -> Details_PageController {
        let configurator = Details_PageConfiguratorImpl()
        let vc = Details_PageController(with: configurator)
        return vc
    }
    
}
