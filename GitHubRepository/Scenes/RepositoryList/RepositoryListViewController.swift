//
//  ViewController.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import UIKit

class RepositoryListViewController: BaseViewController<RepositoryListViewModel> {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .red
        Service.shared.execute(RepositoryRequest(page: "1"), expecting: Repositories.self) { result in
            switch result {
            case .success(let data):
                let uiModel = RepositoriesUIModel(repositoryList: data)
                uiModel.repositoryList?.forEach({ model in
                    print(model.owner.avatarURL)
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

