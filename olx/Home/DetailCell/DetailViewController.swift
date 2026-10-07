import UIKit

class DetailViewController: UIViewController {
    let mainColor = ColorResourceManager.shared.mainColor

    var categories: [Category] = []
    var category: Category?

    private let image = UIImageView()
    private var isCheckedHeart = false
    private let infoFrame = UIView()
    private let postedTime = UILabel()
    private let nameProduct = UILabel()
    private let saleProduct = UILabel()
    private let infoLabel = UILabel()
    private let infoProduct = UILabel()
    private let productOwner = UILabel()
    private let onlineTime = UILabel()
    private let feedBackButton = UIButton(type: .system)
    private let adsLabelFrame = UIView()
    private let adsLabel = UILabel()
    private let lineView = UIView()
    private let headerLabel = UILabel()
    
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
        setupImage()
        setupInfoProduct()
        setupHeaderLabel()
        setupConstraints()
        configure()
    }
}

/// Elementlar tab bar dan boshlanish uchun hacking code
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
    
    private func setupImage() {
        view.addSubview(image)
        
        image.image = .cobalt
        image.clipsToBounds = true
        
    }
    
    private func setupInfoProduct() {
        view.addSubview(infoFrame)
        
        infoFrame.backgroundColor = .white
        
        infoFrame.addSubview(postedTime)
        
        postedTime.textColor = .gray
        postedTime.font = UIFont.systemFont(ofSize: 10)
        
        infoFrame.addSubview(nameProduct)
        
        nameProduct.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        nameProduct.numberOfLines = 2
        nameProduct.lineBreakMode = .byWordWrapping
        
        infoFrame.addSubview(saleProduct)
        
        saleProduct.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        infoFrame.addSubview(infoLabel)
        
        infoLabel.text = "Описание"
        infoLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        infoFrame.addSubview(infoProduct)
        
        infoProduct.font = UIFont.systemFont(ofSize: 12)
        infoProduct.numberOfLines = 3
        infoProduct.lineBreakMode = .byWordWrapping
        
        infoFrame.addSubview(productOwner)
        
        productOwner.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        productOwner.text = category?.productOwner
        productOwner.isUserInteractionEnabled = true
        
        let tapGasture = UITapGestureRecognizer(target: self, action: #selector(messageOwnerTapped))
        productOwner.addGestureRecognizer(tapGasture)
        
        infoFrame.addSubview(onlineTime)
        
        onlineTime.textColor = .gray
        onlineTime.font = UIFont.systemFont(ofSize: 10)
        
        infoFrame.addSubview(feedBackButton)
        
        feedBackButton.setTitle("Оставить отзыв", for: .normal)
        feedBackButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        feedBackButton.setTitleColor(mainColor, for: .normal)
        feedBackButton.layer.borderWidth = 1
        feedBackButton.layer.cornerRadius = 10
        
        infoFrame.addSubview(adsLabelFrame)
        
        adsLabelFrame.addSubview(adsLabel)
        
        adsLabel.text = "Все объявления автора"
        adsLabel.textColor = mainColor
        adsLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        adsLabelFrame.addSubview(lineView)
        
        lineView.backgroundColor = mainColor
        
    }
    
    private func setupHeaderLabel() {
        view.addSubview(headerLabel)
        view.addSubview(detailCollectionView)
        
        headerLabel.text = "Похожие объявления"
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private func configure() {
        guard let category = category else { return }
        image.image = category.image
        postedTime.text = category.locationAndTime
        nameProduct.text = category.title
        saleProduct.text = category.numberOfSales
        onlineTime.text = category.online
        productOwner.text = category.productOwner
        infoProduct.text = category.infoProduct
    }
    
    /// Heart ni bosilgan yoki bosilmaganligini kursatayapti
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


extension DetailViewController {
    private func setupConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        infoFrame.translatesAutoresizingMaskIntoConstraints = false
        postedTime.translatesAutoresizingMaskIntoConstraints = false
        nameProduct.translatesAutoresizingMaskIntoConstraints = false
        saleProduct.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoProduct.translatesAutoresizingMaskIntoConstraints = false
        productOwner.translatesAutoresizingMaskIntoConstraints = false
        onlineTime.translatesAutoresizingMaskIntoConstraints = false
        feedBackButton.translatesAutoresizingMaskIntoConstraints = false
        adsLabelFrame.translatesAutoresizingMaskIntoConstraints = false
        adsLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
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
            
            feedBackButton.topAnchor.constraint(equalTo: onlineTime.bottomAnchor, constant: 15),
            feedBackButton.leadingAnchor.constraint(equalTo: infoFrame.leadingAnchor, constant: 15),
            feedBackButton.widthAnchor.constraint(equalToConstant: 160),
            feedBackButton.heightAnchor.constraint(equalToConstant: 40),
            
            adsLabelFrame.topAnchor.constraint(equalTo: onlineTime.bottomAnchor, constant: 15),
            adsLabelFrame.leadingAnchor.constraint(equalTo: feedBackButton.trailingAnchor, constant: 10),
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
}

