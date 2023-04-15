//
//  Repositories.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import Foundation

struct Repositories: Codable {
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let name: String?
    let owner: Owner?
    let htmlUrl: String?
    let description: String?
    let createdAt: String?
    let stargazersCount: Int?
    let language: String?
    let forks: Int?
}

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let avatarUrl: String?
}
