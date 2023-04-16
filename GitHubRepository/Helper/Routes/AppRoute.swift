//
//  AppRouter.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import UIKit

final class AppRoute {
    
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let router = RepositoryListRouter()
        let vm = RepositoryListViewModel(router: router)
        let vc = RepositoryListViewController(viewModel: vm)
        router.viewController = vc
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

let app = AppContainer()

final class AppContainer {
    let route = AppRoute()
}
