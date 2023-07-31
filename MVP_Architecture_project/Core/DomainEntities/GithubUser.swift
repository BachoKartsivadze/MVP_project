//
//  GithubUser.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 18.07.23.
//

import UIKit

class GithubUser {
    
    let login: String
    let id: Int
    let avatar_url: String
    
    var avatar: UIImage?
    var isFavorite: Bool = false
    
    init(login: String, id: Int, avatar_url: String) {
        self.login = login
        self.id = id
        self.avatar_url = avatar_url
    }
    
    func fetchAvatar(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: self.avatar_url),
               let data = try? Data (contentsOf: url),
               let image = UIImage (data: data) {
                
                self.avatar = image
                completion()
            }
        }
    }
}

extension GithubUser {
    
    convenience init?(login: String?, id: Int?, avatar_url: String?) {
        
        guard let login = login, let id = id, let avatar_url = avatar_url else { return nil }
        
        self.init(login: login, id: id, avatar_url: avatar_url)
        
    }
}
