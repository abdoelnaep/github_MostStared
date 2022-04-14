//
//  RepositoriesModel.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import Foundation


//struct Repository: Codable {
//    let name: String?
//}


//struct Repositories:Codable{
//    let repoElement:items
//}
//
//
struct repos:Codable{
    let items:[repoElement]
}

struct repoElement:Codable{
    let name:String?
    let description:String?
    let stargazers_count:Int?
    let open_issues_count:Int?
    let updated_at:String?
    let created_at:String?
    let owner:ownerData

}

struct ownerData:Codable{
    let login:String?
    let avatar_url:String?
}







//
//struct ReposList: Codable{
//
//    let items: [Repo]
//
//}
//
//struct Repo: Codable{
//    let name: String
//    let fullName: String
//    let owner: Owner
//    //let description: String
//    let stargazersCount: Int
//    let openIssuesCount: Int
//    let createdAt: String
//    enum CodingKeys: String, CodingKey {
//        case name
//        case fullName = "full_name"
//        case owner
//        //case description = "description"
//        case stargazersCount = "stargazers_count"
//
//        case openIssuesCount = "open_issues_count"
//        case createdAt = "created_at"
//    }
//
//}
//
//struct Owner: Codable {
//
//    let avatarURL: String
//
//    enum CodingKeys: String, CodingKey {
//
//        case avatarURL = "avatar_url"
//
//    }
//}
