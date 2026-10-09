import UIKit

class DetailViewController: UIViewController {
    
    private let mainColor = ColorResourceManager.shared.mainColor

    var categories: [Category] = []
    var category: Category?

    private lazy var image = UIImageView().then {
        $0.image = .cobalt
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private var isCheckedHeart = false
    
    private lazy var infoFrame = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var postedTime = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var nameProduct = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var saleProduct = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var infoLabel = UILabel().then {
        $0.text = "Описание"
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var infoProduct = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.numberOfLines = 3
        $0.lineBreakMode = .byWordWrapping
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var productOwner = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.text = category?.productOwner
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(messageOwnerTapped)))
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var onlineTime = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var feedbackButton = UIButton(type: .system).then {
        $0.setTitle("Оставить отзыв", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        $0.setTitleColor(ColorResourceManager.shared.mainColor, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var adsLabelFrame = UILabel().then {
        $0.text = "Все объявления автора"
        $0.textColor = mainColor
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private lazy var adsLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.mainColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var headerLabel = UILabel().then {
        $0.text = "Похожие объявления"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: 155, height: 175)
        layout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemGray6
        
        collectionView.register(RecommendedCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        setupNavBar()
        addSubviews()
        setupConstraints()
        configure()
    }
}

/// Elementlar tab bar dan boshlanish uchun code
extension UIViewController {
    var topbarHeight: CGFloat {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
}

extension DetailViewController {
    func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
        
        let heartButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(didTapHeartButton)
        )
        navigationItem.rightBarButtonItem = heartButton
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecommendedCell else {return UICollectionViewCell()}
        
        let category = categories[indexPath.item]
        
        cell.profileImage.image = category.image
        cell.additionalLabel.text = category.title
        cell.timeLabel.text = category.locationAndTime
        cell.saleLabel.text = category.numberOfSales
        cell.isImpact = true
        
        return cell
    }
}

private extension DetailViewController {
     func addSubviews() {
        view.addSubview(image)
        view.addSubview(infoFrame)
        infoFrame.addSubview(postedTime)
        infoFrame.addSubview(nameProduct)
        infoFrame.addSubview(saleProduct)
        infoFrame.addSubview(infoLabel)
        infoFrame.addSubview(infoProduct)
        infoFrame.addSubview(productOwner)
        infoFrame.addSubview(onlineTime)
        infoFrame.addSubview(feedbackButton)
        infoFrame.addSubview(adsLabelFrame)
        adsLabelFrame.addSubview(adsLabel)
        adsLabelFrame.addSubview(lineView)
        view.addSubview(headerLabel)
        view.addSubview(detailCollectionView)
    }
    
     func configure() {
        guard let category = category else { return }
        image.image = category.image
        postedTime.text = category.locationAndTime
        nameProduct.text = category.title
        saleProduct.text = category.numberOfSales
        onlineTime.text = category.online
        productOwner.text = category.productOwner
        infoProduct.text = category.infoProduct
    }
    
    private func setupConstraints() {
        detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 280),
            
            infoFrame.topAnchor.constraint(equalTo: image.bottomAnchor),
            infoFrame.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoFrame.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoFrame.heightAnchor.constraint(equalToConstant: 280),
            
            postedTime.topAnchor.constraint(equalTo: infoFrame.topAnchor, constant: 10),
            postedTime.leadingAnchor.constraint(equalTo: infoFrame.leadingAnchor, constant: 15),
            
            nameProduct.topAnchor.constraint(equalTo: postedTime.bottomAnchor, constant: 15),
            nameProduct.leadingAnchor.constraint(equalTo: infoFrame.leadingAnchor, constant: 15),
            nameProduct.trailingAnchor.constraint(equalTo: infoFrame.trailingAnchor, constant: -15),
            
            saleProduct.topAnchor.constraint(equalTo: nameProduct.bottomAnchor, constant: 5),
            saleProduct.leadingAnchor.constraint(equalTo: infoFrame.leadingAnchor, constant: 15),
            saleProduct.trailingAnchor.constraint(equalTo: infoFrame.trailingAnchor, constant: -15),
            
            infoLabel.topAnchor.constraint(equalTo: saleProduct.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: infoFrame.leadingAnchor, constant: 15),
            
            infoProduct.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5),
            infoProduct.leadingAnchor.constraint(equalTo: infoFrame.leadingAnchor, constant: 15),
            infoProduct.trailingAnchor.constraint(equalTo: infoFrame.trailingAnchor, constant: -15),
            
            productOwner.topAnchor.constraint(equalTo: infoProduct.bottomAnchor, constant: 20),
            productOwner.leadingAnchor.constraint(equalTo: infoFrame.leadingAnchor, constant: 15),
            productOwner.trailingAnchor.constraint(equalTo: infoFrame.trailingAnchor, constant: -15),
            
            onlineTime.topAnchor.constraint(equalTo: productOwner.bottomAnchor, constant: 5),
            onlineTime.leadingAnchor.constraint(equalTo: infoFrame.leadingAnchor, constant: 15),
            
            feedbackButton.topAnchor.constraint(equalTo: onlineTime.bottomAnchor, constant: 15),
            feedbackButton.leadingAnchor.constraint(equalTo: infoFrame.leadingAnchor, constant: 15),
            feedbackButton.widthAnchor.constraint(equalToConstant: 160),
            feedbackButton.heightAnchor.constraint(equalToConstant: 40),
            
            adsLabelFrame.topAnchor.constraint(equalTo: onlineTime.bottomAnchor, constant: 15),
            adsLabelFrame.leadingAnchor.constraint(equalTo: feedbackButton.trailingAnchor, constant: 10),
            adsLabelFrame.widthAnchor.constraint(equalToConstant: 160),
            adsLabelFrame.heightAnchor.constraint(equalToConstant: 40),
            
            adsLabel.centerXAnchor.constraint(equalTo: adsLabelFrame.centerXAnchor),
            adsLabel.centerYAnchor.constraint(equalTo: adsLabelFrame.centerYAnchor),
            
            lineView.topAnchor.constraint(equalTo: adsLabel.bottomAnchor, constant: 2),
            lineView.leadingAnchor.constraint(equalTo: adsLabelFrame.leadingAnchor, constant: 5),
            lineView.trailingAnchor.constraint(equalTo: adsLabelFrame.trailingAnchor, constant: -5),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            
            headerLabel.topAnchor.constraint(equalTo: infoFrame.bottomAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            detailCollectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            detailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailCollectionView.heightAnchor.constraint(equalToConstant: 175),
        ])
    }
    
    @objc func didTapHeartButton() {
        isCheckedHeart.toggle()
        
        let selectedHeart = isCheckedHeart ? "heart.fill" : "heart"
        
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: selectedHeart)
    }
    
    @objc func messageOwnerTapped() {
        let messageVC = Message()
        messageVC.chatPartnerName = category?.productOwner ?? messageVC.chatPartnerName
        
        navigationController?.pushViewController(messageVC, animated: true)
    }
}
