//
//  GithubUsersGateway.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 19.07.23.
//

import Foundation

typealias GithubUsersGatewayComplition = (_ result: Result<[GithubUser], Error>) -> Void

protocol GithubUsersGateway {
    func fetchUsers(since id: Int, complition: @escaping GithubUsersGatewayComplition)
}

class ApiGithubUsersGateway: GithubUsersGateway {
    func fetchUsers(since id: Int, complition: @escaping GithubUsersGatewayComplition) {
        let url = URL(string: "https://api.github.com/users?%20since=\(id)&per%20paqe=100")!
        
        Fetcher<[ApiGithubUser]>.init(url: url).fetch { result in
            switch result {
            case .success(let users):
                complition(.success(users.compactMap({user in
                    GithubUser(login: user.login, id: user.id, avatar_url: user.avatar_url)
                })))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    
}
