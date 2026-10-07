

import UIKit

final class CategoryCell: UITableViewCell {
    
    let cellView = UIView()
    let image = UIImageView()
    let titleLabel = UILabel()
    let numberOfResults = UILabel()
    let nextImage = UIImageView()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellView)
        
        cellView.addSubview(titleLabel)
        cellView.addSubview(image)
        cellView.addSubview(numberOfResults)
        cellView.addSubview(nextImage)
        
        setupCardView()
        setupTableViewconstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCell {
    
    func setupCardView() {
        
        cellView.layer.cornerRadius = 5
        
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        numberOfResults.font = .systemFont(ofSize: 11, weight: .regular)
        numberOfResults.textColor = .init(r: 79, g: 79, b: 79)
       
        

    }
    
    func setupTableViewconstraint() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfResults.translatesAutoresizingMaskIntoConstraints = false
        nextImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            image.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            image.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 60),
            image.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            
            numberOfResults.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            numberOfResults.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            
            nextImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            nextImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),
            
        ])
            
    }
    
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
