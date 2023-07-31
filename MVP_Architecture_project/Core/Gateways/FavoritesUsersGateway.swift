//
//  FavoritesUsersGateway.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 30.07.23.
//

import Foundation

protocol FavoritesUsersGateway {
    func fetchFavoriteUsers (completion: @escaping (_ result: Result<[Int], Error>) -> Void)
    
}


class CacheFavoritesUsersGateway: FavoritesUsersGateway {
    private let key = "favorites_key"
    
    
    func fetchFavoriteUsers (completion: @escaping (Result<[Int], Error>) -> Void) {
        
        completion(.success ( (UserDefaults.standard.array (forKey: key) ?? []) as! [Int]))
    }
}
