import UIKit
import SnapKit

class RecommendedCell: UICollectionViewCell {
    
    static let imageAspectRatio: CGFloat = 0.57
    private static let textBlockHeight: CGFloat = 90
    
    static func height(forWidth width: CGFloat) -> CGFloat {
        ceil(width * imageAspectRatio) + textBlockHeight
    }
        
    var isImpact = false {
        didSet{updateCellSize()}
    }
    
    var onHeartTapped: (() -> Void)?
    
    let cellView = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.cardBackground
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    let profileImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let additionalLabel = UILabel().then {
        $0.numberOfLines = 2
    }
    
    private lazy var heartButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = ColorResourceManager.shared.heart
        $0.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
    }
    
    let timeLabel = UILabel().then {
        $0.textColor = ColorResourceManager.shared.secondaryText
    }
    
    let saleLabel = UILabel().then {
        $0.text = "от 100 000 сум"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupRecommendedViewConstraints()
        updateCellSize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommendedCell {
    func setFavorite(_ isFavorite: Bool) {
        let name = isFavorite ? "heart.fill" : "heart"
        heartButton.setImage(UIImage(systemName: name), for: .normal)
    }
    
    @objc func heartTapped() {
        onHeartTapped?()
    }
}

private extension RecommendedCell {
    
    func addSubviews() {
        contentView.addSubview(cellView)
        
        cellView.addSubviews([
            profileImage,
            additionalLabel,
            heartButton,
            timeLabel,
            saleLabel
        ])
    }
    
    func updateCellSize() {
        additionalLabel.font = UIFont.systemFont(ofSize: isImpact ? 11 : 12)
        timeLabel.font = UIFont.systemFont(ofSize: isImpact ? 10 : 11)
        saleLabel.font = UIFont.systemFont(ofSize: isImpact ? 13 : 14, weight: .bold)
    }
    
    func setupRecommendedViewConstraints() {
        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(profileImage.snp.width).multipliedBy(RecommendedCell.imageAspectRatio)
        }
        
        heartButton.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(20)
            $0.height.equalTo(17)
        }
        
        additionalLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalTo(heartButton.snp.leading).offset(-10)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(additionalLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(10)
        }
        
        saleLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
