import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    
    let cellView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 5
    }
    
    let image = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    let numberOfResults = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.textColor = .darkGray
    }
    
    let nextImage = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupUIConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CategoryCell {
    
    func addSubviews() {
        contentView.addSubview(cellView)
        
        cellView.addarrangedSubviews([
            titleLabel,
            image,
            numberOfResults,
            nextImage
        ])
    }
    
    func setupUIConstraints() {
        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(
                UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
            )
        }
        
        image.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(image.snp.trailing).offset(10)
        }
        
        numberOfResults.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(image.snp.trailing).offset(10)
        }
        
        nextImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
}
