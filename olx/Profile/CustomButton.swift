import UIKit
import SnapKit

class CustomButton: UIControl {
    
    let label = UILabel()
    
    let imageView = UIImageView()
    
    init(image: UIImage?, text: String) {
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
        
        label.text = text
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomButton {
    func addSubviews() {
        addSubview(label)
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
}
