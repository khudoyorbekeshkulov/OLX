import UIKit
import SnapKit

class RecommendedCell: UICollectionViewCell {
    
    private var isTapped = false
    
    var isImpact = false {
        didSet{updateCellSize()}
    }
    
    let cellView = UIView().then {
        $0.backgroundColor = UIColor(named: "card_background_color")
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
        $0.tintColor = UIColor(named: "heart_color")
        $0.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
    }
    
    let timeLabel = UILabel().then {
        $0.textColor = UIColor(named: "secondary_color")
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
            $0.height.equalTo(100)
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
    
    @objc func heartTapped() {
        isTapped.toggle()
        let heartChange = isTapped ?  "heart.fill" :  "heart"
        heartButton.setImage(UIImage(systemName: heartChange), for: .normal)
    }
}
