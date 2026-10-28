//
//  MessageViewController+Keyboard.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 19/10/26.
//

import UIKit
import SnapKit

extension MessageViewController {
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChange),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChange),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let inputBarBottomOffset: CGFloat = {
            let condition = notification.name == UIResponder.keyboardWillHideNotification
            let keyboardHeight = rootView.frame.height - endFrame.origin.y
            return condition ? 0 : -keyboardHeight + self.rootView.safeAreaInsets.bottom
        }()
        
        rootView.inputBarBottomConstraint.update(offset: inputBarBottomOffset)
        
        UIView.animate(withDuration: duration) {
            self.rootView.layoutIfNeeded()
        }
    }
}
