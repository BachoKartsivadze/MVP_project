//
//  ToggleFavoriteUserGateway.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 30.07.23.
//

import Foundation

protocol ToggleFavoriteUserGateway {
    
    func makeFavoriteUser(id: Int, completion: @escaping () -> Void)
    
    func makeUnfavoriteUser(id: Int, completion: @escaping () -> Void)
}

class CacheToggleFavoriteUserGateway: ToggleFavoriteUserGateway {
    
    
    private let key = "favorites_key"
    
    
    func makeFavoriteUser(id: Int, completion: @escaping () -> Void) {
        var favoritesUsers = (UserDefaults.standard.array(forKey: key) ?? []) as! [Int]
        favoritesUsers.append(id)
        UserDefaults.standard.set(favoritesUsers, forKey: key)
        
    }
    
    
    func makeUnfavoriteUser(id: Int, completion: @escaping () -> Void) {
        var favoritesUsers = (UserDefaults.standard.array(forKey: key) ?? []) as! [Int]
        favoritesUsers.removeAll(where: { $0 == id })
        UserDefaults.standard.set(favoritesUsers, forKey: key)
    }
}
