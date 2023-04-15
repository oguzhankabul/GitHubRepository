//
//  RepositoryPresentation.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import Foundation

struct RepositoriesUIModel {
    let repositoryList: [RepositoryUIModel]?
    
    init(repositoryList: Repositories) {
        self.repositoryList = repositoryList.items?.map({ item in
            return RepositoryUIModel(name: item.name ?? "name not found",
                                     owner: OwnerUIModel(login: item.owner?.login ?? "login not found",
                                                         avatarURL: item.owner?.avatarUrl ?? ""),
                                     htmlURL: item.htmlUrl ?? "https://github.com/404",
                                     description: item.description ?? "description not found",
                                     createdAt: item.createdAt ?? "date not found",
                                     stargazersCount: item.stargazersCount?.toString() ?? "star count not found",
                                     language: item.language ?? "language not found",
                                     forks: item.forks?.toString() ?? "forks not found")
        })
    }
}

// MARK: - Item
struct RepositoryUIModel: Codable {
    let name: String
    let owner: OwnerUIModel
    let htmlURL: String
    let description: String
    let createdAt: String
    let stargazersCount: String
    let language: String
    let forks: String
}

// MARK: - Owner
struct OwnerUIModel: Codable {
    let login: String
    let avatarURL: String
}
