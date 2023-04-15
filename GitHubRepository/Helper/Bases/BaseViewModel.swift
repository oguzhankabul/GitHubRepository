//
//  BaseViewModel.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import UIKit

protocol BaseViewModelProtocol {
    
    func viewDidLoad()
}

class BaseViewModel<R: Router>: BaseViewModelProtocol {

    let router: R
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    init(router: R) {
        self.router = router
    }
    
    func viewDidLoad() {}

    deinit {
        debugPrint("deinit \(self)")
    }
}
