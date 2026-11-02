import UIKit
import PhotosUI

class CreateViewController: UIViewController {
    let rootView = CreateView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupViewBinders()
    }
}

private extension CreateViewController {
    func setupNav() {
        navigationItem.title = L10n.Overall.create
    }
    
    func setupViewBinders() {
        rootView.onAddPhotoTapped = { [weak self] in
            self?.presentPhotoPicker()
        }
        
        rootView.onPublishTapped = { [weak self] form in
            self?.publish(form)
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
        guard form.title.count >= 5 else {
            showAlert("Введите не менее 5 символов в заголовке")
            return
        }
        guard form.description.count >= 10 else {
            showAlert("Введите не менее 10 символов в описании")
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
            priceNumbers: form.price.isEmpty ? "Договорная" : form.price,
            phoneNumber: form.phone,
            locationAndTime: "Только что",
            contactName: form.contactName,
            descriptionProduct: form.description
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

extension CreateViewController: PHPickerViewControllerDelegate {
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
