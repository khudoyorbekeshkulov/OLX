import UIKit

final class CategoryCell: UITableViewCell {
    
    let cellView = UIView().then {
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let image = UIImageView().then {
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let numberOfResults = UILabel().then {
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.textColor = ColorResourceManager.shared.color(r: 79, g: 79, b: 79)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let nextImage = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupTableViewconstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CategoryCell {
    
    func addSubviews() {
        contentView.addSubview(cellView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(image)
        cellView.addSubview(numberOfResults)
        cellView.addSubview(nextImage)
    }
    
    func setupTableViewconstraint() {
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
