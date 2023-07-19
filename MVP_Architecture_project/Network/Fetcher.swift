//
//  Fetcher.swift
//  MVP_Architecture_project
//
//  Created by bacho kartsivadze on 18.07.23.
//

import Foundation

class Fetcher<Response: Decodable> {
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func fetch(complition: @escaping (_ result: Result<Response,Error>) -> Void){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                complition(.failure(error!))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                complition(.failure(InvalidResponse()))
                return
            }
            
            guard let data = data else {
                complition(.failure(NoDataError()))
                return
            }
            
            if let response = try? JSONDecoder().decode(Response.self, from: data) {
                complition(.success(response))
            } else {
                complition(.failure(ParsingError()))
            }
        }
        task.resume()
    }
}



// errors

struct InvalidResponse: Error {
    
}

struct NoDataError: Error {
    
}

struct ParsingError: Error {
    
}
