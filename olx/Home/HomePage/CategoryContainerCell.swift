import UIKit
import SnapKit

protocol CategoryContainerCellDelegate: AnyObject {
    func didTapShowAllCategories()
}

final class CategoryContainerCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: CategoryContainerCellDelegate?
    
    private lazy var headerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var mainCategoryLabel = UILabel().then {
        $0.text = "Категории"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private lazy var showAllButton = UIButton(type: .system).then {
        $0.setTitle("Смотреть все", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(.gray, for: .normal)
        $0.addTarget(self, action: #selector(showAllTapped), for: .touchUpInside)
    }
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .systemGray6
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
            imageBackgroundColor: UIColor(hex: "#FFCC00")
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
    
    private lazy var categoryLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.sectionInset = .init(
            top: 15,
            left: 10,
            bottom: 15,
            right: 0
        )
    }
    
    private lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(
            HomeCategoryCell.self,
            forCellWithReuseIdentifier: "categoryCell"
        )
        $0.dataSource = self
        $0.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
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
            
            return cell.then {
                $0.image.image = category.image
                $0.image.backgroundColor = category.imageBackgroundColor
                $0.titleLabel.text = category.title
            }
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
        contentView.addarrangedSubviews([
            headerView,
            categoryCollectionView
        ])
        
        headerView.addarrangedSubviews([
            mainCategoryLabel,
            showAllButton,
            lineView
        ])
    }
    
    func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        mainCategoryLabel.snp.makeConstraints {
            $0.centerY.equalTo(headerView.snp.centerY)
            $0.leading.equalTo(headerView.snp.leading).offset(15)
        }
        
        showAllButton.snp.makeConstraints {
            $0.centerY.equalTo(headerView.snp.centerY)
            $0.trailing.equalTo(headerView.snp.trailing).offset(-15)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(headerView.snp.bottom)
            $0.height.equalTo(1)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(140)
        }
    }
    
    @objc private func showAllTapped() {
        delegate?.didTapShowAllCategories()
    }
}
