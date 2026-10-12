import UIKit

class DetailViewController: UIViewController {
    
    private let mainColor = ColorResourceManager.shared.mainColor
    
    var categories: [Category] = []
    var category: Category?
    
    private var isCheckedHeart: Bool = false {
        didSet {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: isCheckedHeart ? "heart.fill" : "heart")
        }
    }

    private lazy var image = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }
    
    private lazy var infoFrame = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "white")
    }
    
    private lazy var postedTime = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor(named: "gray")
    }
    
    private lazy var nameProduct = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
    }
    
    private lazy var saleProduct = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    private lazy var infoLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.text = "Описание"
    }
    
    private lazy var infoProduct = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 3
    }
    
    private lazy var productOwner = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(messageOwnerTapped)))
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.text = category?.productOwner
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var onlineTime = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor(named: "gray")
    }
    
    private lazy var feedbackButton = UIButton(type: .system).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Оставить отзыв", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        $0.setTitleColor(mainColor, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    private lazy var adsLabelFrame = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.text = "Все объявления автора"
        $0.textColor = mainColor
    }
    
    private lazy var adsLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var lineView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = mainColor
    }
    
    private lazy var headerLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "Похожие объявления"
    }
    
    private lazy var layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 15
        $0.itemSize = CGSize(width: 155, height: 175)
        $0.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 0)
    }
    
    private lazy var detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .systemGray6
        $0.register(RecommendedCell.self, forCellWithReuseIdentifier: "cell")
        $0.delegate = self
        $0.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        addSubviews()
        setupNavBar()
        configure()
        setupConstraints()
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecommendedCell else {return UICollectionViewCell()}
        
        let category = categories[indexPath.item]
        
        return cell.then {
            $0.profileImage.image = category.image
            $0.additionalLabel.text = category.title
            $0.timeLabel.text = category.locationAndTime
            $0.saleLabel.text = category.numberOfSales
            $0.isImpact = true
        }
    }
}

private extension DetailViewController {
    func addSubviews() {
        view.addarrangedSubviews([
            image,
            infoFrame,
            headerLabel,
            detailCollectionView
        ])
        
        infoFrame.addarrangedSubviews([
            postedTime,
            nameProduct,
            saleProduct,
            infoLabel,
            infoProduct,
            productOwner,
            onlineTime,
            feedbackButton,
            adsLabelFrame
        ])
        
        adsLabelFrame.addarrangedSubviews([
            adsLabel,
            lineView
        ])
    }
    
    func setupNavBar() {
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithTransparentBackground()
        }
        
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
    
    func setupConstraints() {
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
    }
    
    @objc func messageOwnerTapped() {
        let messageVC = Message()
        messageVC.chatPartnerName = category?.productOwner ?? messageVC.chatPartnerName
        
        navigationController?.pushViewController(messageVC, animated: true)
    }
}
