//
//  GithubUser.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 18.07.23.
//

import Foundation

class GithubUser {
    
    let login: String
    let id: Int
    let avatar_url: String
    
    init(login: String, id: Int, avatar_url: String) {
        self.login = login
        self.id = id
        self.avatar_url = avatar_url
    }
}

extension GithubUser {
    
    convenience init?(login: String?, id: Int?, avatar_url: String?) {
        
        guard let login = login, let id = id, let avatar_url = avatar_url else { return nil }
        
        self.init(login: login, id: id, avatar_url: avatar_url)
        
    }
}
