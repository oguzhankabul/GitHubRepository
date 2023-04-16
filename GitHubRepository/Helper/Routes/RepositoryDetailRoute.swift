//
//  RepositoryDetailRoute.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import Foundation

protocol RepositoryDetailRoute {
    
    func pushRepositoryDetail(repository: RepositoryUIModel)
}

extension RepositoryDetailRoute where Self: RouterProtocol {
    
    func pushRepositoryDetail(repository: RepositoryUIModel) {
        let router = RepositoryDetailRouter()
        let viewModel = RepositoryDetailViewModel(router: router, repository: repository)
        let viewController = RepositoryDetailViewController(viewModel: viewModel)
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        open(viewController, transition: transition)
        
    }
}
