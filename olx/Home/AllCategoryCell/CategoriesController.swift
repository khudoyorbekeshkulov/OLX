import UIKit
import SnapKit

class CategoriesPage: UIViewController {
    
    private lazy var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(CategoryCell.self, forCellReuseIdentifier: "cell")
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
    }
    
    let mockNetworkServiceProviderAllInfo = NetworkServiceMainProductChapterImplementation.shared
    private lazy var categories: [Category] = mockNetworkServiceProviderAllInfo.getCategoriesAllInfo().toCategoryMainProductsChapter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addSubviews()
        setupConstraints()
    }
}

extension CategoriesPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoryCell else { return UITableViewCell()
        }
        
        let category = categories[indexPath.row]
        
        return cell.then {
            $0.cellView.backgroundColor = category.backgroundColor
            $0.image.image = category.image
            $0.image.backgroundColor = category.imageBackgroundColor
            $0.titleLabel.text = category.title
            $0.numberOfResults.text = category.result
            $0.nextImage.image = indexPath.row == 0 ? nil : UIImage(named: "next")
            $0.selectionStyle = .none
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }
        navigationController?.pushViewController(SelectedCategoryCell(), animated: true)
    }
}

private extension CategoriesPage {
    
    func setupNavigationBar() {
        navigationItem.title = "Категории"
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
