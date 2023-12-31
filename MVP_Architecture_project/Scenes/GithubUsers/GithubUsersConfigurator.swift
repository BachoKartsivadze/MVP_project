//
//  GithubUsersConfigurator.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 20.07.23.
//

import Foundation

protocol GithubUsersConfigurator {
    func configure(_ controller: GithubUsersController)
}

class GithubUsersConfiguratorImpl: GithubUsersConfigurator {
    
    func configure(_ controller: GithubUsersController) {
        let router: GithubUsersRouter = GithubUsersRouterImp1(controller)
        
        let usersGateway: GithubUsersGateway = ApiGithubUsersGateway()
        let usersUseCase: GithubUsersUseCase = GithubUsersUseCaseImp1(gateway: usersGateway)
        
        let favoritesGateway = CacheFavoritesUsersGateway()
        let toggleGateway = CacheToggleFavoriteUserGateway()
        let favoritesUseCase = FavoriteUsersUseCaseImpl(
        favoritesGateway: favoritesGateway, toggleFavoritesGateway: toggleGateway
        )
        
        let presenter: GithubUsersPresenter = GithubUsersPresenterImp1(
            view: controller,
            router: router,
            usersUseCase: usersUseCase,
            favoritesUseCase: favoritesUseCase
            )
        
        controller.presenter = presenter
    }
    
    
}
