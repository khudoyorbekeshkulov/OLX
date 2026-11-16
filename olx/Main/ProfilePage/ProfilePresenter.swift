//  
//  ProfilePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 04/11/26.
//

import Foundation

protocol ProfileView: AnyObject {
    func updateSegment(isLogin: Bool, animated: Bool)
}

protocol ProfilePresenter {
    func viewDidLoad()
    func didTapSegment(isLogin: Bool)
    func didTapLogin(email: String, password: String)
    func didTapRegister(email: String, password: String, isAgreed: Bool)
}

class ProfilePresenterImpl: ProfilePresenter {
    private weak var view: ProfileView?
    private let router: ProfileRouter
    
    init(view: ProfileView, router: ProfileRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        view?.updateSegment(isLogin: true, animated: false)
    }
    
    func didTapSegment(isLogin: Bool) {
        view?.updateSegment(isLogin: isLogin, animated: true)
    }
    
    func didTapLogin(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else { return }
    }
    
    func didTapRegister(email: String, password: String, isAgreed: Bool) {
        guard !email.isEmpty, !password.isEmpty else { return }
        guard !isAgreed else { return }
    }
}
