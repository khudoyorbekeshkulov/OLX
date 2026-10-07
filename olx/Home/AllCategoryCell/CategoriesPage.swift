

import UIKit

class CategoriesPage: UIViewController {
    private let buttonBack = UIButton(type: .system)
    private let tableView = UITableView()
    
    private let categories: [Category] = [
        Category (
            image: UIImage(named: "olxImage"),
            title: "Все обявления",
            result: "634123 результатов",
            backgroundColor: .white,
        ),
        
        Category (
            image: UIImage(named: "home"),
            title: "Недвижимость",
            result: "28341 результатов",
            backgroundColor: .init(r: 235, g: 250, b: 240),
        ),
        
        Category (
            image: UIImage(named: "stroller"),
            title: "Детский мир",
            result: "44123 результатов",
            backgroundColor: .init(r: 253, g: 246, b: 222),
            imageBackgroundColor: .init(r: 255, g: 206, b: 50)
        ),
        
        Category(
            image: UIImage(named: "dress"),
            title: "Одежда и обувь",
            result: "18934 результатов",
            backgroundColor: .init(r: 240, g: 247, b: 247),
        ),
        
        Category (
            image: UIImage(named: "car"),
            title: "Автомобили",
            result: "7123 результатов",
            backgroundColor: .init(r: 225, g: 240, b: 255),
        ),
        
        Category (
            image: UIImage(named: "cat"),
            title: "Животные",
            result: "5473 результатов",
            backgroundColor: .init(r: 255, g: 243, b: 230),
        ),
        
        Category (
            image: UIImage(named: "phone"),
            title: "Электроника",
            result: "3573 результатов",
            backgroundColor: .init(r: 243, g: 235, b: 255),
        ),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Navigation
        navigationItem.title = "Категории"
        
        buttonBack.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // MARK: - TableView
        view.addSubview(tableView)
        
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // MARK: Functions
        setupConstraints()
        
    }
    
    
}


extension CategoriesPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoryCell else { return UITableViewCell()}
        
        let category = categories[indexPath.row]
        
        cell.cellView.backgroundColor = category.backgroundColor
        cell.image.image = category.image
        cell.image.backgroundColor = category.imageBackgroundColor
        cell.titleLabel.text = category.title
        cell.numberOfResults.text = category.result
        
        if indexPath.row == 0 {
            cell.nextImage.image = nil
        } else {
            cell.nextImage.image = UIImage(named: "next")
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategoryCell = SelectedCategoryCell()
        if indexPath.row != 0 {
            navigationController?.pushViewController(selectedCategoryCell, animated: true)
        }
    }
    
    
    
    
}

extension CategoriesPage {
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
