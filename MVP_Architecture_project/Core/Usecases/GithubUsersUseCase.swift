//
//  GithubUsersUseCase.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 19.07.23.
//

import Foundation

typealias GithubUsersUseCaseCompletion = (_ result: Result<[GithubUser], Error>) -> Void

protocol GithubUsersUseCase {
    func fetchUsers(since id: Int, completion: @escaping GithubUsersUseCaseCompletion)
}

class GithubUsersUseCaseImp1: GithubUsersUseCase {
    
    private let gateway: GithubUsersGateway
    
    init (gateway: GithubUsersGateway) {
        self.gateway = gateway
    }
    
    func fetchUsers (since id: Int, completion: @escaping GithubUsersUseCaseCompletion) {
        gateway.fetchUsers(since: id, complition: completion)
        
    }
    
}
