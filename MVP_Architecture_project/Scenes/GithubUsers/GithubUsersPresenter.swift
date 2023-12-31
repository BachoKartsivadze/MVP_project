//
//  GithubUsersPresenter.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 20.07.23.
//

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
    func textForAction(at indexPath: IndexPath) -> String
    func tapFavoriteUnfavorite(at indexPath: IndexPath)
}

class GithubUsersPresenterImp1: GithubUsersPresenter {
    
    private weak var view: GithubUsersView?
    private var router: GithubUsersRouter
    
    private var users: [GithubUser] = [] {
        didSet {
            view?.reloadList()
        }
    }
    
    private var favoriteUsers: [GithubUser] = []
    private var unFavoriteUsers: [GithubUser] = []
    
    private var usersUseCase: GithubUsersUseCase
    private let favoritesUseCase: FavoriteUsersUseCaseImpl
    
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
            cellModels: users.filter({ $0.isFavorite }).map{ user in
                GithubUserCellTableViewCell.ViewModel (
                    avatar: user.avatar,
                    username: user.login
                )
            }
        )
    }
    
    private var usersSection: SectionModel {
        return SectionModel (
            headerModel: TitleHeader.ViewModel (
                logo: UIImage (named: "gitjub_logo4")!, title: "Users"
            ),
            cellModels: users.filter({ !$0.isFavorite }).map{ user in
                GithubUserCellTableViewCell.ViewModel (
                    avatar: user.avatar,
                    username: user.login
                )
            }
        )
    }
    
    
    init(view: GithubUsersView,
         router: GithubUsersRouter,
         usersUseCase: GithubUsersUseCase,
         favoritesUseCase: FavoriteUsersUseCaseImpl
    ) {
        self.view = view
        self.router = router
        self.usersUseCase = usersUseCase
        self.favoritesUseCase = favoritesUseCase
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
                
                self.favoritesUseCase.fetchFavoriteUsers { result in
                    switch result {
                    case .success(let favoritesIds) :
                        self.users.forEach { user in
                            user.isFavorite = favoritesIds.contains(user.id)
                        }
                        case.failure:
                            break
                        }
                    self.setFavouriteUnfavourites()
                        self.view?.reloadList()
                    }
                
            case.failure(let error):
                print (error)
            }
        }
        
    }
    
    func setFavouriteUnfavourites() {
        users.forEach {user in
            if user.isFavorite {
                favoriteUsers.append(user)
            } else {
                unFavoriteUsers.append(user)
            }
        }
    }
    
}


extension GithubUsersPresenterImp1 {
    
    var numberOfSections: Int {
        return listDataSource.count
    }
    
    func number0fRows(in section: Int) -> Int {
        return listDataSource[section].cellModels.count
    }
    
    func headerIdentifier(of section: Int) -> String {
        return listDataSource[section].headerModel.cellIdentifier
    }
    
    func rowIdentifier(at indexPath: IndexPath) -> String {
        return listDataSource[indexPath.section].cellModels[indexPath.row].cellIdentifier
    }
    
    func configure(header: ConfigurableCell, in section: Int) {
        header.configure(with: listDataSource[section].headerModel)
    }
    
    func configure (row: ConfigurableCell, at indexPath: IndexPath) {
        row.configure(with: listDataSource[indexPath.section].cellModels[indexPath.row])
    }
    
    func textForAction(at indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            return "Unfavourite"
        } else {
            return "Favourite"
        }
    }

    
    func tapFavoriteUnfavorite(at indexPath: IndexPath){
        
        if indexPath.section == 0 {
            let user = favoriteUsers[indexPath.row]
            
            favoritesUseCase.makeUnfavoriteUser(id: user.id) {
                
            }
            
            user.isFavorite = false
            unFavoriteUsers.append(favoriteUsers[indexPath.row])
            unFavoriteUsers.sort(by: {$0.id < $1.id}) 
            favoriteUsers.remove(at: indexPath.row)
            
        } else {
            
            let user = unFavoriteUsers[indexPath.row]
            
            favoritesUseCase.makeFavoriteUser(id: user.id) {
                
            }
            
            user.isFavorite = true
            favoriteUsers.append(unFavoriteUsers[indexPath.row])
            favoriteUsers.sort(by: {$0.id < $1.id})
            unFavoriteUsers.remove(at: indexPath.row)
        }
        
        view?.reloadList()
    }
    
}


enum Sections: Int {
    case favorites = 0
    case unfavorites = 1
}
