//
//  APIService.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import Foundation
class APIService {
    static let sharedService = APIService()
    func getRepositories(pageNum:Int,past30Days:String,completion: @escaping (_ repositories: repos?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=created:%3E\(past30Days)+language:swift&sort=stars&order=desc&page=\(pageNum)")
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
                let decoder = JSONDecoder()
                let response = try decoder.decode(repos.self, from: data)
//                print(response)
                completion(response, nil)
            }
            
            catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}


//"https://api.github.com/repositories"
//                https://api.github.com/search/repositories?q=created:%3E2017-10-22&sort=stars&ord%20er=desc


//https://api.github.com/search/repositories?q=created:%3E2022-03-15+language:swift&sort=stars&ord%20er=desc&page=1
