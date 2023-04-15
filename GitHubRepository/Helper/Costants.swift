//
//  Costants.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import Foundation

struct Constants {
    
    static let baseRepositoryUrl = "https://api.github.com/search/repositories"

    static func getLanguage(language: Language) -> String {
        return language.rawValue
    }
}

public enum Language: String {
    
    case eng = "en-US"
}
