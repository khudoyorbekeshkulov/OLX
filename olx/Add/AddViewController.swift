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
