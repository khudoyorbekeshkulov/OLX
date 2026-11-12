//
//  ExpandingContainerView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 11/11/26.
//

import UIKit

final class ExpandingContainerView: UIView {
    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }
}
