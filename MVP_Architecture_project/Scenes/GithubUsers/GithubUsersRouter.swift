//
//  GithubUsersRouter.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 20.07.23.
//

import Foundation

protocol GithubUsersRouter {
    
}

class GithubUsersRouterImp1: GithubUsersRouter {
    
    private weak var controller: GithubUsersController?
    
    init(_ controller: GithubUsersController?) {
        self.controller = controller
    }
}
