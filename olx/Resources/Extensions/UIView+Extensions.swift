//
//  UIView+Extensions.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 12/10/26.
//

import UIKit

extension UIView {
    func addarrangedSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}
