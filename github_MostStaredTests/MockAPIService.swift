//
//  MockAPIService.swift
//  github_MostStaredTests
//
//  Created by Abdullah on 23/04/2022.
//

import Foundation
@testable import github_MostStared

class MockApiService: APIProtocol{
    func getRepositories(pageNum:String,past30Days:String,completion: @escaping(Result<Repos, Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=created:%3E\(past30Days)&sort=stars&order=desc&page=\(pageNum)&per_page=100")
//        guard let url = URL(string: "https://api.github.com/repositories")
        else { return }
        print(url)
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            guard let data = data else {
                return
            }
            do {
//                let decoder = JSONDecoder()
                let response = try? JSONDecoder().decode(Repos.self, from: data)
                guard let response = response else {
                    return
                }

                completion(.success(response))
                
            }
            
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
