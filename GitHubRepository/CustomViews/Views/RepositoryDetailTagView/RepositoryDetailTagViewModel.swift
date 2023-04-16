//
//  RepositoryDetailTagViewModel.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 16.04.2023.
//

import UIKit

final class RepositoryDetailTagViewModel {
    
    public var tagLabel: String
    public var image: UIImage
    
    public init(tagLabel: String, image: UIImage) {
        self.tagLabel = tagLabel
        self.image = image
    }
}
