//
//  GitHubRepositoryTests.swift
//  GitHubRepositoryTests
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import XCTest
@testable import GitHubRepository

class RepositoryCacheManagerTests: XCTestCase {
    
    var cacheManager: RepositoryCacheManager!
    
    override func setUp() {
        super.setUp()
        cacheManager = RepositoryCacheManager.shared
        cacheManager.setEmptyLists()
    }
    
    func testDeleteRepository() {
        // Given
        let repoToDelete = RepositoryUIModel(name: "isim", owner: OwnerUIModel(login: "", avatarURL: ""), htmlURL: "https://github.com/test-repo", description: "", createdAt: "", stargazersCount: "", language: "", forks: "", isDeleted: false, isVisited: false)
        cacheManager.appendRepositoryUIModelList(uiModel: repoToDelete)
        cacheManager.appendShowingRepositoryUIModelList(uiModel: repoToDelete)
        
        // When
        cacheManager.deleteRepository("https://github.com/test-repo")
        
        // Then
        XCTAssertTrue(cacheManager.isDeleted("https://github.com/test-repo"))
        XCTAssertTrue(cacheManager.getshowingRepositoryUIModelList().isEmpty)
    }
    
    func testVisiteRepository() {
        // Given
        let repoToVisit = RepositoryUIModel(name: "isim", owner: OwnerUIModel(login: "", avatarURL: ""), htmlURL: "https://github.com/test-repo", description: "", createdAt: "", stargazersCount: "", language: "", forks: "", isDeleted: false, isVisited: false)
        cacheManager.appendRepositoryUIModelList(uiModel: repoToVisit)
        cacheManager.appendShowingRepositoryUIModelList(uiModel: repoToVisit)
        
        // When
        cacheManager.visiteRepository(0)
        
        // Then
        XCTAssertTrue(cacheManager.isVisited("https://github.com/test-repo"))
        XCTAssertTrue(cacheManager.getshowingRepositoryUIModelList()[0].isVisited)
    }
    
    func testSetEmptyLists() {
        // Given
        let repoToAdd = RepositoryUIModel(name: "isim", owner: OwnerUIModel(login: "", avatarURL: ""), htmlURL: "https://github.com/test-repo", description: "", createdAt: "", stargazersCount: "", language: "", forks: "", isDeleted: false, isVisited: false)
        cacheManager.appendRepositoryUIModelList(uiModel: repoToAdd)
        cacheManager.appendShowingRepositoryUIModelList(uiModel: repoToAdd)
        
        // When
        cacheManager.setEmptyLists()
        
        // Then
        XCTAssertTrue(cacheManager.getRepositoryUIModelListCount() == 0)
        XCTAssertTrue(cacheManager.getshowingRepositoryUIModelList().isEmpty)
    }
    
    func testAppendRepositoryUIModelList() {
        // Given
        let repoToAdd = RepositoryUIModel(name: "isim", owner: OwnerUIModel(login: "", avatarURL: ""), htmlURL: "https://github.com/test-repo", description: "", createdAt: "", stargazersCount: "", language: "", forks: "", isDeleted: false, isVisited: false)
        
        // When
        cacheManager.appendRepositoryUIModelList(uiModel: repoToAdd)
        
        // Then
        XCTAssertTrue(cacheManager.getRepositoryUIModelListCount() == 1)
        XCTAssertTrue(cacheManager.getshowingRepositoryUIModelList().isEmpty)
    }
    
    func testAppendShowingRepositoryUIModelList() {
        // Given
        let repoToAdd = RepositoryUIModel(name: "isim", owner: OwnerUIModel(login: "", avatarURL: ""), htmlURL: "https://github.com/test-repo", description: "", createdAt: "", stargazersCount: "", language: "", forks: "", isDeleted: false, isVisited: false)
        
        // When
        cacheManager.appendShowingRepositoryUIModelList(uiModel: repoToAdd)
        
        // Then
        XCTAssertTrue(cacheManager.getshowingRepositoryUIModelList().count == 1)
        XCTAssertTrue(cacheManager.getRepositoryUIModelListCount() == 0)
    }
    
    func testSetRepositoryUIModelList() {
        // Given
        let repo1 = RepositoryUIModel(name: "isim1", owner: OwnerUIModel(login: "", avatarURL: ""), htmlURL: "https://github.com/test-repo", description: "", createdAt: "", stargazersCount: "", language: "", forks: "", isDeleted: false, isVisited: false)
        let repo2 = RepositoryUIModel(name: "isim2", owner: OwnerUIModel(login: "", avatarURL: ""), htmlURL: "https://github.com/test-repo", description: "", createdAt: "", stargazersCount: "", language: "", forks: "", isDeleted: false, isVisited: false)
        
        // When
        cacheManager.setRepositoryUIModelList(list: [repo1, repo2])
        
        // Then
        XCTAssertTrue(cacheManager.getRepositoryUIModelListCount() == 2)
        XCTAssertTrue(cacheManager.getshowingRepositoryUIModelList().isEmpty)
    }
}

