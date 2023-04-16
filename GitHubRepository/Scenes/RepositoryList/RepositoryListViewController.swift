//
//  ViewController.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import UIKit

class RepositoryListViewController: BaseViewController<RepositoryListViewModel> {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = .black
        return spinner
    }()
    
    var overlayView: UIView?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let repositoryTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .singleLine
        tv.backgroundColor = .white
        tv.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
        tv.register(TableFooterLoadingView.self, forHeaderFooterViewReuseIdentifier: TableFooterLoadingView.identifier)
        return tv
    }()
    
    var searchQuery: String?
    var searchTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        addOverlay()
        viewModel.viewDidLoad()
        subscribeViewModel()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        repositoryTableView.reloadData()
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubviews([repositoryTableView, spinner])
        configureTableView()
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        spinner.anchor(width: .spinnerHeightWidth, height: .spinnerHeightWidth, centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        repositoryTableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: .sPadNegative, paddingLeft: .lPad, paddingRight: .lPad)
    }
}

// MARK: - UITableViewDelegate
extension RepositoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.visitedSelectedRepository(index: indexPath.row)
        viewModel.pushRepositoryDetail(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension RepositoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.getNumberOfRowsInSection() > 0 {
            let cell: RepositoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let cellModel = viewModel.getCellModel(indexPath: indexPath)
            cell.set(cellModel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - UISearchResultsUpdating
extension RepositoryListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        viewModel.searchQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        addOverlay()
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { [weak self] timer in
            guard let self = self else { return }
            self.viewModel.emptyingLists()
            self.viewModel.nextRepositoryPage = 1
            self.viewModel.fetchRepositoryList {
                self.scrollToTop()
            }
        }
    }
}

// MARK: - Helper
extension RepositoryListViewController {
    
    private func configureTableView() {
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.title = L10n.repositories_title
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController?.searchBar.sizeToFit()
    }
    
    func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.didLoadRepositories()
        }
    }
    
    func didLoadRepositories() {
        removeOverlay()
        repositoryTableView.reloadData()
    }
    
    func showTableFooterLoadingView(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset + scrollViewHeight >= scrollContentSizeHeight && !viewModel.isLoading && viewModel.shouldShowLoadMoreIndicator {
            let footerView = repositoryTableView.dequeueReusableHeaderFooterView(withIdentifier: TableFooterLoadingView.identifier) as! TableFooterLoadingView
            footerView.startAnimating()
            repositoryTableView.tableFooterView = footerView
            viewModel.fetchRepositoryList(completion: { [weak self] in
                guard let _ = self else { return }
                footerView.stopAnimating()
            })
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        showTableFooterLoadingView(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
    
    func scrollToTop() {
        if repositoryTableView.visibleCells.count > 0  && !(repositoryTableView.contentOffset.y == 0) {
            let indexPath = IndexPath(row: 0, section: 0)
            repositoryTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func addOverlay() {
        if overlayView == nil {
            overlayView = UIView(frame: view.bounds)
            overlayView!.backgroundColor = .clear
            view.addSubview(overlayView!)
            spinner.startAnimating()
        }
    }
    
    func removeOverlay() {
        guard let overlay = overlayView else { return }
        overlay.removeFromSuperview()
        overlayView = nil
        spinner.stopAnimating()
    }
}
