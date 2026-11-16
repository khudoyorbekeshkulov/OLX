import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    
    let cellView = UIView().then {
        $0.layer.cornerRadius = 5
    }
    
    let image = UIImageView().then {
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = ColorResourceManager.shared.blackText
    }
    
    let numberOfResults = UILabel().then {
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.textColor = ColorResourceManager.shared.blackText
    }
    
    let nextImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        addSubviews()
        setupUIConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CategoryCell {
    
    func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    func addSubviews() {
        contentView.addSubview(cellView)
        
        cellView.addSubviews([
            titleLabel,
            image,
            numberOfResults,
            nextImage
        ])
    }
    
    func setupUIConstraints() {
        cellView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview().inset(5)
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
