//
//  RepositoryDetailViewController.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 16.04.2023.
//

import UIKit

final class RepositoryDetailViewController: BaseViewController<RepositoryDetailViewModel> {
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let firstCoupleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let languageTagView = RepositoryDetailTagView()
    
    let forksCountTagView = RepositoryDetailTagView()
    
    private let secondCoupleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let starsCountTagView = RepositoryDetailTagView()
    
    let createDateTagView = RepositoryDetailTagView()
    
    private let githubButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.open_in_github_title, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = .buttonHeigh/6
        button.layer.masksToBounds = true
        button.addTarget(nil, action: #selector(githubButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setNavigationItems()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStackViewVerticalStatus()
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        firstCoupleStackView.addArrangedSubview(languageTagView)
        firstCoupleStackView.addArrangedSubview(forksCountTagView)
        secondCoupleStackView.addArrangedSubview(starsCountTagView)
        secondCoupleStackView.addArrangedSubview(createDateTagView)
        contentView.addSubviews([descriptionLabel, firstCoupleStackView, secondCoupleStackView, githubButton])
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        scrollView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        contentView.anchor(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor)
        descriptionLabel.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, paddingTop: .xlPad, paddingLeft: .lPad, paddingRight: .lPad)
        firstCoupleStackView.anchor(top: descriptionLabel.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, paddingTop: .xlPad)
        secondCoupleStackView.anchor(top: firstCoupleStackView.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor)
        githubButton.anchor(top: secondCoupleStackView.bottomAnchor, bottom: scrollView.bottomAnchor, width: .buttonWidth, height: .buttonHeigh, centerX: scrollView.centerXAnchor)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.width)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setStackViewVerticalStatus()
    }
    
    private func setData() {
        descriptionLabel.text = viewModel.getDescription()
        languageTagView.set(RepositoryDetailTagViewModel(tagLabel: viewModel.getLanguage(), image: .icLanguage))
        forksCountTagView.set(RepositoryDetailTagViewModel(tagLabel: viewModel.getForksCount(), image: .icForks))
        starsCountTagView.set(RepositoryDetailTagViewModel(tagLabel: viewModel.getStarCount(), image: .icStars))
        createDateTagView.set(RepositoryDetailTagViewModel(tagLabel: viewModel.getCreateDate(), image: .icTimer))
    }
    
    // MARK: - Helper
    
    @objc private func githubButtonTapped() {
        if let url = URL(string: viewModel.getGithubUrl()) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func deleteButtonTapped() {
        let alertController = UIAlertController(title: L10n.are_you_sure_title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.delete_button_title, style: .destructive) { _ in
            self.viewModel.back()
           }
        let cancelAction = UIAlertAction(title: L10n.cancel_button_title, style: .cancel, handler: nil)
           alertController.addAction(okAction)
           alertController.addAction(cancelAction)
           present(alertController, animated: true, completion: nil)
    }
    
    private func setStackViewVerticalStatus() {
        let isPortrait = traitCollection.verticalSizeClass == .compact
        if isPortrait {
            firstCoupleStackView.axis = .horizontal
            secondCoupleStackView.axis = .horizontal
        } else {
            firstCoupleStackView.axis = .vertical
            secondCoupleStackView.axis = .vertical
        }
    }
    
    private func setNavigationItems() {
        navigationItem.title = viewModel.getTitle()
        let deleteButton = UIBarButtonItem(title: L10n.delete_button_title, style: .plain, target: self, action: #selector(deleteButtonTapped))
        navigationItem.rightBarButtonItem = deleteButton
    }
}
