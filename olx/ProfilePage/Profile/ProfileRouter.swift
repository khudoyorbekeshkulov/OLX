//  
//  ProfileRouter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 04/11/26.
//

import Foundation

protocol ProfileRouter {
    
}

class ProfileRouterImpl: ProfileRouter {
    
    private weak var controller: ProfileController?
    
    init(_ controller: ProfileController?) {
        self.controller = controller
    }
    
}
