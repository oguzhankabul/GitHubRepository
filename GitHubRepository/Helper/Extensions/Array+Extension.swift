//
//  File.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 16.04.2023.
//

import Foundation

public extension Array {
    mutating func mutateEach(by transform: (inout Element) throws -> Void) rethrows {
        self = try map { el in
            var el = el
            try transform(&el)
            return el
        }
    }
}
