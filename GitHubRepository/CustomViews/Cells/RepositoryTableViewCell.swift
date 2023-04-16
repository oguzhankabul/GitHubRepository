//
//  RepositoryTableViewCell.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import UIKit

final class RepositoryTableViewCell: BaseTableViewCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = .avatarHeightWidth/2
        imageView.image = .defaultAvatar
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .icChevronRight
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        contentView.addSubviews([profileImageView, titleLabel, nameLabel, descriptionLabel, arrowImageView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        profileImageView.anchor(leading: contentView.leadingAnchor, paddingTop: .xlPad, paddingBottom: .xlPad, paddingLeft: .lPad, width: .avatarHeightWidth, height: .avatarHeightWidth, centerY: contentView.centerYAnchor)

        titleLabel.anchor(top: contentView.topAnchor, leading: profileImageView.trailingAnchor, trailing: arrowImageView.leadingAnchor, paddingTop: .xlPad, paddingLeft: .lPad, paddingRight: .xsPad)

        nameLabel.anchor(top: titleLabel.bottomAnchor, leading: profileImageView.trailingAnchor, trailing: arrowImageView.leadingAnchor, paddingTop: .xsPad, paddingLeft: .lPad, paddingRight: .xsPad)

        descriptionLabel.anchor(top: nameLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: profileImageView.trailingAnchor, trailing: arrowImageView.leadingAnchor, paddingTop: .sPad, paddingBottom: .xlPad, paddingLeft: .lPad, paddingRight: .xsPad)

        arrowImageView.anchor(trailing: contentView.trailingAnchor, paddingRight: .mPad, width: .arrowHeightWidth, height: .arrowHeightWidth, centerY: contentView.centerYAnchor)
    }
    
    public func set(_ cellModel: RepositoryTableViewCellModel) {
        titleLabel.text = cellModel.title
        nameLabel.text = cellModel.name
        descriptionLabel.text = cellModel.description
        
        cellModel.loadImage { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.profileImageView.image = image ?? .defaultAvatar
            }
        }
    }
}
