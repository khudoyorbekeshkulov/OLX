import UIKit

class CustomButton: UIControl {
    let label = UILabel()
    let imageView = UIImageView()
    
    init(image: UIImage?, text: String) {
        super.init(frame: .zero)
        
        addSubview(label)
        addSubview(imageView)
        
        label.text = text
        imageView.image = image
        
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
