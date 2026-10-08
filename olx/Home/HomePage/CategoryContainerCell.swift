import UIKit

protocol CategoryContainerCellDelegate: AnyObject {
    func didTapShowAllCategories()
}

final class CategoryContainerCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: CategoryContainerCellDelegate?
    
    private lazy var headerView = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var mainCategoryLabel = UILabel().then {
        $0.text = "Категории"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var showAllButton = UIButton(type: .system).then {
        $0.setTitle("Смотреть все", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(.gray, for: .normal)
        $0.addTarget(self, action: #selector(showAllTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let categories: [Category] = [
        Category(
            image: UIImage(named: "olxImage"),
            title: "Все объявления"
        ),
        Category(
            image: UIImage(named: "home"),
            title: "Недвижимость"
        ),
        Category(
            image: UIImage(named: "stroller"),
            title: "Детский мир",
            imageBackgroundColor: ColorResourceManager.shared.color(r: 255, g: 206, b: 50)
        ),
        Category(
            image: UIImage(named: "dress"),
            title: "Одежда и обувь"
        ),
        Category(
            image: UIImage(named: "car"),
            title: "Автомобили"
        )
    ]
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = .init(top: 15, left: 10, bottom: 15, right: 0)
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false  
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            HomeCategoryCell.self,
            forCellWithReuseIdentifier: "categoryCell"
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categories.count
        }
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "categoryCell",
                for: indexPath
            ) as? HomeCategoryCell else {
                return UICollectionViewCell()
            }
            
            let category = categories[indexPath.item]
            
            cell.image.image = category.image
            cell.image.backgroundColor = category.imageBackgroundColor
            cell.titleLabel.text = category.title
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: 80, height: 115)
        }
        return .zero
    }
}

private extension CategoryContainerCell {
    
    func addSubviews() {
        contentView.addSubview(headerView)
        contentView.addSubview(categoryCollectionView)
        headerView.addSubview(mainCategoryLabel)
        headerView.addSubview(showAllButton)
        headerView.addSubview(lineView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            mainCategoryLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            mainCategoryLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            
            showAllButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            showAllButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            
            lineView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            lineView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            lineView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            categoryCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 140),
        ])
    }
    
    @objc private func showAllTapped() {
        delegate?.didTapShowAllCategories()
    }
}
