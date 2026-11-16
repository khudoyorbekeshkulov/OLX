//
//  CategoriesController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 16/11/26.
//

import UIKit

private enum Constants {
    static let cellHeight: CGFloat = 80
}

class CategoriesController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: CategoriesPresenter!
    var tableView: UITableView!
    
    private var categories = [Category]() {
        didSet {
            tableView.reloadData()
        }
    }
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
        installSubviews()
        setupViewController()
        presenter.viewDidLoad()
    }
}

// MARK: View Protocol Conformation
extension CategoriesController:  CategoriesViewMVP {
    
    func setupCategories(categories: [Category]) {
        DispatchQueue.main.async { [weak self] in
            self?.categories = categories
        }
    }
}

// MARK: Static Initializer
extension CategoriesController {
    
    static func instantiate() -> CategoriesController {
        let configurator = CategoriesConfiguratorImpl()
        let vc = CategoriesController(with: configurator)
        return vc
    }
}

extension CategoriesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        categories.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueCell(CategoryCell.self, for: indexPath)
        guard let category = categories[safe: indexPath.row] else { return cell }
        
        return cell.then {
            $0.cellView.backgroundColor = category.backgroundColor
            $0.image.image = category.image
            $0.image.backgroundColor = category.imageBackgroundColor
            $0.titleLabel.text = category.title
            $0.numberOfResults.text = category.result
            $0.nextImage.image = indexPath.row == 0 ? nil : UIImage(named: "ic_next")
            $0.selectionStyle = .none
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        Constants.cellHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        presenter.didSelectCategory(at: indexPath.row)
    }
}

private extension CategoriesController {
    
    func setupViewController() {
        navigationItem.title = L10n.Overall.categoryTitle
        
        tableView.then {
            $0.dataSource = self
            $0.delegate = self
        }
    }
}
