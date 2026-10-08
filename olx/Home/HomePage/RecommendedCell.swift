import UIKit

class RecommendedCell: UICollectionViewCell {
    
    private var isTapped = false
    
    let cellView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let profileImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let additionalLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var heartButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let timeLabel = UILabel().then {
        $0.textColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let saleLabel = UILabel().then {
        $0.text = "от 100 000 сум"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var isImpact = false {
        didSet{updateCellSize()}
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
        cellView.addSubview(profileImage)
        cellView.addSubview(additionalLabel)
        cellView.addSubview(heartButton)
        cellView.addSubview(timeLabel)
        cellView.addSubview(saleLabel)
    }
    
    func updateCellSize() {
        if isImpact {
            additionalLabel.font = UIFont.systemFont(ofSize: 11)
            timeLabel.font = UIFont.systemFont(ofSize: 10)
            saleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        } else {
            additionalLabel.font = UIFont.systemFont(ofSize: 12)
            timeLabel.font = UIFont.systemFont(ofSize: 11)
            saleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        }
    }
    
    func setupRecommendedViewConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            profileImage.topAnchor.constraint(equalTo: cellView.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            heartButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            heartButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            heartButton.widthAnchor.constraint(equalToConstant: 20),
            heartButton.heightAnchor.constraint(equalToConstant: 17),
            
            additionalLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            additionalLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            additionalLabel.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -10),
            
            timeLabel.topAnchor.constraint(equalTo: additionalLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            
            saleLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            saleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            saleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
        ])
    }
    
    @objc func heartTapped() {
        isTapped.toggle()
        let heartChange = isTapped ?  "heart.fill" :  "heart"
        heartButton.setImage(UIImage(systemName: heartChange), for: .normal)
    }
}
