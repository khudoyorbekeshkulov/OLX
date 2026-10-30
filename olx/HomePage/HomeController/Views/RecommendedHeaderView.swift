import UIKit
import SnapKit

final class RecommendedHeaderView: UICollectionReusableView {
    
    private lazy var titleLabel = UILabel().then {
        $0.text = L10n.Home.recommendedForYouLabel
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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

private extension RecommendedHeaderView {
    
    func addSubviews() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-5)
            $0.leading.equalToSuperview().offset(15)
        }
    }
}
