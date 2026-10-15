import UIKit
import SnapKit

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
        $0.clipsToBounds = true
    }
    
    private lazy var infoFrame = UIView().then {
        $0.backgroundColor = UIColor(hex: "#FFFFFF")
    }
    
    private lazy var postedTime = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor(hex: "#808080")
    }
    
    private lazy var nameProduct = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
    }
    
    private lazy var saleProduct = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    private lazy var infoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.text = "Описание"
    }
    
    private lazy var infoProduct = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 3
    }
    
    private lazy var productOwner = UILabel().then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(messageOwnerTapped)))
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.text = category?.productOwner
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var onlineTime = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor(hex: "#808080")
    }
    
    private lazy var feedbackButton = UIButton(type: .system).then {
        $0.setTitle("Оставить отзыв", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        $0.setTitleColor(mainColor, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    private lazy var adsLabelFrame = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.text = "Все объявления автора"
        $0.textColor = mainColor
    }
    
    private lazy var adsLabel = UILabel()
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = mainColor
    }
    
    private lazy var headerLabel = UILabel().then {
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
        view.addSubviews([
            image,
            infoFrame,
            headerLabel,
            detailCollectionView
        ])
        
        infoFrame.addSubviews([
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
        
        adsLabelFrame.addSubviews([
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
        image.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(280)
        }
        
        infoFrame.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(280)
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(infoFrame.snp.bottom).offset(20)
            $0.leading.equalTo(infoFrame.snp.leading).offset(15)
        }
        
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(175)
        }
        
        postedTime.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(15)
        }
        
        nameProduct.snp.makeConstraints {
            $0.top.equalTo(postedTime.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().offset(15)
        }
        
        saleProduct.snp.makeConstraints {
            $0.top.equalTo(nameProduct.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().offset(15)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(saleProduct.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
        }
        
        infoProduct.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().offset(15)
        }
        
        productOwner.snp.makeConstraints {
            $0.top.equalTo(infoProduct.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().offset(15)
        }
        
        onlineTime.snp.makeConstraints {
            $0.top.equalTo(productOwner.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(15)
        }
        
        feedbackButton.snp.makeConstraints {
            $0.top.equalTo(onlineTime.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.size.equalTo(CGSize(width: 160, height: 40))
        }
        
        adsLabelFrame.snp.makeConstraints {
            $0.top.equalTo(onlineTime.snp.bottom).offset(15)
            $0.leading.equalTo(feedbackButton.snp.trailing).offset(10)
            $0.size.equalTo(CGSize(width: 160, height: 40))
        }
        
        adsLabel.snp.makeConstraints {
            $0.centerY.equalTo(adsLabelFrame.snp.centerY)
            $0.centerX.equalTo(adsLabelFrame.snp.centerX)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(adsLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(1)
        }
    }
    
    @objc func didTapHeartButton() {
        isCheckedHeart.toggle()
    }
    
    @objc func messageOwnerTapped() {
        let messageVC = MessageViewController()
        messageVC.chatPartnerName = category?.productOwner ?? messageVC.chatPartnerName
        
        navigationController?.pushViewController(messageVC, animated: true)
    }
}
