//
//  BaseTableViewCell.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayout()
    }
    
    open func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    open func setupLayout() {}
}

// MARK: - Default implementation
extension BaseTableViewCell: Reuse {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - Get Reuse Identifier
public protocol Reuse: AnyObject {
    static var reuseIdentifier: String { get }
}
