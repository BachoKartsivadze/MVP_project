//
//  GithubUsersPresenter.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 20.07.23.
//

import Foundation
import UIKit

protocol GithubUsersView: AnyObject {
    func reloadList()
}

protocol GithubUsersPresenter {
    func viewDidLoad()
    var numberOfSections: Int { get }
    func number0fRows (in section: Int) -> Int
    func headerIdentifier(of section: Int) -> String
    func rowIdentifier(at indexPath: IndexPath) -> String
    func configure (header: ConfigurableCell, in section: Int)
    func configure (row: ConfigurableCell, at indexPath: IndexPath)
}

class GithubUsersPresenterImp1: GithubUsersPresenter {
    
    private weak var view: GithubUsersView?
    private var router: GithubUsersRouter
    
    private var users: [GithubUser] = [] {
        didSet {
            view?.reloadList()
        }
    }
    
    private var usersUseCase: GithubUsersUseCase
    
    private var listDataSource: [SectionModel] {
        return [
            favoritesSection,
            usersSection
        ]
    }
    
    
    private var favoritesSection: SectionModel {
        return SectionModel (
            headerModel: TitleHeader.ViewModel (
                logo: UIImage(named: "gitjub_logo4")!, title: "Favorites"
        ),
            cellModels: []
        )
    }
    
    private var usersSection: SectionModel {
        return SectionModel (
            headerModel: TitleHeader.ViewModel (
                logo: UIImage (named: "gitjub_logo4")!, title: "Users"
            ),
            cellModels: users.map { user in
                GithubUserCellTableViewCell.ViewModel (
                    avatar: user.avatar,
                    username: user.login
                )
            }
        )
    }
    
    
    init(view: GithubUsersView,
         router: GithubUsersRouter,
         usersUseCase: GithubUsersUseCase
    ) {
        self.view = view
        self.router = router
        self.usersUseCase = usersUseCase
    }
    
    func viewDidLoad() {
        usersUseCase.fetchUsers(since: .zero) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.users = users
                users.forEach { user in
                    user.fetchAvatar {
                        self.view?.reloadList()
                    }
                }
            case.failure(let error):
                print (error)
            }
        }
    }
}


extension GithubUsersPresenterImp1 {
    
    var numberOfSections: Int {
        return listDataSource.count
    }
    
    func number0fRows (in section: Int) -> Int {
        return listDataSource[section].cellModels.count
    }
    
    func headerIdentifier(of section: Int) -> String {
        return listDataSource [section].headerModel.cellIdentifier
    }
    
    func rowIdentifier(at indexPath: IndexPath) -> String {
        return listDataSource[indexPath.section].cellModels[indexPath.row].cellIdentifier
    }
    
    func configure (header: ConfigurableCell, in section: Int) {
        header.configure(with: listDataSource [section].headerModel)
    }
    
    func configure (row: ConfigurableCell, at indexPath: IndexPath) {
        row.configure(with: listDataSource[indexPath.section].cellModels[indexPath.row])
    }
    
}
