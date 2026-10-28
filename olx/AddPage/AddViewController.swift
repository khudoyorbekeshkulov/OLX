import UIKit
import PhotosUI

class AddViewController: UIViewController {
    let rootView = AddView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupViewBinders()
    }
}

private extension AddViewController {
    func setupNav() {
        navigationItem.title = "Создать"
    }
    
    func setupViewBinders() {
        rootView.onAddPhotoTapped = { [weak self] in
            self?.presentPhotoPicker()
        }
    }
    
    func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func publish(_ form: AddForm) {
        guard form.title.count >= 16 else {
            showAlert("Введите не менее 16 символов в заголовке")
            return
        }
        guard form.description.count >= 40 else {
            showAlert("Введите не менее 40 символов в описании")
            return
        }
        guard !form.contactName.isEmpty else {
            showAlert("Укажите контактное лицо")
            return
        }
        guard let image = form.image else {
            showAlert("Добавьте фото")
            return
        }
        
        let category = Category(
            image: image,
            title: form.title,
            numberOfSales: "Договорная",
            locationAndTime: "Только что"
        )
        
        ListingsService.shared.add(category)
        
        tabBarController?.selectedIndex = 0
    }

    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension AddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else { return }
        
        provider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
            guard let image = object as? UIImage else { return }
            
            DispatchQueue.main.async {
                self?.rootView.setPhoto(image)
            }
        }
    }
}
