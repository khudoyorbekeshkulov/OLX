//
//  NSObject+Then.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 07/10/26.
//

import Foundation

extension NSObject {
    func then(_ configure: (Self) -> Void) -> Self {
        configure(self)
        return self
    }
}
