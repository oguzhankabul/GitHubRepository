//
//  ReusableView.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import UIKit

public protocol ReusableView: AnyObject {
    
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
