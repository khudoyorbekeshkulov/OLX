//  
//  HomePageController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 03/11/26.
//

import UIKit

class HomePageController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: HomePagePresenter!
    var searchContainer: ExpandingContainerView!
    var searchingTextField: UITextField!
    var collectionViewLayout: UICollectionViewFlowLayout!
    var mainCollectionView: UICollectionView! 
    // swiftlint:enable implicitly_unwrapped_optional
    private init(with configurator: HomePageConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UIViewController Lifecycle
extension HomePageController: HomePageViewInstaller {
    
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        installSubviews()
        presenter.viewDidLoad()
    }
    
}

// MARK: View Protocol Conformation
extension HomePageController: HomePageView {
    func updateSquareBackground() {
        DispatchQueue.main.async {
            
        }
    }
}

// MARK: Static Initializer
extension HomePageController {
    static func instantiate() -> HomePageController {
        let configurator = HomePageConfiguratorImpl()
        let vc = HomePageController(with: configurator)
        return vc
    }
}
