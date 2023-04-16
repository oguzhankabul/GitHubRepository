//
//  RepositoryListFooterLoadingTableReusableView.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 16.04.2023.
//

import UIKit

class TableFooterLoadingView: UITableViewHeaderFooterView {
    
    static let identifier = String(describing: TableFooterLoadingView.self)
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = .black
        return spinner
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(spinner)
        spinner.anchor(centerX: self.centerXAnchor, centerY: self.centerYAnchor)
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
    
    public func stopAnimating() {
        spinner.stopAnimating()
    }
}
