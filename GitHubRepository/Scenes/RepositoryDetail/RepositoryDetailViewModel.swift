//
//  RepositoryDetailViewModel.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 16.04.2023.
//

import Foundation

final class RepositoryDetailViewModel: BaseViewModel<RepositoryDetailRouter> {
    
    private let repository: RepositoryUIModel
    
    init(router: RepositoryDetailRouter, repository: RepositoryUIModel) {
        self.repository = repository
        super.init(router: router)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getTitle() -> String {
        return repository.name
    }
    
    func getDescription() -> String {
        return repository.description
    }
    
    func getLanguage() -> String {
        return repository.language
    }
    
    func getForksCount() -> String {
        return repository.forks
    }
    
    func getStarCount() -> String {
        return repository.stargazersCount
    }
    
    func getCreateDate() -> String {
        return repository.createdAt
    }
    
    func getGithubUrl() -> String {
        return repository.htmlURL
    }
}
