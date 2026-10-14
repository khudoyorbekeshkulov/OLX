import UIKit
import SnapKit

class HomeCategoryCell: UICollectionViewCell {
    
    let cellView = UIView()
    
    let image = UIImageView().then {
        $0.layer.cornerRadius = 35
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
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

private extension HomeCategoryCell {
    
    func addSubviews() {
        contentView.addSubview(cellView)
        
        cellView.addarrangedSubviews([
            titleLabel,
            image
        ])
    }
    
    func setupConstraints() {
        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        image.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(70)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
