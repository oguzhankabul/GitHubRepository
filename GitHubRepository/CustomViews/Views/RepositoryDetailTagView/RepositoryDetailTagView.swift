//
//  RepositoryDetailTagView.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 16.04.2023.
//

import UIKit

final class RepositoryDetailTagView: BaseView {
    
    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let borderLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubviews([tagImageView, tagLabel, borderLineView])
        setupLayout()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tagImageView.anchor(leading: leadingAnchor, paddingLeft: .xlPad, width: .tagImageHeightWidth, height: .tagImageHeightWidth, centerY: tagLabel.centerYAnchor)
        
        tagLabel.anchor(top: topAnchor, leading: tagImageView.trailingAnchor, trailing: trailingAnchor, paddingTop: .lPad, paddingLeft: .lPad, paddingRight: .mPad)
        
        borderLineView.anchor(top: tagLabel.bottomAnchor, bottom: bottomAnchor, leading: tagLabel.leadingAnchor, trailing: trailingAnchor, paddingTop: .xlPad, paddingBottom: .xlPad, paddingRight: .xlPad, height: 1)
    }
    
    public func set(_ viewModel: RepositoryDetailTagViewModel) {
        tagImageView.image = viewModel.image
        tagLabel.text = viewModel.tagLabel
    }
    
}
