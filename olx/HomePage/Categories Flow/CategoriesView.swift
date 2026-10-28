//
//  CategoriesView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 15/10/26.
//

import UIKit
import SnapKit

private enum Constants {
    static let cellHeight: CGFloat = 80
}

final class CategoriesView: UIView {
    private let tableView = UITableView().then {
        $0.register(cellType: CategoryCell.self)
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }
    
    private var categories = [Category]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var onSectionTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCategories(categories: [Category]) {
        self.categories = categories
    }
}

extension CategoriesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        categories.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueCell(CategoryCell.self, for: indexPath)
        let category = categories[indexPath.row]
        
        return cell.then {
            $0.cellView.backgroundColor = category.backgroundColor
            $0.image.image = category.image
            $0.image.backgroundColor = category.imageBackgroundColor
            $0.titleLabel.text = category.title
            $0.numberOfResults.text = category.result
            $0.nextImage.image = indexPath.row == 0 ? nil : UIImage(named: "ic_next")
            $0.selectionStyle = .none
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        Constants.cellHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard indexPath.row != 0 else { return }
        onSectionTapped?()
    }
}

private extension CategoriesView {
    func setupView() {
        backgroundColor = ColorResourceManager.shared.cardBackground
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func addSubviews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
