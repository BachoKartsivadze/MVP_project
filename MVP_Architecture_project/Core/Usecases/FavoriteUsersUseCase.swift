//
//  FavoriteUsersUseCase.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 30.07.23.
//

import Foundation

protocol FavoriteUsersUseCase {
    func fetchFavoriteUsers (completion: @escaping (_ result: Result<[Int], Error>) -> Void)
    func makeFavoriteUser(id: Int, completion: @escaping () -> Void)
    func makeUnfavoriteUser(id: Int, completion: @escaping () -> Void)
}

class FavoriteUsersUseCaseImpl: FavoriteUsersUseCase {
    private let favoritesGateway: FavoritesUsersGateway
    private let toggleFavoritesGateway: ToggleFavoriteUserGateway

    init(favoritesGateway: FavoritesUsersGateway, toggleFavoritesGateway: ToggleFavoriteUserGateway) {
        self.favoritesGateway = favoritesGateway
        self.toggleFavoritesGateway = toggleFavoritesGateway
    }
    
    func fetchFavoriteUsers (completion: @escaping (_ result: Result<[Int], Error>) -> Void) {
        favoritesGateway.fetchFavoriteUsers(completion: completion)
    }
    
    func makeFavoriteUser(id: Int, completion: @escaping () -> Void) {
        toggleFavoritesGateway.makeFavoriteUser(id: id, completion: completion)
    }
    
    func makeUnfavoriteUser(id: Int, completion: @escaping () -> Void) {
        toggleFavoritesGateway.makeUnfavoriteUser(id: id, completion: completion)
    }
}
