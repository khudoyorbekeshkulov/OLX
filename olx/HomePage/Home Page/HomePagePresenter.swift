//  
//  HomePagePresenter.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 03/11/26.
//

import Foundation

protocol HomePageView: AnyObject {
    func updateSquareBackground()
}

protocol HomePagePresenter {
    func viewDidLoad()
}

private enum Constants {
    static let squareBackgroundChangeTimeout: DispatchTime = .now() + 2.0
}

class HomePagePresenterImpl: HomePagePresenter {
    
    private weak var view: HomePageView?
    private let router: HomePageRouter
    
    init(view: HomePageView, router: HomePageRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        updateSqaureBackground()
    }
}

private extension HomePagePresenterImpl {
    func updateSqaureBackground() {
        DispatchQueue.main.asyncAfter(deadline: Constants.squareBackgroundChangeTimeout) {
            self.view?.updateSquareBackground()
        }
    }
}
