//
//  Details PageController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import UIKit

class DetailController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: DetailPresenter!
    
    var image: ProductImageView!
    var infoFrame: UIView!
    var productDetails: ProductDetails!
    var userDetails: UserDetails!
    var authorActions: AuthorActions!
    var headerLabel: UILabel!
    var layout: UICollectionViewFlowLayout!
    var detailCollectionView: UICollectionView!
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
extension DetailController: DetailViewInstaller {
    
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installSubviews()
        setupNavBar()
        setupCollectionView()
        setupActions()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
}

// MARK: View Protocol Conformation
extension DetailController:  DetailViewMVP {

    func setupDetails(category: Category) {
        image.configure(category: category)
        productDetails.configure(category: category)
        userDetails.configure(category: category)
    }
    
    func reloadSimilarAds() {
        detailCollectionView.reloadData()
    }
    
    func setFavorite(_ isFavorite: Bool) {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
    }
}

private extension DetailController {
    
    func setupNavBar() {
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithTransparentBackground()
        }
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(didTapHeartButton)
        )
    }
    
    func setupCollectionView() {
        detailCollectionView.register(cellType: RecommendedCell.self)
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    func setupActions() {
        userDetails.onOwnerTapped = { [weak self] in
            guard let self else { return }
            presenter.didTapOwner()
        }
    }
    
    @objc func didTapHeartButton() {
        presenter.didTapFavorite()
    }
}

extension DetailController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter.numberOfSimilarAds
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueCell(RecommendedCell.self, for: indexPath)
        guard let category = presenter.similarAd(at: indexPath.item) else { return cell }
        
        return cell.then {
            $0.setCategory(category: category)
            $0.isImpact = true
            
            $0.setFavorite(presenter.isFavorite(category))
            $0.heartTapped = { [weak self, weak cell] in
                guard let self, let cell else { return }
                presenter.toggleFavorite(category)
                cell.setFavorite(presenter.isFavorite(category))
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter.didSelectSimilarAd(at: indexPath.item)
    }
}

// MARK: Static Initializer
extension DetailController {
    
    static func instantiate(category: Category, categories: [Category]) -> DetailController {
        let configurator = Details_PageConfiguratorImpl(category: category, categories: categories)
        let vc = DetailController(with: configurator)
        return vc
    }
}
