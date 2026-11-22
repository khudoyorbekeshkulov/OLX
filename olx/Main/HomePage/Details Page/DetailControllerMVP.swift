//  
//  Details PageController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import UIKit


class DetailControllerMVP: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: DetailPresenter!
    
    var image: ProductImageView!
    var infoFrame: UIView!
    var productDetails: ProductDetails!
    var userDetails: UserDetails!
    var authorActions: AuthorActions!
    var layout: UICollectionViewFlowLayout!
    var similarAdsCollection: SimilarAdsCollection!
    // swiftlint:enable implicitly_unwrapped_optional
    private init(with configurator: DetailConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UIViewController Lifecycle
extension DetailControllerMVP: DetailViewInstaller {
    
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        installSubviews()
    }
    
}

// MARK: View Protocol Conformation
extension DetailControllerMVP:  DetailViewMVP {
    
}

// MARK: Static Initializer
extension DetailControllerMVP {
    
    static func instantiate() -> DetailControllerMVP {
        let configurator = Details_PageConfiguratorImpl()
        let vc = DetailControllerMVP(with: configurator)
        return vc
    }
    
}
