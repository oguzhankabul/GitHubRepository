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
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            var showingDateValue = L10n.no_date_title
            if let date = dateFormatter.date(from: item.createdAt ?? "") {
                let daysAgo = Calendar.current.dateComponents([.day], from: date, to: Date()).day!
                showingDateValue = "\(daysAgo) day ago at \(dateFormatter.string(from: date).replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: "").prefix(10))"
            }
            
            var showingForksValue = L10n.no_forks_title
            if let forksCount = item.forks?.toString() {
                showingForksValue = "\(forksCount) forks"
            }
            
            var showingStarsValue = L10n.no_star_title
            if let starsCount = item.stargazersCount?.toString() {
                showingStarsValue = "\(starsCount) stars"
            }
            return RepositoryUIModel(name: item.name ?? L10n.repositories_title,
                                     owner: OwnerUIModel(login: item.owner?.login ?? L10n.no_login_title,
                                                         avatarURL: item.owner?.avatarUrl ?? ""),
                                     htmlURL: item.htmlUrl ?? "https://github.com/404",
                                     description: item.description ?? L10n.no_description_title,
                                     createdAt: showingDateValue,
                                     stargazersCount: showingStarsValue,
                                     language: item.language ?? L10n.no_language_title,
                                     forks: showingForksValue)
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
