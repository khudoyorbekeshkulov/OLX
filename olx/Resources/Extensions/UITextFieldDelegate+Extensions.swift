//
//  UITextFieldDelegate+Extensions.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 13/11/26.
//

import UIKit

extension HomePageController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
