import UIKit

class CategoriesPage: UIViewController {
    
    private lazy var buttonBack = UIButton(type: .system).then {
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private lazy var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
            backgroundColor: ColorResourceManager.shared.color(r: 235, g: 250, b: 240),
        ),
        
        Category (
            image: UIImage(named: "stroller"),
            title: "Детский мир",
            result: "44123 результатов",
            backgroundColor: ColorResourceManager.shared.color(r: 253, g: 246, b: 222),
            imageBackgroundColor: ColorResourceManager.shared.color(r: 255, g: 206, b: 50)
        ),
        
        Category(
            image: UIImage(named: "dress"),
            title: "Одежда и обувь",
            result: "18934 результатов",
            backgroundColor: ColorResourceManager.shared.color(r: 240, g: 247, b: 247),
        ),
        
        Category (
            image: UIImage(named: "car"),
            title: "Автомобили",
            result: "7123 результатов",
            backgroundColor: ColorResourceManager.shared.color(r: 225, g: 240, b: 255),
        ),
        
        Category (
            image: UIImage(named: "cat"),
            title: "Животные",
            result: "5473 результатов",
            backgroundColor: ColorResourceManager.shared.color(r: 255, g: 243, b: 230),
        ),
        
        Category (
            image: UIImage(named: "phone"),
            title: "Электроника",
            result: "3573 результатов",
            backgroundColor: ColorResourceManager.shared.color(r: 243, g: 235, b: 255),
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Категории"
        
        view.addSubview(tableView)
        
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
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
        guard indexPath.row == 0 else { return }
        navigationController?.pushViewController(SelectedCategoryCell(), animated: true)
        
        if indexPath.row != 0 {
            navigationController?.pushViewController(SelectedCategoryCell(), animated: true)
        }
    }
}

extension CategoriesPage {
    
    func setupConstraints() {
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
