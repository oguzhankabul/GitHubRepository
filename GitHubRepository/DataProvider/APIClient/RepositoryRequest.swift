//
//  RepositoryRequest.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import Foundation

final class RepositoryRequest {
    
    private let queryParameters: [URLQueryItem]
    
    public var url: URL? {
        let endpoint = Constants.baseRepositoryUrl
        var urlComponents = URLComponents(string: endpoint)!
        urlComponents.queryItems = queryParameters
        return urlComponents.url
    }
    
    public let httpMethod = "GET"
    
    public init(page: String, searchText: String? = nil) {
        let currentDate = Date()
        let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let created = "created:\(dateFormatter.string(from: oneMonthAgo) + ".." + dateFormatter.string(from: currentDate))"
        let sort = "stars"
        let order = "desc"
        let perPage = "20"
        var queryParameters = [
            URLQueryItem(name: "q", value: "\(created)"),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "per_page", value: perPage),
            URLQueryItem(name: "page", value: page)
        ]
        if searchText != nil && searchText != "" {
            queryParameters[0] = URLQueryItem(name: "q", value: "\(searchText!)+\(created)")
        }
        self.queryParameters = queryParameters
    }
}
