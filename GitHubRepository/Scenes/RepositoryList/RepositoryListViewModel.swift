//
//  RepositoryListViewModel.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import Foundation

final class RepositoryListViewModel: BaseViewModel<RepositoryListRouter> {
    
    private var repositoryTableViewCellModelList: [RepositoryTableViewCellModel] = []
    private var repositoryUIModelList: [RepositoryUIModel] = []
    
    var nextRepositoryPage: Int = 1
    var reloadData: VoidClosure = { }
    var isLoading = false
    var shouldShowLoadMoreIndicator = true
    var searchQuery: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRepositoryList()
    }
}


// MARK: - Request
extension RepositoryListViewModel {
    
    func fetchRepositoryList(completion: VoidClosure? = nil) {
        guard !isLoading else {
            return
        }
        isLoading = true
        Service.shared.execute(RepositoryRequest(page: nextRepositoryPage.toString(), searchText: searchQuery), expecting: Repositories.self) { result in
            switch result {
            case .success(let data):
                let uIModel = RepositoriesUIModel(repositoryList: data)
                self.setRepositoryTableViewCellModelList(uIModel: uIModel)
                self.setRepositoryUIModelList(uIModel: uIModel)
                DispatchQueue.main.async {
                    self.reloadData()
                    if let completion = completion {
                        completion()
                    }
                }
                if (data.totalCount == self.repositoryUIModelList.count) && self.isLoading {
                    self.shouldShowLoadMoreIndicator = false
                    self.isLoading = false
                } else {
                    self.isLoading = false
                    self.shouldShowLoadMoreIndicator = true
                    self.nextRepositoryPage += 1
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Helper
extension RepositoryListViewModel {
    private func setRepositoryTableViewCellModelList(uIModel: RepositoriesUIModel) {
        uIModel.repositoryList?.forEach({ repositoryUiModel in
            repositoryTableViewCellModelList.append(RepositoryTableViewCellModel(imageUrl: repositoryUiModel.owner.avatarURL, title: repositoryUiModel.name, name: repositoryUiModel.owner.login, description: repositoryUiModel.description))
        })
    }
    
    private func setRepositoryUIModelList(uIModel: RepositoriesUIModel) {
        uIModel.repositoryList?.forEach({ repositoryUiModel in
            repositoryUIModelList.append(repositoryUiModel)
        })
    }
    
    func getNumberOfRowsInSection() -> Int {
        return repositoryTableViewCellModelList.count
    }
    
    func getCellModel(indexPath: IndexPath) -> RepositoryTableViewCellModel {
        return repositoryTableViewCellModelList[indexPath.row]
    }
    
    func emptyingLists() {
        repositoryTableViewCellModelList = []
        repositoryUIModelList = []
    }
}

// MARK: - Navigate
extension RepositoryListViewModel {
    
    func pushRepositoryDetail(indexPath: IndexPath) {
        router.pushRepositoryDetail(repository: repositoryUIModelList[indexPath.row])
    }
}
