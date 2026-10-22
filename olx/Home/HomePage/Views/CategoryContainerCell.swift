import UIKit
import SnapKit

protocol CategoryContainerCellDelegate: AnyObject {
    func didTapShowAllCategories()
}

final class CategoryContainerCell: UICollectionViewCell {
    
    weak var delegate: CategoryContainerCellDelegate?
    
    private lazy var headerView = UIView().then {
        $0.backgroundColor = UIColor(named: "card_background_color")
    }
    
    private lazy var mainCategoryLabel = UILabel().then {
        $0.text = "Категории"
        $0.textColor = UIColor(named: "primary_text_color")
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private lazy var showAllButton = UIButton(type: .system).then {
        $0.setTitle("Смотреть все", for: .normal)
        $0.tintColor = UIColor(named: "secondary_text_color")
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(.gray, for: .normal)
        $0.addTarget(self, action: #selector(showAllTapped), for: .touchUpInside)
    }
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = UIColor(hex: "#F2F2F7")
    }
    
    let categories = CategoriesDataHomePage.categories
    
    // MARK: - Adaptive sizing
    
    private static let headerHeight: CGFloat = 60
    private static let sectionVerticalInset: CGFloat = 30
    
    static func itemSize(for width: CGFloat) -> CGSize {
        let itemWidth = min(width / 4.5, 120)
        return CGSize(width: itemWidth, height: itemWidth * 115 / 80)
    }
    
    static func height(for width: CGFloat) -> CGFloat {
        headerHeight + sectionVerticalInset + ceil(itemSize(for: width).height)
    }
    
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
        $0.backgroundColor = UIColor(named: "card_background_color")
        $0.register(cellType: HomeCategoryCell.self)
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
}

extension CategoryContainerCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard collectionView == categoryCollectionView else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueCell(HomeCategoryCell.self, for: indexPath)
        guard let category = categories[safe: indexPath.item] else { return cell }

        return cell.then {
            $0.image.image = category.image
            $0.image.backgroundColor = category.imageBackgroundColor
            $0.titleLabel.text = category.title
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CategoryContainerCell.itemSize(for: collectionView.bounds.width)
    }
}

private extension CategoryContainerCell {
    func addSubviews() {
        contentView.addSubviews([
            headerView,
            categoryCollectionView
        ])
        
        headerView.addSubviews([
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
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc private func showAllTapped() {
        delegate?.didTapShowAllCategories()
    }
}
