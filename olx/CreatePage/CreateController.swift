//  
//  CreatePageController.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 05/11/26.
//

import UIKit

class CreateController: UIViewController {
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: CreatePagePresenter!
    var scrollView: UIScrollView!
    var contentView: UIView!
    var formStack: UIStackView!
    var aboutLabel: UILabel!
    var photoBanner: UIControl!
    var selectedImageView: UIImageView!
    var uploadImageView: UIImageView!
    var addPhotoLabel: UILabel!
    var photoStack: UIStackView!
    var titleLabel: UILabel!
    var titleField: UITextField!
    var titleHintLabel: UILabel!
    var titleCounter: UILabel!
    var titleHintRow: UIStackView!
    var priceLabel: UILabel!
    var priceTextField: UITextField!
    var descriptionLabel: UILabel!
    var descriptionBox: UIView!
    var descriptionView: UITextView!
    var descriptionPlaceholder: UILabel!
    var descriptionHintLabel: UILabel!
    var descriptionCounter: UILabel!
    var descriptionHintRow: UIStackView!
    var contactsLabel: UILabel!
    var contactLabel: UILabel!
    var contactField: UITextField!
    var phoneLabel: UILabel!
    var phoneField: UITextField!
    var publishButton: UIButton!
    
    var headerSection: UIStackView!
    var titleSection: UIStackView!
    var priceSection: UIStackView!
    var descriptionSection: UIStackView!
    var contactSection: UIStackView!
    var phoneSection: UIStackView!
    // swiftlint:enable implicitly_unwrapped_optional
    private init(with configurator: CreateConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UIViewController Lifecycle
extension CreateController: CreateViewInstaller {
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installSubviews()
        presenter.viewDidLoad()
        navBar()
    }
    
}

// MARK: View Protocol Conformation
extension CreateController: CreateViewMVP {
    func navBar() {
        navigationItem.title = L10n.Overall.create
    }
}

// MARK: Static Initializer
extension CreateController {
    static func instantiate() -> CreateController {
        let configurator = CreatePageConfiguratorImpl()
        let vc = CreateController(with: configurator)
        return vc
    }
}
