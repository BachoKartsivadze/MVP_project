//
//  ApiGithubUser.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 18.07.23.
//

import Foundation

struct ApiGithubUser: Codable {
    let login: String?
    let id: Int?
    let avatar_url: String?
    
//    enum CodingKeys: String, CodingKey {
//        case avatar_url = "avatar_url"
//        case id, login
//    }
}
