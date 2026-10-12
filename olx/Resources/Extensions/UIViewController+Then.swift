//
//  UIViewController+Then.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 12/10/26.
//

import UIKit

/// Elementlar tab bar dan boshlanish uchun code
extension UIViewController {
    var topbarHeight: CGFloat {
        (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
