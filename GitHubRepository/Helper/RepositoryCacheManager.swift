//
//  RepositoryCacheManager.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 16.04.2023.
//

import Foundation

final class RepositoryCacheManager {
    
    static let shared = RepositoryCacheManager()
    
    private var deletedRepositories: Set<String> = Set()
    private var visitedRepositories: Set<String> = Set()
    
    private var repositoryUIModelList: [RepositoryUIModel] = []
    private var showingRepositoryUIModelList: [RepositoryUIModel] = []
    
    private init() {
        if let deletedRepositories = UserDefaults.standard.stringArray(forKey: "deletedRepositories") {
            self.deletedRepositories = Set(deletedRepositories)
        }
        
        if let visitedRepositories = UserDefaults.standard.stringArray(forKey: "visitedRepositories") {
            self.visitedRepositories = Set(visitedRepositories)
        }
    }
    
    func deleteRepository(_ htmlURL: String) {
        repositoryUIModelList.mutateEach { repositoryUiModel in
            if repositoryUiModel.htmlURL == htmlURL {
                repositoryUiModel.isDeleted = true
            }
            
            deletedRepositories.insert(htmlURL)
            UserDefaults.standard.set(Array(deletedRepositories), forKey: "deletedRepositories")
        }
        showingRepositoryUIModelList.removeAll(where: { $0.htmlURL == htmlURL })
    }
    
    func visiteRepository(_ index: Int) {
        visitedRepositories.insert(showingRepositoryUIModelList[index].htmlURL)
        showingRepositoryUIModelList[index].isVisited = true
        UserDefaults.standard.set(Array(visitedRepositories), forKey: "visitedRepositories")
    }
    
    func isDeleted(_ htmlURL: String) -> Bool{
        return deletedRepositories.contains(htmlURL)
    }
    
    func isVisited(_ htmlURL: String) -> Bool{
        return visitedRepositories.contains(htmlURL)
    }
    
    func getshowingRepositoryUIModelList() -> [RepositoryUIModel] {
        return showingRepositoryUIModelList
    }
    
    func setEmptyLists() {
        repositoryUIModelList = []
        showingRepositoryUIModelList = []
    }
    
    func getRepositoryUIModelListCount() -> Int {
        return repositoryUIModelList.count
    }
    
    func appendRepositoryUIModelList(uiModel: RepositoryUIModel) {
        self.repositoryUIModelList.append(uiModel)
    }
    
    func appendShowingRepositoryUIModelList(uiModel: RepositoryUIModel) {
        self.showingRepositoryUIModelList.append(uiModel)
    }
    
    func setRepositoryUIModelList(list: [RepositoryUIModel]) {
        self.repositoryUIModelList = list
    }
    
    func setShowingRepositoryUIModelList(list: [RepositoryUIModel]) {
        self.showingRepositoryUIModelList = list
    }
}
