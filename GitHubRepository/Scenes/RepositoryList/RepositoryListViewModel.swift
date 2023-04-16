//
//  RepositoryListViewModel.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import Foundation

final class RepositoryListViewModel: BaseViewModel<RepositoryListRouter> {
    
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
                self.setRepositoryUIModelList(uIModel: uIModel)
                DispatchQueue.main.async {
                    self.reloadData()
                    if let completion = completion {
                        completion()
                    }
                }
                if (data.totalCount == RepositoryCacheManager.shared.getRepositoryUIModelListCount()) && self.isLoading {
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
    
    private func setRepositoryUIModelList(uIModel: RepositoriesUIModel) {
        uIModel.repositoryList?.forEach({ repositoryUiModel in
            RepositoryCacheManager.shared.appendRepositoryUIModelList(uiModel: repositoryUiModel)
        })
        
        uIModel.repositoryList?.forEach({ repositoryUiModel in
            if !repositoryUiModel.isDeleted {
                RepositoryCacheManager.shared.appendShowingRepositoryUIModelList(uiModel: repositoryUiModel)
            }
        })
    }
    
    func getNumberOfRowsInSection() -> Int {
        return RepositoryCacheManager.shared.getshowingRepositoryUIModelList().count
    }
    
    func getCellModel(indexPath: IndexPath) -> RepositoryTableViewCellModel {
        let relatedRepositoryUIModel = RepositoryCacheManager.shared.getshowingRepositoryUIModelList()[indexPath.row]
        return RepositoryTableViewCellModel(imageUrl: relatedRepositoryUIModel.owner.avatarURL,
                                            title: relatedRepositoryUIModel.name,
                                            name: relatedRepositoryUIModel.owner.login,
                                            description: relatedRepositoryUIModel.description,
                                            isVisited: relatedRepositoryUIModel.isVisited)
    }
    
    func emptyingLists() {
        RepositoryCacheManager.shared.setEmptyLists()
    }
    
    func deletedSelectedRepository(htmlUrl: String) {
        RepositoryCacheManager.shared.deleteRepository(htmlUrl)
    }
    
    func visitedSelectedRepository(index: Int) {
        RepositoryCacheManager.shared.visiteRepository(index)
    }
}

// MARK: - Navigate
extension RepositoryListViewModel {
    
    func pushRepositoryDetail(indexPath: IndexPath) {
        router.pushRepositoryDetail(repository: RepositoryCacheManager.shared.getshowingRepositoryUIModelList()[indexPath.row])
    }
}
