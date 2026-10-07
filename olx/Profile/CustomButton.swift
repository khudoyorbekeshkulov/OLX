import UIKit

class CustomButton: UIControl {
    
    let label = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let imageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
