//
//  CreatePageRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 05/11/26.
//

import UIKit
import PhotosUI

protocol CreateRouter {
    func routeToImagePicker(onPick: @escaping (UIImage) -> Void)
}

class CreatePageRouterImpl: CreateRouter {
    
    private weak var controller: CreateController?
    private var onPick: ((UIImage) -> Void)?
    
    init(_ controller: CreateController?) {
        self.controller = controller
        
    }
    
    func routeToImagePicker(onPick: @escaping (UIImage) -> Void) {
        self.onPick = onPick
        
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        controller?.present(picker, animated: true)
    }
}

extension CreatePageRouterImpl: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else { return }
        
        provider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
            guard let image = object as? UIImage else { return }
            DispatchQueue.main.async {
                self?.onPick?(image)
                self?.onPick = nil
            }
        }
    }
}
