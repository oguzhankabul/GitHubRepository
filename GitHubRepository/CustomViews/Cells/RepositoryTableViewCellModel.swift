//
//  RepositoryTableViewCellModel.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import UIKit

final class RepositoryTableViewCellModel {
    
    private var imageUrl: String
    public var title: String
    public var name: String
    public var description: String
    public var isVisited: Bool
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: imageUrl) {
            ImageLoader.shared.loadImage(from: url, completion: completion)
        } else {
            completion(.defaultAvatar)
        }
    
    }
    
    public init(imageUrl: String, title: String, name: String, description: String, isVisited: Bool) {
        self.imageUrl = imageUrl
        self.title = title
        self.name = name
        self.description = description
        self.isVisited = isVisited
    }
}
